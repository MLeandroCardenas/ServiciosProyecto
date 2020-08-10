<?php

namespace App;
use Illuminate\Database\Eloquent\Model;

class Eventos extends Model
{
    
    protected $casts = [ 
        'usuarios_externos_invitados' => 'array',
        'usuarios_externos_invitados' => 'array',
        'asistentes' => 'array',
        'horario' => 'array', 'timestamp'
    ];
    
    protected $fillable = [
        'id', 
        'creador_evento',
        'id_zona',
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
