<?php

namespace App\Http\Controllers\Api;
use App\User;
use App\Usuarios;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Validator;

class AuthController extends Controller
{
    public function registro(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'apellidos' => 'required',
            'nombres' => 'required',
            'identificacion' => 'required',
            'estado' => 'required',
            'foto' => 'required',
            'id_rol' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required',
            'confirm_password'=> 'required|same:password'
        ]);

        if($validator->fails()){
            return $this->sendError("Error de validación", $validator->errors(), 422);
        }

        DB::beginTransaction();

        try{
            $input = $request->all();
            $input["password"] = bcrypt($request->password);
            $user = User::create($input);
            $token = $user->createToken("MyApp")->accessToken;

            $datosUsuario = new Usuarios(); 
            $datosUsuario->apellidos = $request->apellidos;
            $datosUsuario->nombres = $request->nombres;
            $datosUsuario->identificacion = $request->identificacion;
            $datosUsuario->estado = $request->estado;
            $datosUsuario->foto = $request->foto;
            $datosUsuario->id_rol = $request->id_rol;
            $datosUsuario->id_user = $user->id;
            $datosUsuario->save();  

            DB::commit();

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json(['mensaje '=> $e->getMessage()], 400);
        }

        return response()->json( [ 'token' => $token, 'user' => $user, 'datosUsuario' => $datosUsuario], 200);
    }
}
