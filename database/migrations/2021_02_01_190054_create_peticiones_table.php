<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePeticionesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('peticiones', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('id_usuario');
            $table->timestamp('fecha_radicacion');
            $table->timestamp('fecha_respuesta')->nullable();
            $table->integer('tipo_peticion');
            $table->json('documentos')->nullable();
            $table->string('respuesta',200)->nullable();
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
        Schema::dropIfExists('peticiones');
    }
}
