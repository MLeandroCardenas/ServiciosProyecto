<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Trazabilidades extends Model
{
    protected $fillable = [
        'id', 
        'id_carnet',
        'id_zona',
        'fecha_ingreso',
        'fecha_salida',
        'resultado'
    ];
    protected $hidden = ['fecha_ingreso','fecha_salida'];
}
