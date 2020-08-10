<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Peticiones extends Model
{
    protected $fillable = [
        'id', 
        'id_usuario',
        'fecha_radicacion',
        'fecha_respuesta',
        'tipo_peticion',
        'documentos',
        'respuesta',
        'estado'
    ];
    protected $hidden = ['documentos','respuesta'];
    
}
