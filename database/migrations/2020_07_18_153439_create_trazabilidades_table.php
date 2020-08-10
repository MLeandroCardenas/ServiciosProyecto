<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTrazabilidadesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('trazabilidades', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('id_carnet');
            $table->integer('id_zona');
            $table->timestamp('fecha_ingreso')->nullable();
            $table->timestamp('fecha_salida')->nullable();
            $table->boolean('resultado');
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
        Schema::dropIfExists('trazabilidades');
    }
}
