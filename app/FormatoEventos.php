<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class FormatoEventos extends Model
{
    protected $fillable = ['id', 'nombre','apellido','cedula','procedencia','correo','estado'];
    protected $hidden = ['cedula','correo'];
}
