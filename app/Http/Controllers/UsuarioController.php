<?php
namespace App\Http\Controllers;
use App\Usuarios;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class UsuarioController extends Controller
{
    public function perfilUsuario() {
        $usuario = DB::table('usuarios')
            ->join('roles', 'usuarios.id_rol', '=', 'roles.id')
            ->select(
                'usuarios.apellidos',
                'usuarios.nombres', 
                'usuarios.identificacion', 
                'usuarios.foto',
                'roles.rol')
            ->where('usuarios.id_user', '=', Auth::id())->first();
        return response()->json($usuario,200);
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

    public function editarFotoPerfil(Request $request) {
        if($request->hasFile('archivo')) {
            $file = $request->file('archivo');
            $nombre = time().$file->getClientOriginalName();
            $file->move(public_path().'/imagenes/',$nombre);
        } else 
            return response()->json('NO TIENE UN ARCHIVO', 400);

        DB::table('usuarios')->where('id_user',Auth::id())->update(['foto' => $archivo]);
        return response()->json('Foto de perfil actualizada', 200);
    }

    /*
    public function obtenerUsuarios()
    {
        $users = DB::table("users")
            ->join("usuarios", "users.id", "=", "usuarios.id_user")
            ->join("roles","roles.id", "=", "usuarios.id_rol")
            ->join("estados","estados.id", "=", "usuarios.estado")
            ->select("users.id", "usuarios.apellidos", "usuarios.nombres", "usuarios.identificacion", "users.email",  "roles.rol", 
            "usuarios.estado", "estados.estado")
            ->orderBy('usuarios.created_at', 'desc')->paginate(10);
        return response()->json($users,200);
    }
    */

    /*
    public function obtenerUsuarioEspecifico($id)
    {
        $users = DB::table("users")
            ->join("usuarios", "users.id", "=", "usuarios.id_user")
            ->join("roles","roles.id", "=", "usuarios.id_rol")
            ->join("estados","estados.id", "=", "usuarios.estado")
            ->select("users.id", "usuarios.apellidos", "usuarios.nombres", "usuarios.identificacion", "users.email",  "roles.rol", 
            "estados.estado","usuarios.foto")->where('usuarios.identificacion','=',$id)->first();

        if(empty($users))
            return response()->json('No existe',404);

        return response()->json($users,200);
    }
    */

    /*
    public function obtenerUsuariosPorRol($id)
    {
        $users = DB::table("users")
            ->join("usuarios", "users.id", "=", "usuarios.id_user")
            ->join("roles","roles.id", "=", "usuarios.id_rol")
            ->join("estados","estados.id", "=", "usuarios.estado")
            ->select("users.id", "usuarios.apellidos", "usuarios.nombres", "usuarios.identificacion", "users.email",  "roles.rol", 
            "estados.estado","usuarios.foto"
            )->where('usuarios.id_rol','=',$id)->paginate(10);

        return response()->json($users,200);
    }
    */
}
