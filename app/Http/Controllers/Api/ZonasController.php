<?php

namespace App\Http\Controllers\Api;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Zonas;
use Validator;

class ZonasController extends Controller
{
    public function crearZonas(Request $request)
    {
        $validador = Validator::make($request->all(), [
                'nombre_zona'=>'required|max:50',
                'codigo_lector'=>'required',
                'sede'=>'required'
        ]);

        if($validador->fails()){
            return response()->json($validador->errors(),422);
        }

        $zona = Zonas::create($request->all());
        return response()->json(201);
    }
    
    public function deshabilitarZonas()
    {
        Zonas::where('estado','=', 1)->update(['estado'=>2]);
        return response()->json('Todas las zonas fueron deshabilitadas',200);
    }

    public function deshabilitarZonaEspecifico($id)
    {
        $resultado = Zonas::findOrFail($id);
        $resultado->estado = 2;
        $resultado->save();
        return response()->json('Zona deshabilitada',200);
    }

    public function habilitarZonas()
    {
        Zonas::where('estado','=', 2)->update(['estado'=>1]);
        return response()->json('Zonas habilitadas',200);
    }

    public function habilitarZonaEspecifico($id)
    {
        $resultado = Zonas::findOrFail($id);
        $resultado->estado = 1;
        $resultado->save();
        return response()->json('Zona habilitada',200);
    }

    public function obtenerTodasLasZonas()
    {
        $resultados = [];
        $lugares = DB::table("zonas")
            ->join("estados", "zonas.estado", "=", "estados.id")
            ->select("zonas.id", "zonas.nombre_zona", "zonas.codigo_lector", "zonas.sede", 
            "estados.estado")->orderBy('zonas.created_at', 'desc')->paginate(10);

        if($lugares->isEmpty())
            return response()->json($resultados,204);

        $resultados['zonas'] = $lugares;
        return response()->json($resultados,200);
    }

    public function obtenerZonaEspecifica($id)
    {
        $data = [];
        $zonas = DB::table("zonas")
            ->join("estados", "zonas.estado", "=", "estados.id")
            ->select("zonas.id", "zonas.nombre_zona", "zonas.codigo_lector", "zonas.sede", 
            "estados.estado")->where('zonas.id','=',$id)->get();

        if($zonas->isEmpty())
            return response()->json($data,204);

        $data['zonas'] = $zonas;

        return response()->json($data,200);
    }

    public function obtenerZonasHabilitadas()
    {
        $datos = [];
        $zonasHabilitadas = DB::table("zonas")
            ->join("estados", "zonas.estado", "=", "estados.id")
            ->select("zonas.id", "zonas.nombre_zona", "zonas.codigo_lector", "zonas.sede", 
            "estados.estado")->where('zonas.estado','=',1)->get();
        
        if($zonasHabilitadas->isEmpty())
            return response()->json($datos,204);

        $datos['zonas'] = $zonasHabilitadas;

        return response()->json($datos,200);
    }

    public function obtenerZonasDeshabilitadas()
    {
        $informacion = [];
        $zonasDeshabilitadas = DB::table("zonas")
            ->join("estados", "zonas.estado", "=", "estados.id")
            ->select("zonas.id", "zonas.nombre_zona", "zonas.codigo_lector", "zonas.sede", 
            "estados.estado")->where('zonas.estado','=',2)->get();
        
        if($zonasDeshabilitadas->isEmpty())
            return response()->json($informacion,204);

        $informacion['zonas'] = $zonasDeshabilitadas;

        return response()->json($informacion,200);
    }

    public function editarZona(Request $request)
    {
       $resultado = Zonas::findOrFail($request->input('id'));

        if($resultado===null){
            return response()->json($resultado,204);
        }

        $validador = Validator::make($request->all(), [
            'nombre_zona'=>'required|max:50',
            'codigo_lector'=>'required'
        ]);

        if($validador->fails()){
            return response()->json($validador->errors(),422);
        }
        $resultado->nombre_zona = $request->input('nombre_zona');
        $resultado->codigo_lector = $request->input('codigo_lector');
        $resultado->codigo_lector = $request->input('sede');
        $resultado->save();
        return response()->json($resultado,200);
    }
}
