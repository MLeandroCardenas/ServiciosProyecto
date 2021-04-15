<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class notificaciones extends Model
{
    protected $casts = [ 
        'documentos' => 'array' 
    ]; 
    
    protected $fillable = [
        'id', 
        'id_emisor',
        'id_receptor',
        'tipo_notificacion',
        'fecha_solicitud',
        'fecha_respuesta',
        'comentario',
        'respuesta',
        'estado',
        'documentos'
        ];
    
    protected $appends = ['respuesta', 'documentos'];
}
