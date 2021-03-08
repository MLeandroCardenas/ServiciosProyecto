<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateInvitadosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('invitados', function (Blueprint $table) {
            $table->increments('id');
            $table->string('nombre',30);
            $table->string('apellido',30);
            $table->string('cedula',15)->unique();
            $table->string('procedencia',100);
            $table->string('correo',200)->unique();
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
        Schema::dropIfExists('invitados');
    }
}
