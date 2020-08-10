<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Carnet extends Model
{
    protected $fillable = [
            'id', 
            'id_tarjeta',
            'id_usuario',
            'codigo_universitario',
            'zonas',
            'estado'
        ];
    protected $hidden = ['codigo_universitario','zonas'];
}
