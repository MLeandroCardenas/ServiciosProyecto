<?php
namespace App\Http\Controllers;
use App\Usuarios;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class UsuarioController extends Controller
{

    public function fotoUsuario($fotoUsuario) {
        $urlImagen = asset(Storage::url("usuarios/$fotoUsuario"));
        return response()->json($urlImagen); 
    }

    public function obtenerFotoActualizada(){
        $fotoUsuario = Usuarios::where('id_user', Auth::id())->value('foto');
        if(empty($fotoUsuario))
            return response()->json('No tiene foto de perfil',400);
        else {
            $urlImagen = asset(Storage::url("usuarios/$fotoUsuario"));
            return response()->json($urlImagen);
        }
    }

    public function cargarFotoUsuario(Request $request) {
        if($request->hasFile('foto')) {
        /*   
            $messages = [
                'foto.mimes' => 'Solo formato jpg o jpeg',
                'foto.image' => 'Formato inválido debe ser una imagen',
                'foto.max' => 'Máximo 1 Mb'
            ];

            $rules = [
                'foto' => 'mimes:jpg,jpeg|image|max:1024'
            ];

            $datosValidacion = $request->validate($rules, $messages);

            if($datosValidacion->fails())
                return response()->json($datosValidacion->errors(),422);
        */
            $fotoUsuario = Usuarios::where('id_user', Auth::id())->value('foto');
            if(empty($fotoUsuario)) {
                $archivo = $request->file('foto');
                $nombre = time().'_'.$archivo->getClientOriginalName();
                $rutaImagen = $archivo->storeAs('usuarios', $nombre);
                DB::table('usuarios')->where('id_user', Auth::id())->update(['foto' => $nombre]);
                return response()->json('Foto de perfil actualizada', 200);
            } else{
                Storage::delete("usuarios/$fotoUsuario");
                $archivo = $request->file('foto');
                $nombre = time().'_'.$archivo->getClientOriginalName();
                $rutaImagen = $archivo->storeAs('usuarios', $nombre);
                DB::table('usuarios')->where('id_user', Auth::id())->update(['foto' => $nombre]);
                return response()->json('Foto de perfil actualizada', 200);
            }
         } else 
             return response()->json('NO TIENE UN ARCHIVO', 400);
     }

    public function perfilUsuario() {
       $usuario = Usuarios::where('id_user', Auth::id())
        ->join('roles', 'usuarios.id_rol', '=', 'roles.id')
        ->select(
            'usuarios.foto',
            'usuarios.apellidos',
            'usuarios.nombres', 
            'usuarios.identificacion',
            'usuarios.id_rol',
            'roles.rol')->first();
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
    
    public function obtenerUsuarios($cantidad)
    {
        $usuarios = Usuarios::where([
            ['usuarios.id_rol', '<>', 1],
            ['usuarios.estado', '<>', 6],
        ])
        ->join("roles","roles.id", "=", "usuarios.id_rol")
        ->join("estados","estados.id", "=", "usuarios.estado")
        ->select("usuarios.id", "usuarios.foto", "usuarios.apellidos", "usuarios.nombres", "usuarios.identificacion", "roles.rol", 
                "estados.estado")->orderBy('usuarios.created_at', 'desc')->paginate($cantidad);

        return response()->json($usuarios,200);
    }
}
