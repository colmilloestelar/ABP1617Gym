<!--Martín 26/10/16-->
<?php
//Ser admin
if(!isset($_SESSION))
{
    session_start();
}
if(!isset($_SESSION['userID'])){
  header('Location: paginaPrincipal.php');
}else{
  //La sesion esta seteada. Si eres deportista no entras
  require_once('../Controllers/c_Usuario.php');
  require_once("../DB/connectDB.php");

  $usuariosController = new UsuarioController();
  $user = $usuariosController->getUserByEmail($_SESSION['userID']);

  if(!$user['tipoUsuario']=='admin'){
    header('Location: paginaPrincipal.php');
  }
  else{
?>
<!DOCTYPE html>
<html>
  <head>
    <title>Gestion de Ejercicio</title>
    <?php
    require_once('NavBar.php');
    require_once('../Controllers/c_Ejercicio.php');
    require_once("../DB/connectDB.php");

    $ejerciciosController = new EjercicioController();
    $ejercicios = $ejerciciosController->gestionEjercicios();
    ?>
  </head>

  <body>

    <div class="tabla panel-default">

      <div class = 'row panel-heading'>
        <span class ="col-md-2">Nombre de ejercicio</span> <span class="col-md-2" >Opciones</span>
      </div>
      <?php foreach($ejercicios as $it){ ?>
        <div class="row">
        <span class="col-md-2"><?php echo ($it['nomEjercicio']); ?> </span>
        <button type="submit" form="borrar" class="btn btn-danger col-md-1" name="idEjercicio" value = <?php echo("".$it['idEjercicio']."");?>>Borrar</button>
        <button onclick="location.href='ModificarEjercicio.php?id=<?php echo($it['idEjercicio']);?>'" class="btn btn-warning col-md-1">Modificar</button>
      </div>
        <form method= "post" action = "../Controllers/c_Ejercicio.php?op=0" class ='derecha' id="borrar">
        </form>

      <?php } ?>

      <button onclick="location.href='CrearEjercicio.php'" class="btn btn-success">Crear Nuevo Ejercicio</button>
    </div>

  </body>
</html>
<?php
}
}
?>
