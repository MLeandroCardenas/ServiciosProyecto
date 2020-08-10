<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEventosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('eventos', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('creador_evento');
            $table->integer('id_zona');
            $table->string('nombre_evento',50);     
            $table->string('descripcion',100); 
            $table->string('visibilidad',13);
            $table->json('horario')->nullable();
            $table->boolean('estado');           
            $table->json('usuarios_externos_invitados')->nullable();
            $table->json('usuarios_registrados_invitados')->nullable();
            $table->json('asistentes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('eventos');
    }
}
