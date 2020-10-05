<?php
use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
cambios
|
*/
Route::group(['prefix' => 'v1'], function () {

    //Rutas publicas sin proteccion 
    Route::post('registro', 'Api\AuthController@registro');
    Route::post('login', 'Api\AuthController@validacion');
    Route::patch('solicitud', 'Api\AuthController@solicitarRecuperacionCuenta');
    Route::get('publicos','Api\EventosController@obtenerEventosPublicos');

    //Rutas de validacion para formularios en angular
    Route::get('consultacorreo/{correo}','Api\AuthController@validarUsuario');

    Route::group(['middleware'=>'auth:api'], function(){ 
        //agregar las rutas que se deben proteger
        Route::get('autenticado','Api\AuthController@usuarioAutenticado');

        Route::get('zonas','Api\ZonasController@obtenerTodasLasZonas');
        Route::post('lectores','Api\ZonasController@registrarLector');
        Route::put('lectores','Api\ZonasController@editarLector');
        Route::get('lectores/{id}','Api\ZonasController@obtenerLectorEspecifico');
        Route::patch('lectores','Api\ZonasController@deshabilitarLectores');
        Route::patch('lectores/{id}','Api\ZonasController@deshabilitarLectorEspecifico');
        Route::patch('zonas/{id}','Api\ZonasController@deshabilitarZonaEspecifica');
        Route::patch('habilitarzona/{id}','Api\ZonasController@habilitarZonaEspecifica');
        Route::patch('habilitarlector/{id}','Api\ZonasController@habilitarLectorEspecifico');
        Route::patch('habilitarlectores','Api\ZonasController@habilitarLectores');
        Route::get('lectores','Api\ZonasController@listarLectores');        
        Route::get('lectoresdisponibles','Api\ZonasController@lectoresDisponibles');

        Route::get('habilitadas','Api\ZonasController@obtenerZonasHabilitadas');
        Route::post('zonas','Api\ZonasController@crearZonas');
        Route::put('zonas','Api\ZonasController@editarZona');
        Route::get('zonas/{id}','Api\ZonasController@obtenerZonaEspecifica');
        Route::get('deshabilitadas','Api\ZonasController@obtenerZonasDeshabilitadas');
        
        Route::get('usuarios','Api\UsuarioController@obtenerUsuarios');
        Route::get('usuarios/{id}','Api\UsuarioController@obtenerUsuarioEspecifico');
        Route::get('rolusuario/{id}','Api\UsuarioController@obtenerUsuariosPorRol');
                
        Route::get('todos','Api\EventosController@obtenerEventos');
        Route::get('eventos','Api\EventosController@obtenerEventosUsuario');
        Route::get('institucionales','Api\EventosController@obtenerEventosInstitucionales');
        Route::get('eventos/{id}','Api\EventosController@obtenerEventosPorEstado');
        Route::put('eventos/{id}','Api\EventosController@aprobarEvento');
        Route::post('eventos','Api\EventosController@crearEventos');
    });
});


















