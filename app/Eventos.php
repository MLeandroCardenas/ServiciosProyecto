<?php

namespace App;
use Illuminate\Database\Eloquent\Model;

class Eventos extends Model
{
    
    protected $casts = [ 
        'usuarios_externos_invitados' => 'array',
        'usuarios_externos_invitados' => 'array',
        'asistentes' => 'array',
        'horario' => 'array'
    ];
    
    protected $fillable = [
        'id', 
        'creador_evento',
        'zona',
        'nombre_evento',
        'descripcion',
        'visibilidad',
        'horario',
        'estado',
        'usuarios_externos_invitados',
        'usuarios_registrados_invitados',
        'asistentes'
        ];

    protected $hidden = ['usuarios_externos_invitados','usuarios_registrados_invitados','asistentes'];
}
