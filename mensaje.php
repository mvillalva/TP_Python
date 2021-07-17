<?php
    header("Content-type: text/html;charset=\"utf-8\"");
    $nombre     = $_POST['nombre'];
    $apellido   = $_POST['apellido'];
    $email      = $_POST['email'];
    $telefono   = empty($_POST['telefono'])? '""': $_POST['telefono'];
    $asunto     = $_POST['asunto'];
    $mensaje    = $_POST['mensaje'];

    function cargarOptions() {
        $option     = '';
        $asunto     = $_POST['asunto'];
        $opciones   = ['Consulta', 'Registro', 'Otro'];

        for($contador = 0; $contador < 3; $contador++){
            $option .= '<option value="'.$contador.'"';
            
            if($contador+1 == $asunto) {
                $option .= ' selected ';
            }

            $option .= '>'.$opciones[$contador].'</option>';
        }
        
        return $option;
    }
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Test</title>
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=Fredericka+the+Great&display=swap" rel="stylesheet">                
        <link href="https://fonts.googleapis.com/css2?family=Catamaran:wght@300;400;600;900&display=swap" rel="stylesheet">
        <link rel="shortcut icon" type="image/png" href="img/Resto.png" />
        <link rel="stylesheet" href="css/normalize.css" />
        <link rel="stylesheet" href="css/style.css" />        
        <script src="https://kit.fontawesome.com/e547f827f8.js" crossorigin="anonymous"></script>
    </head>
    <body class="mensaje">
        <main>
            <section class="contacto" id="contacto">
                <div class="contacto__container contacto__container--size">
                    <div class="contacto__header">
                        <hr class="contacto__line">
                        <h1 class= "contacto__title">Su Mensaje</h1>                    
                        <hr class="contacto__line">
                    </div>
                    <div class="contacto__row-container">
                        <div class="contacto__col">
                            <form class="contacto__form">
                                <div class="contacto__row">
                                    <div class="contacto__col col__w100p">
                                        <label class="contacto__label" for="nombre">Nombre</label>
                                        <input class="contacto__text" type="text" name="nombre" id="nombre" value=<?php echo $nombre ?> disabled>
                                    </div>
                                    <div class="contacto__col col__w100p">
                                        <label class="contacto__label" for="apellido">Apellido</label>
                                        <input class="contacto__text" type="text" name="apellido" id="apellido" value=<?php echo $apellido ?> disabled>
                                    </div>
                                </div>
                                <div class="contacto__row">
                                    <div class="contacto__col col__w100p">
                                        <label class="contacto__label" for="email">email</label>
                                        <input class="contacto__text" type="email" name="email" id="email" value=<?php echo $email ?> disabled>
                                    </div>
                                    <div class="contacto__col col__w100p">
                                        <label class="contacto__label" for="telefono">Teléfono</label>
                                        <input class="contacto__text" type="tel" name="telefono" id="telefono" value=<?php echo $telefono ?> disabled>
                                    </div>
                                </div>
                                <div class="contacto__row">
                                    <div class="contacto__col col__w100p">
                                        <label class="contacto__label" for="asunto">Asunto</label>
                                        <select class="contacto__select" name="asunto" id="asunto" disabled>
                                            <?= cargarOptions() ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="contacto__row">
                                    <div class="contacto__col col__w100p">
                                        <label class="contacto__label" for="mensaje">Mensaje</label>
                                        <textarea class="contacto__area" name="mensaje" id="mensaje" cols="30" rows="5" disabled><?php echo $mensaje ?></textarea>
                                    </div>
                                </div>
                                <div class="contacto__row">
                                    <div class="contacto__col contacto--center">
                                        <a class="contacto__button" href="index.html">Vovler<span class="contacto__button-icon"></span></a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <footer>
            <div class="footer">
                <div class="footer__container">
                    <a href="#." class="footer__icon footer--blue"><i class="footer__icon--text fab fa-facebook"></i></a>
                    <a href="#." class="footer__icon footer--lightblue"><i class="footer__icon--text fab fa-twitter"></i> </a>
                    <a href="#." class="footer__icon footer--gradient"><i class="footer__icon--text fab fa-instagram"></i></a>                
                </div>
                <p class="footer__copy-right">MaxLeonV &copy; 2021</p>
            </div>
        </footer>
    </body>
</html>