<?php

Route::get('/', function () {
    return view('welcome');
});

Route::get('/register/verify/{code}', 'AuthController@verificar');

