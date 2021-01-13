<?php

namespace App;
use Illuminate\Database\Eloquent\Model;

class Eventos extends Model
{
    protected $fillable = [
        'id', 
        'creador_evento',
        'zona',
        'nombre_evento',
        'descripcion',
        'visibilidad',
        'horario',
        'estado'
        ];
}
