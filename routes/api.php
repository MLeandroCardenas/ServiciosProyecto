<?php
use Illuminate\Http\Request;

Route::group(['prefix' => 'v1'], function () {

    Route::post('login', 'AuthController@login');
    Route::post('registro', 'AuthController@registro');
    Route::get('consultacorreo/{correo}','AuthController@validarUsuario');
    Route::patch('solicitud', 'AuthController@solicitarRecuperacionCuenta');

    Route::get('publicos','EventosController@obtenerEventosPublicos');

    Route::group(['middleware'=>'auth:api'], function(){ 

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
        
        Route::get('autenticado','UsuarioController@perfilUsuario');
        Route::patch('nueva','UsuarioController@editarClave');
        Route::patch('fotoperfil','UsuarioController@editarFotoPerfil');
                
        Route::get('todos','EventosController@obtenerEventos');
        Route::get('eventos','EventosController@obtenerEventosUsuario');
        Route::get('institucionales','EventosController@obtenerEventosInstitucionales');
        Route::get('eventos/{id}','EventosController@obtenerEventosPorEstado');
        Route::put('eventos/{id}','EventosController@aprobarEvento');
        Route::post('eventos','EventosController@crearEventos');
    });
});


















