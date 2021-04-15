<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\tipo_notificacion;
use App\notificaciones;
use App\Usuarios;
use Carbon\Carbon;
use Validator;


class PeticionesController extends Controller
{
    public function obtenerTipoPeticiones()
    {
        $tipos = tipo_notificacion::where([
            ['id','<>',1],
            ['id','<>',2]
        ])->select('id','nombre')->get();
        return response()->json($tipos,200);
    }

    public function registrarPeticion(Request $request)
    {
        $validador = Validator::make($request->all(), [
            'tipoNotificacion'=>'required',
            'comentario'=>'required|max:200'
        ]);

        if($validador->fails())
            return response()->json($validador->errors(),422);
        
        $idAdmin = Usuarios::where('id_rol',1)->value('id_user');
        
        $peticion = new notificaciones;
        $peticion->id_emisor = Auth::id();
        $peticion->id_receptor = $idAdmin;
        $peticion->tipo_notificacion = $request->tipoNotificacion;
        $peticion->fecha_solicitud = Carbon::now();
        $peticion->comentario = $request->comentario;
        $peticion->estado = 6;
        $peticion->save();

        return response()->json('Peticion creada',201);

    }
}
