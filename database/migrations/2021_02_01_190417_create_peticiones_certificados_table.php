<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePeticionesCertificadosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('peticiones_certificados', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('id_formato');
            $table->integer('id_evento');
            $table->timestamp('fecha_radicado');
            $table->timestamp('fecha_respuesta')->nullable();
            $table->string('respuesta');
            $table->boolean('estado');
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
        Schema::dropIfExists('peticiones_certificados');
    }
}
