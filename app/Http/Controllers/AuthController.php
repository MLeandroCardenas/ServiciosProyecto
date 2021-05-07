<?php
namespace App\Http\Controllers;
use App\Roles;
use App\User;
use App\Usuarios;
use App\PasswordReset;
use App\Mail\OrderShipped;
use Illuminate\Support\Facades\Mail;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Validator;
use Carbon\Carbon;


class AuthController extends Controller
{
    public function login(Request $request) 
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|string|email',
            'password' => 'required|string|max:12'
           /* 'grant_type' => 'required|string',
            'client_id' => 'required',
            'client_secret' => 'required|string'*/
        ]);

        if($validator->fails())
            return response()->json('error de validacion', 422);

        $credenciales = request(['email', 'password']);
        $passwordReset = PasswordReset::where('email', $request->email)->first();
        $idUsuario = User::where('email',$request->email)->value('id');
        $estadoUsuario = Usuarios::where('id_user',$idUsuario)->value('estado');
        
        if(!Auth::attempt($credenciales)) {
            return response()->json('No esta autorizado', 401);
        } else if($passwordReset != null) {
            if(!Carbon::parse($passwordReset->updated_at)->addMinutes(5)->isPast())
                return response()->json('Tiene una solicitud de recuperacion de contraseña pendiente no puede iniciar sesion', 400); 
        } else if(!$this->validacion($request)) {
            return response()->json('No esta autorizado debe completar su registro', 401);
        } else if($estadoUsuario == 2) {
            return response()->json('Su credenciales de acceso fueron deshabilitadas', 401);
        } else {
            $usuario = $request->User();
            $tokenResult = $usuario->createToken('Personal Access Token');
            $token = $tokenResult->token;
            $token->save();

            return response()->json([
                'access_token' => $tokenResult->accessToken,
                'token_type'   => 'Bearer',
                'expires_at'   => Carbon::parse($tokenResult->token->expires_at)->toDateTimeString()
                ],200);
        }
    }

    public function obtenerRolUsuario()
    {
        return response()->json(Usuarios::where('id_user',Auth::id())->value('id_rol'), 200);
    }

    
    public function logout(Request $request)
    {
        $request->user()->token()->revoke();
        return response()->json('Has cerrado sesion',200);
    }

    
    public function registro(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'apellidos' => 'required|string', 
            'nombres' => 'required|string', 
            'identificacion' => 'required',
            'id_rol' => 'required', 
            'email' => 'required|email',
            'password' => 'required|max:12'
        ]);

        if($validator->fails()){
            return response()->json('error de validacion', 422);
        }

        DB::beginTransaction();

        try{
            $codigo = str_random(25);
            $user = User::create([
                'email' => $request->email,
                'password' => $request->password,
                'codigo_confirmacion' => $codigo
            ]);

            $datosUsuario = new Usuarios(); 
            $datosUsuario->apellidos = $request->apellidos;
            $datosUsuario->nombres = $request->nombres;
            $datosUsuario->identificacion = $request->identificacion;
            $datosUsuario->estado = 6;
            $datosUsuario->id_rol = $request->id_rol;
            $datosUsuario->id_user = $user->id;
            $datosUsuario->save();  
            DB::commit();

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json(['mensaje '=> $e->getMessage()], 400);
        }

        Mail::to($request->email)->send(new OrderShipped($datosUsuario,$user));
        return response()->json( 'Se ha enviado un enlace de confirmacion al correo eléctronico registrado', 200);
    }



    public function verificar($code)
    {
        $user = User::where('codigo_confirmacion', $code)->first();

        if (! $user)
            return redirect('/');

        $usuario = Usuarios::where('id_user',$user->id)->first();

        if(Carbon::parse($user->created_at)->addMinutes(10)->isPast()) {
            $user->delete();
            $usuario->delete();
            return response()->json('El tiempo limite para completar su registro ha caducado, debe registrarse nuevamente', 400);
        }

        DB::beginTransaction();
        try{ 
            $user->confirmado = true;
            $user->codigo_confirmacion = null;
            $user->save();

            $usuario->estado = 1;
            $usuario->save();
            DB::commit();

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json(['mensaje '=> $e->getMessage()], 500);
        }

        return redirect()->away('http://localhost:4200/confirmacion/'.$usuario->nombres.' '.$usuario->apellidos)->with('notification', 'Has confirmado correctamente tu correo!');   
    }

    public function validacion(Request $request)
    {
        $user = User::where('email',$request->email)->first();

        if (Hash::check($request->password, $user->password) && !empty($user)) {
            if($user->confirmado === 0 && $user->codigo_confirmacion != null)
                return false;
            if($user->confirmado === 1 && $user->codigo_confirmacion == null) 
                return true;
        }
    }

    public function validarUsuario($correo) 
    {
        $user = User::where('email',$correo)->value('id');
        if(empty($user))
            return response()->json($user,204);
        else
            return response()->json($user,200);
    }

    public function validarIdentificacionUsuario($identificacion) 
    {
        $original = base64_decode($identificacion);
        $resultado = Usuarios::where('identificacion', $original)->value('id_user');
        if(empty($resultado))
            return response()->json($resultado,204);
        else
            return response()->json($resultado,200);
    }

    public function obtenerRoles(){
        $roles = Roles::where('id','<>',1)->select('id','rol')->get();
        return response()->json($roles,200);
    }
}
