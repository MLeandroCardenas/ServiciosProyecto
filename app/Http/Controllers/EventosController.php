<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Eventos;
use Validator;

class EventosController extends Controller
{
    public function crearEventos(Request $request)
    {
        $validador = Validator::make($request->all(), [
            'id_zona'=>'required',
            'nombre_evento'=>'required|max:50',
            'descripcion'=>'required|max:100',
            'visibilidad'=>'required',
            'horario'=>'required'
        ]);

        if($validador->fails()){
            return response()->json($validador->errors(),422);
        }

        DB::beginTransaction();
        try{
            $horariosActuales = $request->horario;
            $resultado = DB::table('eventos')->select('horario')->where([
                ['estado','=',1],
                ['id_zona','=',$request->id_zona],
            ])->get()->all();


            if(empty($resultado)){
                $input = $request->all();
                $input["creador_evento"] = Auth::id();
                $evento = Eventos::create($input);
                DB::commit();
            }
            else{
                return response()->json('HAY EVENTOS HABILITADOS EN ESA ZONA',200);
            }
            
        }catch(\Exception $e){
            DB::rollback();
            return response()->json(['mensaje '=> $e->getMessage()], 400); 
        }
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