<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Usuarios extends Model
{

    protected $fillable = [
        'id',
        'id_user', 
        'apellidos', 
        'nombres',
        'identificacion',
        'estado',
        'foto',
        'id_rol'
    ];

    public function getIdentificacionAttribute($value)
    {
        try {
            return decrypt($value);
        } catch (DecryptException $e) {
            return response()->json('ERROR', 500); 
        }
    }

    public function setIdentificacionAttribute($value) 
    {
        $this->attributes['identificacion'] = encrypt($value);
    }

    public function setApellidosAttribute($value) 
    {
        $this->attributes['apellidos'] = strtoupper($value);
    }

    public function setNombresAttribute($value) 
    {
        $this->attributes['nombres'] = strtoupper($value);
    }
}
