<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class HorariosEventos extends Model
{
    protected $fillable = ['id', 'id_evento', 'fecha'];
}
