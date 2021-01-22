<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Eventos;
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
        }

        $input = $request->all();
        $input['creador_evento'] = Auth::id();
        $input['estado'] = 3;
        $evento = Eventos::create($input);

        return response()->json('Evento registrado exitosamente', 200);
    }

    public function aprobarEvento($id_evento)
    {
        DB::beginTransaction();
        try {
            $evento = Eventos::findOrFail($id_evento);
            $evento->estado = 1;
            $listaFechas = $evento->horario;
            $evento->save();
            DB::commit();
        } catch (Exception $e) {
            DB::rollback();
            return response()->json(['mensaje '=> $e->getMessage()], 400);
        }
    }

    public function obtenerEventos()
    {
            $resultado = [];
            $eventos = DB::table("eventos")
                ->join("zonas", "zonas.id", "=", "eventos.id_zona")
                ->join("estados", "estados.id", "=", "eventos.estado")
                ->select("eventos.id", "eventos.nombre_evento", "eventos.descripcion", "zonas.nombre_zona", 
                "eventos.visibilidad","eventos.horario","estados.estado")
                ->orderBy('eventos.created_at', 'desc')->paginate(10);
            
            if($eventos->isEmpty())
                return response()->json($resultado,404);
    
            $resultado['zonas'] = $eventos;
    
            return response()->json($resultado,200);
    }

    public function obtenerEventosUsuario()
    {
        $resultado = [];
            $eventos = DB::table("eventos")
                ->join("zonas", "zonas.id", "=", "eventos.id_zona")
                ->join("estados", "estados.id", "=", "eventos.estado")
                ->select("eventos.id", "eventos.nombre_evento", "eventos.descripcion", "zonas.nombre_zona", 
                "eventos.visibilidad","eventos.horario","estados.estado")->where('eventos.creador_evento','=', Auth::id())
                ->orderBy('eventos.created_at', 'desc')->paginate(10);
            
        if($eventos->isEmpty())
            return response()->json($resultado,404);
    
        $resultado['zonas'] = $eventos;
            return response()->json($resultado,200);
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

    public function obtenerEventosPublicos()
    {
        $eventos = DB::table("eventos")
            ->join("zonas", "zonas.id", "=", "eventos.id_zona")
            ->join("estados", "estados.id", "=", "eventos.estado")
            ->select("eventos.id", "eventos.nombre_evento", "eventos.descripcion", "zonas.nombre_zona", 
                "eventos.visibilidad","eventos.horario","estados.estado")
            ->where('eventos.visibilidad','=','PUBLICA')
            ->where('eventos.estado','=',1)
            ->orderBy('eventos.created_at', 'desc')->paginate(10);
            
        if($eventos->isEmpty())
            return response()->json($eventos,204);
        else
            return response()->json($eventos,200);
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
}