<?php
//Martín 2/11/16
require_once('../Controllers/c_Ejercicio.php');
require_once("../DB/connectDB.php");

$ejerciciosController = new EjercicioController();
$ejercicio = $ejerciciosController->getEjercicio($_GET['id']);
$id = $_GET['id'];
?>

<form method="post" action="../Controllers/c_Ejercicio.php?op=1">
  <input type="text" name="nomEjercicio" value="<?php echo($ejercicio['nomEjercicio']);?>" />
  <input type="submit" name="idEjercicio" value=<?php echo("".$id."");?>>
</form>
