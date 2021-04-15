<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateNotificacionesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('notificaciones', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('id_emisor');
            $table->unsignedSmallInteger('id_receptor');
            $table->unsignedSmallInteger('tipo_notificacion');
            $table->date('fecha_solicitud');
            $table->date('fecha_respuesta')->nullable();
            $table->string('comentario',200)->nullable();
            $table->string('respuesta',200)->nullable();
            $table->unsignedSmallInteger('estado');
            $table->json('documentos')->nullable();


            


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
        Schema::dropIfExists('notificaciones');
    }
}
