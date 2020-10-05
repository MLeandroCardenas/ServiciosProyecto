<?php
namespace App\Http\Controllers\Api;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Zonas;
use App\modulos_lectores;
use Validator;

class ZonasController extends Controller
{
    public function crearZonas(Request $request)
    {
        $validador = Validator::make($request->all(), [
                'nombre_zona'=>'required|max:50',
                'estado'=>'required',
                'idLector'=>'required'
        ]);

        if($validador->fails()){
            return response()->json($validador->errors(),422);
        }
        DB::beginTransaction();
        try{
            $nuevoEstado = $request->estado = 2;
            $idZona = DB::table('zonas')->insertGetId(
                [   'nombre_zona' => $request->nombre_zona,
                    'estado' => $nuevoEstado
                ]);
            DB::table('modulos_lectores')->where('id', $request->idLector)
            ->update(['estado' => 2, 'id_zona' => $idZona]);
            DB::commit();
            return response()->json('Zona creada exitosamente', 201);
            }catch(\Exception $e) {
                DB::rollback();
                return response()->json(['mensaje '=> $e->getMessage()], 400);
            }
    }

    public function registrarLector(Request $request) 
    {
        $validador = Validator::make($request->all(), [
            'nombre_modulo'=>'required|max:50',
            'codigo_lector'=>'required|max:32',
            'estado' => 'required'
        ]);

        if($validador->fails()){
            return response()->json($validador->errors(),422);
        }

        if($request->idZona == null) {
            $lector = modulos_lectores::create($request->all());
            return response()->json('Lector registrado exitosamente', 201);
        } else {
            DB::beginTransaction();
            try{
                $request->estado = 2;
                $zona = modulos_lectores::create($request->all());
                DB::table('zonas')->where('id', $request->idZona)->update(['estado' => 2]);
                DB::commit();
                return response()->json('Lector asociado exitosamente', 201);
            }catch(\Exception $e) {
                DB::rollback();
                return response()->json(['mensaje '=> $e->getMessage()], 500);
            }
        }
    }

    public function listarLectores() 
    {
        $lectores = DB::table('modulos_lectores')
            ->leftJoin('estados', 'modulos_lectores.estado', '=', 'estados.id')
            ->leftJoin('zonas', 'modulos_lectores.id_zona', '=', 'zonas.id')
            ->select(
                'modulos_lectores.id', 
                'modulos_lectores.nombre_modulo', 
                'modulos_lectores.codigo_lector',
                'estados.estado',
                'zonas.nombre_zona')->orderBy('modulos_lectores.created_at', 'desc')->get();

        if($lectores->isEmpty())
            return response()->json($lectores,204);
        else
            return response()->json($lectores,200);
    }

    public function obtenerTodasLasZonas()
    {
        $lugares = DB::table('zonas')
            ->join('estados', 'zonas.estado', '=', 'estados.id')
            ->select(
                'zonas.id',
                'zonas.nombre_zona',
                'estados.estado')->orderBy('zonas.created_at', 'desc')->get(); 

        if($lugares->isEmpty())
            return response()->json($lugares,204);
        else
            return response()->json($lugares,200);
    }

    public function lectoresDisponibles()
    {
        $lectores = modulos_lectores::where([
            ['id_zona', '=', null],
            ['estado', '=', 1]
        ])->select('id','nombre_modulo')->get();

        if($lectores->isEmpty())
            return response()->json($lectores,204);
        else 
            return  response()->json($lectores,200);
    }
    
    public function deshabilitarLectores()
    {
        modulos_lectores::where('estado','=', 1)->update(['estado'=>2]);
        return response()->json('Todas las lectores fueron deshabilitados',200);
    }

    public function deshabilitarLectorEspecifico($id)
    {
        $resultado = modulos_lectores::findOrFail($id);
        if($resultado->id_zona == null) {
            $resultado->estado = 2;
            $resultado->save();
            return response()->json('Lector deshabilitado',200);
        } else {
            DB::beginTransaction();
            try {
                $resultado->estado = 2;
                $resultado->save();
                $zona = Zonas::findOrFail($resultado->id_zona);
                $zona->estado = 2;
                $zona->save();
                DB::commit();
                return response()->json('Lector y zona deshabilitados',200);
            } catch (\Exception $e) {
                DB::rollback();
                return response()->json(['mensaje '=> $e->getMessage()], 500);
            }  
        }
    }

    public function deshabilitarZonaEspecifica($idZona)
    {
        $zona = Zonas::findOrFail($idZona);
        $zona->estado = 2;
        $zona->save();
        return response()->json('Zona deshabilitada',200);
    }

    public function habilitarZonaEspecifica($idZona)
    {
        $zona = Zonas::findOrFail($idZona);
        $lector = modulos_lectores::where('id_zona', '=', $idZona)->value('id');
        if(empty($lector)) {
            $zona->estado = 1;
            $zona->save();
            return response()->json('Zona habilitada',200);
        } else {
            return response()->json('Imposible. La zona tiene un lector asociado',202);
        }
    }

    public function habilitarLectorEspecifico($id)
    {
        DB::beginTransaction();
        try {
            $resultado = modulos_lectores::findOrFail($id);
            if($resultado->id_zona == null) {
                $resultado->estado = 1;
                $resultado->save();
                DB::commit();
                return response()->json('Lector habilitado',200);
            } else {
                $idZonaAsociada = $resultado->id_zona;
                $resultado->estado = 1;
                $resultado->id_zona = null;
                $resultado->save();
                $zona = Zonas::findOrFail($idZonaAsociada);
                $zona->estado = 1;
                $zona->save();
                DB::commit();
                return response()->json('Lector y zona habilitados',200);
            }
        } catch(\Exception $e) {
            DB::rollback();
            return response()->json(['mensaje '=> $e->getMessage()], 500);
        }
    }

    public function habilitarLectores()
    {
        modulos_lectores::where('estado','=', 2)->update(['estado'=>1]);
        return response()->json('Lectores habilitados',200);
    }

    public function obtenerZonaEspecifica($id)
    {
        $zonas = DB::table('zonas')
            ->join('estados', 'zonas.estado', '=', 'estados.id')
            ->select('zonas.id', 'zonas.nombre_zona',
            'estados.estado')->where('zonas.id','=',$id)->first();

        if(empty($zonas))
            return response()->json($zonas,404);
        else
            return response()->json($zonas,200);
    }

    public function obtenerLectorEspecifico($id)
    {
        $lectores = DB::table('modulos_lectores')
        ->leftJoin('estados', 'modulos_lectores.estado', '=', 'estados.id')
        ->leftJoin('zonas', 'modulos_lectores.id_zona', '=', 'zonas.id')
        ->select(
            'modulos_lectores.id', 
            'modulos_lectores.nombre_modulo', 
            'modulos_lectores.codigo_lector',
            'zonas.nombre_zona')->where('modulos_lectores.id','=',$id)->first();

    if(empty($lectores))
        return response()->json($lectores,404);
    else
        return response()->json($lectores,200);
    }

    public function obtenerZonasHabilitadas()
    {
        $zonasHabilitadas = DB::table('zonas')
            ->join('estados', 'zonas.estado', '=', 'estados.id')
            ->select('zonas.id', 'zonas.nombre_zona',
            'estados.estado')->where('zonas.estado','=',1)->get();
        
        if($zonasHabilitadas->isEmpty())
            return response()->json($zonasHabilitadas,204);
        else
            return response()->json($zonasHabilitadas,200);
    }

    public function obtenerZonasDeshabilitadas()
    {
        $zonasDeshabilitadas = DB::table('zonas')
            ->join('estados', 'zonas.estado', '=', 'estados.id')
            ->select('zonas.id', 'zonas.nombre_zona',
            'estados.estado')->where('zonas.estado','=',2)->get();
        
        if($zonasDeshabilitadas->isEmpty())
            return response()->json($zonasDeshabilitadas,204);
        else
            return response()->json($zonasDeshabilitadas,200);
    }

    public function editarZona(Request $request)
    {
       $zona = Zonas::findOrFail($request->id);

        $validador = Validator::make($request->all(), [
            'nombre_zona'=>'required|max:50'
        ]);

        if($validador->fails()){
            return response()->json($validador->errors(),422);
        }
        $zona->nombre_zona = $request->nombre_zona;
        $zona->save();
        return response()->json('Zona editada correctamente',200);
        /*
        if($request->idLector == null) {
            $zona->nombre_zona = $request->nombre_zona;
            $zona->save();
            return response()->json('Zona editada correctamente',200);
        } else {
            DB::beginTransaction();
            try{
                $zona->nombre_zona = $request->nombre_zona;
                $zona->estado = 2;
                $zona->save();
                $lector = modulos_lectores::where('id_zona', '=', $zona->id)->first();
                if(empty($lector)) {
                    $actualizarLector = modulos_lectores::where('id', '=', $request->idLector)->first();
                    $actualizarLector->id_zona = $request->id;
                    $actualizarLector->estado = 2;
                    $actualizarLector->save();
                    return response()->json('Zona editada correctamente',200);
                } else {
                    $Lector = null;
                    $Lector->estado = 1;
                    $lector->id_zona = null;
                    $lector->save();
                    $nuevoLector = modulos_lectores::where('id', '=', $request->idLector)->first();
                    $nuevoLector->estado = 2;
                    $nuevoLector->id_zona = $request->id;
                    $nuevoLector->save();
                    return response()->json('Zona editada y lector asignado correctamente',200);
                }
                DB::commit();
            } catch(\Exception $e) {
                DB::rollback();
                return response()->json(['mensaje '=> $e->getMessage()], 500);
            }
        }
        */
    }

    public function editarLector(Request $request){
        $lector = modulos_lectores::findOrFail($request->id);

        $validador = Validator::make($request->all(), [
            'nombre_modulo'=>'required|max:50',
            'codigo_lector' =>'required|max:32'
        ]);

        if($validador->fails()){
            return response()->json($validador->errors(),422);
        } 

        DB::beginTransaction();
            try{
                if($request->idZona !== null) {
                    $lector->nombre_modulo = $request->nombre_modulo;
                    $lector->codigo_lector = $request->codigo_lector;
                    $lector->id_zona = $request->idZona;
                    $lector->estado = 2;
                    $lector->save();
                    $zona = Zonas::findOrFail($request->idZona);
                    $zona->estado = 2;
                    $zona->save();
                    DB::commit();
                    return response()->json('Lector editado y asociado correctamente',200);
                } else {
                    $lector->nombre_modulo = $request->nombre_modulo;
                    $lector->codigo_lector = $request->codigo_lector;
                    $lector->save();
                    DB::commit();
                    return response()->json('Lector editado correctamente',200);
                }
                
            }catch(\Exception $e) {
                DB::rollback();
                return response()->json(['mensaje '=> $e->getMessage()], 500);
            }
        }
}
