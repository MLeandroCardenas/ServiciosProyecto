<?php

namespace App\Http\Controllers\Api;
use App\Usuarios;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class UsuarioController extends Controller
{
    public function obtenerUsuarios()
    {
        $data = [];
        $users = DB::table("users")
            ->join("usuarios", "users.id", "=", "usuarios.id_user")
            ->join("roles","roles.id", "=", "usuarios.id_rol")
            ->join("estados","estados.id", "=", "usuarios.estado")
            ->select("users.id", "usuarios.apellidos", "usuarios.nombres", "usuarios.identificacion", "users.email",  "roles.rol", 
            "usuarios.estado", "estados.estado")
            ->orderBy('usuarios.created_at', 'desc')->paginate(10);

        $data['users'] = $users;

        return response()->json($data,200);
    }

    public function obtenerUsuarioEspecifico($id)
    {
        $data = [];
        $users = DB::table("users")
            ->join("usuarios", "users.id", "=", "usuarios.id_user")
            ->join("roles","roles.id", "=", "usuarios.id_rol")
            ->join("estados","estados.id", "=", "usuarios.estado")
            ->select("users.id", "usuarios.apellidos", "usuarios.nombres", "usuarios.identificacion", "users.email",  "roles.rol", 
            "estados.estado","usuarios.foto")->where('usuarios.identificacion','=',$id)->first();

        $data['users'] = $users;

        if(empty($data))
            return response()->json(404);

        return response()->json($data,200);
    }

    public function obtenerUsuariosPorRol($id)
    {
        $data = [];
        $users = DB::table("users")
            ->join("usuarios", "users.id", "=", "usuarios.id_user")
            ->join("roles","roles.id", "=", "usuarios.id_rol")
            ->join("estados","estados.id", "=", "usuarios.estado")
            ->select("users.id", "usuarios.apellidos", "usuarios.nombres", "usuarios.identificacion", "users.email",  "roles.rol", 
            "estados.estado","usuarios.foto")->where('usuarios.id_rol','=',$id)->paginate(10);

        $data['users'] = $users;

        return response()->json($data,200);
    }

    public function editarClave(Request $request) {
        $claveActual = User::where('id',Auth::id())->value('password');
        if(!Hash::check($request->actual, $claveActual)) {
            return response()->json('Clave incorrecta',400);
        } else {
            $usuario = User::find(Auth::id());
            $usuario->password = bcrypt($request->nueva);
            $usuario->save();
            return response()->json('Contraseña editada correctamente', 200);
        }
    }
}
