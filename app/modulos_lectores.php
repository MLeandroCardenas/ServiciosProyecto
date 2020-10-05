<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class modulos_lectores extends Model
{
    protected $fillable = ['id', 'nombre_modulo','codigo_lector','estado','id_zona'];
    protected $hidden = ['codigo_lector'];
}
