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
    protected $hidden = ['identificacion','foto'];
}
