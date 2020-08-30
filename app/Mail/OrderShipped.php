<?php
namespace App\Mail;

use App\Usuarios;
use App\User;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class OrderShipped extends Mailable
{
    use Queueable, SerializesModels;
    protected $usuarios;
    protected $codigo;


    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(Usuarios $usuarios, User $codigo)
    {
        $this->usuarios = $usuarios;
        $this->codigo = $codigo;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('confirmacion')
                    ->with([
                        'nombres' => $this->usuarios->nombres,
                        'apellidos' => $this->usuarios->apellidos,
                        'codigo_confirmacion' => $this->codigo->codigo_confirmacion,
                    ])->subject("Completa tu registro");
    }
}
