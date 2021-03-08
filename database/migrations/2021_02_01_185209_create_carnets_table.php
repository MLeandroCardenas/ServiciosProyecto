<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCarnetsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */

    public function up()
    {
        Schema::create('carnets', function (Blueprint $table) {
            $table->increments('id');
            $table->string('id_tarjeta',64)->unique()->nullable();
            $table->integer('id_usuario')->nullable();
            $table->string('codigo_universitario')->nullable();
            $table->json('zonas')->nullable();
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
        Schema::dropIfExists('carnets');
    }
}
