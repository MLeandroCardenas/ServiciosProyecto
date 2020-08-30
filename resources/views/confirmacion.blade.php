<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
</head>
<body>
    <h2>Hola {{ $nombres }} {{ $apellidos }}, gracias por registrarte en <strong>SICAC UDEC</strong> !</h2>
    <p>Por favor confirma tu correo electrónico.</p>
    <p>Para ello simplemente debes hacer click en el siguiente enlace:</p>

    <a href="{{ url('/register/verify/' . $codigo_confirmacion) }}">
        Click para confirmar tu correo
    </a>
</body>
</html>