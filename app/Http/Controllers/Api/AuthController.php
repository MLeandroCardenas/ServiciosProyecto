<?php

namespace App\Http\Controllers\Api;
use App\User;
use App\Usuarios;
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
    public function registro(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'apellidos' => 'required', 'nombres' => 'required', 'identificacion' => 'required',
            'estado' => 'required', 'id_rol' => 'required', 'email' => 'required|email|unique:users',
            'password' => 'required'
        ]);

        if($validator->fails()){
            return response()->json('error de validacion', 400);
        }

        DB::beginTransaction();

        try{
            $codigo = str_random(25);
            $user = User::create([
                'email' => $request->email,
                'password' => bcrypt($request->password),
                'codigo_confirmacion' => $codigo
            ]);
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

        /**
         * se debe probar en produccion
         */
       // Mail::to($request->email)->send(new OrderShipped($datosUsuario,$user));

        return response()->json( [ 'token' => $token, 'user' => $user, 'datosUsuario' => $datosUsuario], 200);
    }

    /**
     * probar en produccion
     */
    public function verificar($code)
    {
        $user = User::where('codigo_confirmacion', $code)->first();

        if (! $user)
            return redirect('/');

        $user->confirmado = true;
        $user->codigo_confirmacion = null;
        $user->save();

        return redirect()->away('http://localhost:4200/login')->with('notification', 'Has confirmado correctamente tu correo!');   
    }

    public function validacion(Request $request)
    {
        $user = User::where('email',$request->email)->first();

        if(empty($user))
            return response()->json($user,204);

        else if (Hash::check($request->password, $user->password) && !empty($user)) {
            if($user->confirmado === 0)
                return response()->json('Aún no ha confirmado su registro',401);
        } else
            return response()->json('Clave incorrecta',401);
    }

    public function solicitarRecuperacionCuenta(Request $request)
    {
        $users = DB::table('users')->where([
            ['email', '=', $request->email],
            ['confirmado', '=', 1],
            ['codigo_confirmacion', '=', null],
        ])->first();

        if(empty($users))
            return response()->json($users,404);
        else
            return response()->json($users,200);
    }

    public function validarUsuario($correo) 
    {
        $user = User::where('email',$correo)->value('email');
        if(empty($user))
            return response()->json($user,204);
        return response()->json($user,200);
    }

    public function usuarioAutenticado(){
        $usuarioAutenticado = Usuarios::where('id_user',Auth::id())->value('id_rol');
        return response()->json($usuarioAutenticado,200);
    }
}
