<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class EventoDescartado extends Notification
{
    use Queueable;
    protected $comentario;
    protected $nombreEvento;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct($comentario, $nombreEvento)
    {
        $this->comentario = $comentario;
        $this->nombreEvento = $nombreEvento;
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
                    ->subject('Evento rechazado')
                    ->line('Su evento '.$this->nombreEvento.' ha sido rechazado')
                    ->line('Observaciones: '.$this->comentario);
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
