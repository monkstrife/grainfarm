<?php
header('Content-Type: text/html; charset-utf-8');

// Сервер
// $host = "localhost";
// $user = "valerauk_grain";
// $password = "z0*C2gbj";
// //database
// $db = "valerauk_grain";

// Локальный
$host = "localhost";
$user = "root";
$password = "";
//database
$db = "grainfarm";

//процедурный стиль
$con = mysqli_connect($host, $user, $password, $db);

if(!$con)
{
    echo "<br>Невозможно присоединиться к серверу: " . mysqli_error($con);
    exit;
}
mysqli_query($con, "SET NAMES 'utf8'");

$dsn="mysql:host=$host;dbname=$db;charset=utf8";
$connect=new PDO($dsn, $user, $password);

try{
    $connect = new PDO($dsn, $user, $password);
    $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
}
catch (PDOException $e)
{
    echo $e->getMessage();
}

?>