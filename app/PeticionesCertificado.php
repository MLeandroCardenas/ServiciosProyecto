<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PeticionesCertificado extends Model
{
    protected $fillable = [
        'id', 
        'id_formato',
        'id_evento',
        'fecha_radicado',
        'fecha_respuesta',
        'respuesta',
        'estado'
    ];
    protected $hidden = ['respuesta'];
}
