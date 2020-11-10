<?php
namespace App\Http\Controllers;
use App\User;
use App\PasswordReset;
use Carbon\Carbon;
use App\Http\Controllers\Controller;
use App\Notifications\PasswordResetRequest;
use App\Notifications\PasswordResetSuccess;
use Illuminate\Http\Request;
use Validator;

class PasswordResetController extends Controller
{

    public function validacionUsuario($correo) {
        $user = User::where('email',$correo)->first();
        if($user == null)
            return false;
        if($user->confirmado === 0 && $user->codigo_confirmacion != null)
            return false;
        if($user->confirmado === 1 && $user->codigo_confirmacion == null) 
            return true;
    }

    public function create($correoUsuario) 
    {
        $usuario = User::where('email',$correoUsuario)->first();

        if($usuario == null)
            return response()->json('No existe un usuario registrado con ese correo', 404);
            
        $resultado = $this->validacionUsuario($correoUsuario);
        $passwordReset = PasswordReset::where('email', $correoUsuario)->first();

        if(!$resultado)
            return response()->json('No ha confirmado su registro en el sistema', 400);

        if($passwordReset != null) {
            if(!Carbon::parse($passwordReset->updated_at)->addMinutes(5)->isPast()) 
                return response()->json('Ya ha solicitado una recuperacion de contraseña', 400);
        }

        $passwordReset = PasswordReset::updateOrCreate(
            ['email' => $usuario->email],
                [
                    'email' => $usuario->email,
                    'token' => str_random(60)
                ]
        );

        if ($usuario && $passwordReset)
            $usuario->notify(
                new PasswordResetRequest($passwordReset->token)
            );
        return response()->json('Se ha enviado su enlace de recuperacion al correo electronico' ,200);
    }

    public function find($token)
    {
        $passwordReset = PasswordReset::where('token', $token)->first();
        if (!$passwordReset)
            return response()->json('Este token de restablecimiento de contraseña no es válido', 404);

        if (Carbon::parse($passwordReset->updated_at)->addMinutes(5)->isPast()) {
            $passwordReset->delete();
            return response()->json('El tiempo limite para recuperar su cuenta ha caducado debe generar la solicitud nuevamente', 404);
        }
        return response()->json($passwordReset, 200);
    }

    public function reset(Request $request)
    {
        $validador = Validator::make($request->all(), [
            'correo' => 'required|string|email',
            'clave' => 'required|string|max:12',
            'token' => 'required|string'
        ]);

        if($validador->fails()){
            return response()->json('error de validacion', 422);
        }

        $passwordReset = PasswordReset::where('token', $request->token)->first();

        if (!$passwordReset)
            return response()->json('Este token de restablecimiento de contraseña no es válido.', 404);

        $user = User::where('email', $request->correo)->first();

        if (!$user)
            return response()->json('No exite un usuario registrado con ese email', 404);

        $user->password = bcrypt($request->clave);
        $user->save();
        $passwordReset->delete();
        $user->notify(new PasswordResetSuccess($passwordReset));
        return response()->json('Clave actualizada correctamente', 200);
    }
}
