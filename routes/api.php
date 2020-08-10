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
|
*/

 //rutas protegidas
 Route::post('zonas','Api\ZonasController@crearZonas');
 Route::get('zonas','Api\ZonasController@obtenerTodasLasZonas');
 Route::get('zonas/{id}','Api\ZonasController@obtenerZonaEspecifica');
 Route::get('habilitadas','Api\ZonasController@obtenerZonasHabilitadas');
 Route::get('deshabilitadas','Api\ZonasController@obtenerZonasDeshabilitadas');
 Route::Patch('zonas','Api\ZonasController@deshabilitarZonas');
 Route::patch('zonas/{id}','Api\ZonasController@deshabilitarZonaEspecifico');
 Route::put('zonas','Api\ZonasController@editarZona');
 Route::patch('habilitarzonas','Api\ZonasController@habilitarZonas');
 Route::patch('habilitarzonas/{id}','Api\ZonasController@habilitarZonaEspecifico');

 Route::get('usuarios','Api\UsuarioController@obtenerUsuarios');
 Route::get('usuarios/{id}','Api\UsuarioController@obtenerUsuarioEspecifico');
 Route::get('usuarios/{id}','Api\UsuarioController@obtenerUsuariosPorRol');

 Route::get('todos','Api\EventosController@obtenerEventos');
 Route::get('eventos','Api\EventosController@obtenerEventosUsuario');
 Route::get('eventos/{id}','Api\EventosController@obtenerEventosPorEstado');
 Route::put('eventos/{id}','Api\EventosController@aprobarEvento');
 Route::post('eventos','Api\EventosController@crearEventos');
 
 Route::group(['middleware'=>'auth:api'], function(){ 
});

Route::post('registro', 'Api\AuthController@registro');




