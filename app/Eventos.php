<?php

namespace App;
use Illuminate\Database\Eloquent\Model;

class Eventos extends Model
{
    protected $casts = [ 
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
        'certificado',
        'estado'
        ];
    
    protected $appends = ['fecha', 'hora']; 
    
    public function getFechaJson(){
        return array_get($this->horario, 'fecha', []);
    }

    public function getHoraJson(){
        return array_get($this->horario, 'hora', []);
    }
}
