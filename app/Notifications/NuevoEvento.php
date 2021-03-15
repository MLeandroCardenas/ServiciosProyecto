<?php
namespace App\Notifications;

use App\Usuarios;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class NuevoEvento extends Notification
{
    use Queueable;
    protected $nombres;
    protected $apellidos;
    protected $rol;
    protected $evento;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct($nombres, $apellidos, $rol, $evento)
    {
        $this->nombres = $nombres;
        $this->apellidos = $apellidos;
        $this->rol = $rol;
        $this->evento = $evento;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($notifiable)
    {        
        return (new MailMessage)
                    ->subject('Nuevo evento disponible')
                    ->line('El usuario '.$this->nombres. ' '. $this->apellidos. ' con rol '.$this->rol. ' ha creado el evento')
                    ->line('Nombre de evento: '.$this->evento)
                    ->line('Por favor revise el sistema para su aprobacion');
    }

    /**
     * Get the array representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function toArray($notifiable)
    {
        return [
            //
        ];
    }
}
