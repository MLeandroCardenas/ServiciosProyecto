<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Notifications\NuevoEvento;
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
            try{
                $input = $request->all();
                $input['creador_evento'] = Auth::id();
                $input['estado'] = 3;
                $evento = Eventos::create($input);

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

                $usuario->notify(
                    new NuevoEvento($usuarioArray['nombres'],
                                    $usuarioArray['apellidos'],
                                    $usuarioArray['rol'],
                                    $request->nombre_evento)
                );
                DB::commit();
                return response()->json('Evento registrado exitosamente', 200);
            } catch(\Exception $e) {
                DB::rollback();
                return response()->json(['mensaje '=> $e->getMessage()], 500);
            }
        }
    }

    public function obtenerEventosUsuario($cantidad)
    {
        $eventos = DB::table("eventos")
            ->join("zonas", "zonas.id", "=", "eventos.zona")
            ->join("estados", "estados.id", "=", "eventos.estado")
            ->select("eventos.id", "eventos.nombre_evento", "eventos.descripcion", "zonas.nombre_zona", 
                "eventos.visibilidad","eventos.horario","estados.estado")->where('eventos.creador_evento', Auth::id())
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
            ->orderBy('eventos.created_at', 'desc')->paginate($cantidad);
            
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
            return response()->json('Evento aprobado exitosamente', 200);
        } else {
            if($this->verificarCruces($resultado, $horarioPendiente))
                return response()->json('Existe un cruce de horarios', 400);
            else {
                $evento->estado = 1;
                $evento->save();
                return response()->json('Evento aprobado exitosamente', 200);   
            }
        }
    }

    public function desaprobarEvento($idEvento)
    {
        $evento = Eventos::findOrFail($idEvento);
        $evento->estado = 3;
        $evento->save();
        return response()->json('Evento desaprobado',200);
    }

    /*
    public function obtenerEventosPublicos($cantidad)
    {
        $eventos = DB::table("eventos")
            ->join("zonas", "zonas.id", "=", "eventos.zona")
            ->join("estados", "estados.id", "=", "eventos.estado")
            ->select("eventos.id", "eventos.nombre_evento", "eventos.descripcion", "zonas.nombre_zona", "eventos.horario")
            ->where('eventos.visibilidad','PUBLICA')
            ->where('eventos.estado',1)
            ->orderBy('eventos.created_at', 'desc')->paginate($cantidad);
            
        if($eventos->isEmpty())
            return response()->json($eventos,204);
        else
            return response()->json($eventos,200);
    }

    public function obtenerEventosPorEstado($estado)
    {
            $resultado = [];
            $eventos = DB::table("eventos")
                ->join("zonas", "zonas.id", "=", "eventos.id_zona")
                ->join("estados", "estados.id", "=", "eventos.estado")
                ->select("eventos.id", "eventos.nombre_evento", "eventos.descripcion", "zonas.nombre_zona", 
                "eventos.visibilidad","eventos.horario","estados.estado")->where('eventos.estado','=',$estado)
                ->orderBy('eventos.created_at', 'desc')->paginate(10);
            
            if($eventos->isEmpty())
                return response()->json($resultado,404);
    
            $resultado['zonas'] = $eventos;
    
            return response()->json($resultado,200);
    }


    public function obtenerEventosInstitucionales()
    {
            $resultado = [];
            $eventos = DB::table("eventos")
                ->join("zonas", "zonas.id", "=", "eventos.id_zona")
                ->join("estados", "estados.id", "=", "eventos.estado")
                ->select("eventos.id", "eventos.nombre_evento", "eventos.descripcion", "zonas.nombre_zona", 
                "eventos.visibilidad","eventos.horario","estados.estado")
                ->where('eventos.visibilidad','=','INSTITUCIONAL')
                ->where('eventos.estado','=', 1)
                ->orderBy('eventos.created_at', 'desc')->paginate(10);
            
            if($eventos->isEmpty())
                return response()->json($resultado,404);
    
            $resultado['zonas'] = $eventos;
    
            return response()->json($resultado,200);
    }
    */
}