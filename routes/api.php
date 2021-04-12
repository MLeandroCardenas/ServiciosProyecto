<?php
use Illuminate\Http\Request;

Route::group(['prefix' => 'v1'], function () {

    Route::post('login', 'AuthController@login');
    Route::post('registro', 'AuthController@registro');
    Route::get('consultacorreo/{correo}','AuthController@validarUsuario');
    Route::get('consultaIdentificacion/{identificacion}','AuthController@validarIdentificacionUsuario');
    Route::get('obtenerRoles','AuthController@obtenerRoles');
    Route::post('solicitar/{correo}', 'PasswordResetController@create');
    Route::get('buscar/{token}', 'PasswordResetController@find');
    Route::post('actualizar', 'PasswordResetController@reset');

    Route::get('publicos/{cantidad}','EventosController@obtenerEventosPublicos');
    
    //Rutas protegidas con autenticacion
    Route::group(['middleware'=>'auth:api'], function(){ 

        Route::get('foto/{nombre}','UsuarioController@fotoUsuario');
        Route::get('actual','UsuarioController@obtenerFotoActualizada');
        Route::get('autenticado','UsuarioController@perfilUsuario');
        Route::get('usuarios/{cantidad}', 'UsuarioController@obtenerUsuarios');        
        Route::patch('nueva','UsuarioController@editarClave');
        Route::post('fotoperfil','UsuarioController@cargarFotoUsuario');
        Route::get('logout', 'AuthController@logout');
        
        Route::post('lectores','ZonasController@registrarLector');
        Route::put('lectores','ZonasController@editarLector');
        Route::get('lectores/{id}','ZonasController@obtenerLectorEspecifico');
        Route::patch('lectores','ZonasController@deshabilitarLectores');
        Route::patch('lectores/{id}','ZonasController@deshabilitarLectorEspecifico');
        Route::patch('zonas/{id}','ZonasController@deshabilitarZonaEspecifica');
        Route::patch('habilitarzona/{id}','ZonasController@habilitarZonaEspecifica');
        Route::patch('habilitarlector/{id}','ZonasController@habilitarLectorEspecifico');
        Route::patch('habilitarlectores','ZonasController@habilitarLectores');
        Route::get('lectores','ZonasController@listarLectores');        
        Route::get('lectoresdisponibles','ZonasController@lectoresDisponibles');
        
        Route::get('habilitadas','ZonasController@obtenerZonasHabilitadas');
        Route::get('zonas','ZonasController@obtenerTodasLasZonas');
        Route::post('zonas','ZonasController@crearZonas');
        Route::put('zonas','ZonasController@editarZona');
        Route::get('zonas/{id}','ZonasController@obtenerZonaEspecifica');
        Route::get('deshabilitadas','ZonasController@obtenerZonasDeshabilitadas');
   
        Route::get('horas/{horaActual}','EventosController@obtenerRangosHorarios');
        Route::get('todos/{cantidad}','EventosController@obtenerEventos');
        Route::get('eventos/{cantidad}','EventosController@obtenerEventosUsuario');
        Route::put('eventos/{idEvento}','EventosController@aprobarEvento');
        Route::post('desaprobar/{idEvento}','EventosController@desaprobarEvento');
        Route::post('eventos','EventosController@crearEvento');
        //Route::post('certificados/{idEvento}','EventosController@subirCertificado');
        //Route::get('certificado/{nombre}','EventosController@certificadoEvento');
        Route::patch('notificacionEvento/{idEvento}','EventosController@solicitarAprobacionEvento');
        Route::delete('evento/{idEvento}','EventosController@eliminarEvento');
        
    });
});