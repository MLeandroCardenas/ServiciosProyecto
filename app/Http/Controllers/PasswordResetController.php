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
    public function create(Request $request) 
    {
        $validador = Validator::make($request->all(), [
            'email' => 'required|string|email',
        ]);

        $usuario = User::where('email',$request->email)->first();

        if(!$usuario)
            return response()->json('No existe un usuario registrado con ese correo', 404);

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

        if (Carbon::parse($passwordReset->updated_at)->addMinutes(360)->isPast()) {
            $passwordReset->delete();
            return response()->json('Este token de restablecimiento de contraseña no es válido', 404);
        }
        return response()->json($passwordReset, 200);
    }

    public function reset(Request $request)
    {
        $validador = Validator::make($request->all(), [
            'email' => 'required|string|email',
            'password' => 'required|string|confirmed',
            'token' => 'required|string'
        ]);

        $passwordReset = PasswordReset::where('token', $request->token)->first();

        if (!$passwordReset)
            return response()->json('Este token de restablecimiento de contraseña no es válido.', 404);

        $user = User::where('email', $request->email)->first();

        if (!$user)
            return response()->json('No exite un usuario registrado con ese email', 404);

        $user->password = bcrypt($request->password);
        $user->save();
        $passwordReset->delete();
        $user->notify(new PasswordResetSuccess($passwordReset));
        return response()->json($user, 200);
    }
}
