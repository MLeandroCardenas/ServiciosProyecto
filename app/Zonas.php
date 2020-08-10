<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Zonas extends Model
{
    protected $fillable = ['nombre_zona', 'codigo_lector','estado','sede'];
    protected $hidden = ['codigo_lector'];
}
