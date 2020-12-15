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
       $usuario = Usuarios::where('id_user', Auth::id())
        ->join('roles', 'usuarios.id_rol', '=', 'roles.id')
        ->select(
            'usuarios.apellidos',
            'usuarios.nombres', 
            'usuarios.identificacion',
            'roles.rol')->first();
        return response()->json($usuario,200);
    }


    /**
     * SE DEBE ARREGLAR
     */
    public function editarFotoPerfil(Request $request) {
        $file = $request->file('foto');
        $file = $request->foto;

       if($request->hasFile('foto')) {
            $file = $request->file('foto');
            $nombre = time().$file->getClientOriginalName();
            $file->move(public_path().'/imagenes/',$nombre);
            DB::table('usuarios')->where('id_user', Auth::id())->update(['foto' => $fotoUsuario]);
            return response()->json('Foto de perfil actualizada', 200);
        } else 
            return response()->json('NO TIENE UN ARCHIVO', 400);
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
    
    public function obtenerUsuarios($cantidad)
    {
        $usuarios = Usuarios::where([
            ['usuarios.id_rol', '<>', 1],
            ['usuarios.estado', '<>', 6],
        ])
        ->join("roles","roles.id", "=", "usuarios.id_rol")
        ->join("estados","estados.id", "=", "usuarios.estado")
        ->select("usuarios.id", "usuarios.apellidos", "usuarios.nombres", "usuarios.identificacion", "roles.rol", 
                "estados.estado")->orderBy('usuarios.created_at', 'desc')->paginate($cantidad);
    
        return response()->json($usuarios,200);
    }
}
