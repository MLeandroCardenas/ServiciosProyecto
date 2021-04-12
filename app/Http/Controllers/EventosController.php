<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Notifications\NuevoEvento;
use App\Notifications\EventoAprobado;
use App\Notifications\EventoDescartado;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Config;
use Carbon\Carbon;
use App\Eventos;
use App\MHorario;
use App\Usuarios;
use App\User;
use Validator;

class EventosController extends Controller
{
    public function obtenerRangosHorarios($horaActual){
        if($horaActual == 'undefined') {
            $horas = DB::table('rangos_horarios')->select('hora')->get();
            return response()->json($horas,200);
        } else {
            $horaSeleccionada = intval($horaActual + 2);
            $horaSiguiente = $horaSeleccionada + 1;
            $horaInicio = strval($horaSeleccionada).':00'.' a '.$horaSiguiente.':00';
            $horas = DB::table('rangos_horarios')->whereBetween('hora',[$horaInicio, '21:00 a 22:00'])->select('hora')->get();
            return response()->json($horas,200);
        }
    }

    public function verificarCruces($resultado, $horarioPendiente){
        $cadenaResultado = $resultado->toJson();
            $cadenaLimpia = str_replace('\\', '', $cadenaResultado);
            $fecha = null;
            $hora = null;
            foreach($horarioPendiente as $valor){
                $fecha = $valor['fecha'];
                foreach($valor['hora'] as $valorDos){
                    $hora = $valorDos;
                    if(str_contains($cadenaLimpia, $fecha) && str_contains($cadenaLimpia, $hora)){
                        return true;
                    } else 
                        continue; 
                }
            }
    }

    public function verificarEventosAprobados($idZona, $horario){
        $resultado = DB::table('eventos')->where([
            ['estado', '=', 1],
            ['zona', '=', $idZona],
            ['creador_evento', '=', Auth::id()]
        ])->select('horario')->get();

        if($resultado->isEmpty())
            return true;
        if($this->verificarCruces($resultado, $horario) === true)
            return false;
    }

    public function notificacionEventoAprobado($evento){
        $notificacion = User::find($evento->creador_evento);
        $notificacion->notify(
            new EventoAprobado($evento->nombre_evento)
        );
    }

    public function crearEvento(Request $request)
    {
        $validador = Validator::make($request->all(), [
            'nombre_evento'=>'required|max:50',
            'descripcion'=>'required|max:100',
            'zona'=>'required',
            'visibilidad'=>'required',
            'horario'=>'required'
        ]);

        if($validador->fails()){
            return response()->json($validador->errors(),422);
        } else if($this->verificarEventosAprobados($request->zona, json_decode($request->horario, true)) === false){
            return response()->json('Ya hay eventos en el mismo horario aprobados', 400);
        } else{
            $evento = new Eventos;
            $evento->creador_evento = Auth::id();
            $evento->zona = $request->zona;
            $evento->nombre_evento = $request->nombre_evento;
            $evento->descripcion = $request->descripcion;
            $evento->visibilidad = $request->visibilidad;
            $evento->horario = $request->horario;
            $evento->estado = 3;
            $evento->save();
            return response()->json('Evento creado exitosamente', 201);
        }
    }

    public function solicitarAprobacionEvento($idEvento)
    {
        

        $datosUsuario = Usuarios::where('usuarios.id_user', '=', Auth::id())
                        ->join('roles', 'roles.id', '=', 'usuarios.id_rol')
                        ->select('usuarios.nombres', 'usuarios.apellidos', 'roles.rol')
                        ->first();
        
        $usuarioArray = $datosUsuario->toArray();

        $resultado = Usuarios::where('usuarios.id_rol', '=', 1)
                    ->join('users', 'users.id', '=', 'usuarios.id_user')
                    ->select('users.id')->first();
                        
        $arrayResultados = $resultado->toArray();
        $idUsuarioDestino = $arrayResultados['id'];
        $usuario = User::find($idUsuarioDestino);

        $evento = Eventos::find($idEvento);
        $evento->estado = 6;
        $evento->save();

        $usuario->notify(
                new NuevoEvento($usuarioArray['nombres'],
                                $usuarioArray['apellidos'],
                                $usuarioArray['rol'],
                                $evento->nombre_evento));

        return response()->json('Se ha enviado al administrador para su revisión', 200);
    }

   

    public function obtenerEventosUsuario($cantidad)
    {
        $eventos = DB::table("eventos")
            ->join("zonas", "zonas.id", "=", "eventos.zona")
            ->join("estados", "estados.id", "=", "eventos.estado")
            ->select("eventos.id", "eventos.nombre_evento", "eventos.descripcion", "zonas.nombre_zona", 
                "eventos.visibilidad", "eventos.horario", "eventos.certificado", "estados.estado")->where('eventos.creador_evento', Auth::id())
            ->orderBy('eventos.created_at', 'desc')->paginate($cantidad);
            
        if($eventos->isEmpty())
            return response()->json($eventos,204);
    
        return response()->json($eventos,200);
    }

    public function obtenerEventos($cantidad)
    {
        $eventos = DB::table('eventos')
            ->join('zonas', 'zonas.id', '=', 'eventos.zona')
            ->join('estados', 'estados.id', '=', 'eventos.estado')
            ->join('usuarios', 'usuarios.id_user', '=', 'eventos.creador_evento')
            ->join('roles', 'roles.id', '=', 'usuarios.id_rol')
            ->select('eventos.id', 'eventos.nombre_evento', 'eventos.descripcion', 'zonas.nombre_zona',
            'usuarios.nombres', 'usuarios.apellidos', 'roles.rol', 'eventos.visibilidad', 'estados.estado', 'eventos.horario')
            ->where('eventos.estado', '<>', 3)->orderBy('eventos.created_at', 'desc')->paginate($cantidad);
            
            if($eventos->isEmpty())
                return response()->json($eventos,204);

        return response()->json($eventos,200);
    }

    public function aprobarEvento($idEvento)
    { 
        $evento = Eventos::findOrFail($idEvento);
        $horarioPendiente = json_decode($evento->horario,true);
        $resultado = DB::table('eventos')->where([
            ['estado', '=', 1],
            ['zona', '=', $evento->zona]
        ])->select('horario')->get();

        if($resultado->isEmpty()){
            $evento->estado = 1;
            $evento->save();
            $this->notificacionEventoAprobado($evento);
            return response()->json('Evento aprobado exitosamente', 200);
        } else {
            if($this->verificarCruces($resultado, $horarioPendiente))
                return response()->json('Existe un cruce de horarios', 400);
            else {
                $evento->estado = 1;
                $evento->save();
                $this->notificacionEventoAprobado($evento);  
                return response()->json('Evento aprobado exitosamente', 200); 
            }
        }
    }

    public function desaprobarEvento($idEvento, Request $request)
    {
        $evento = Eventos::findOrFail($idEvento);
        $evento->delete();
        $notificacion = User::find($evento->creador_evento);
        $notificacion->notify(
            new EventoDescartado($request->comentario, $evento->nombre_evento)
        );
        return response()->json('Evento descartado',200);
    }

    public function eliminarEvento($idEvento)
    {
        $evento = Eventos::find($idEvento);
        $evento->delete();
        return response()->json('Evento eliminado',200);
    }

    public function certificadoEvento($certificado)
    {
        $urlArchivo = asset(Storage::url("certificados/$certificado"));
        return response()->json($urlArchivo,200);
    }

     /*
    public function subirCertificado(Request $request, $idEvento)
    {
        if($request->hasFile('certificado')){
            $tamanioArchivo = $request->file('certificado')->getSize();
            $tipoArchivo = $request->file('certificado')->getMimeType();

            if($tipoArchivo !== Config::get("constantes.documento"))
                return response()->json('Solo archivos .pdf',422);
                
            if($tamanioArchivo > Config::get("constantes.certificado"))
                return response()->json('Maximo permitido 2 Mb',422);

            $archivo = $request->file('certificado');
            $nombre = time().'_'.$archivo->getClientOriginalName();
            $rutaImagen = $archivo->storeAs('certificados', $nombre);
            Eventos::where('id', $idEvento)->update(['certificado' => $nombre]);
            return response()->json('ok',204);
        }
    }
    */
}