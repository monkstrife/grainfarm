<?php
    require "php/auth.php";
    include './config.php';
?>


<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ростовская ферма</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>

<header>
    <h1>Ростовская ферма</h1>
</header>

<nav>
    <form action="index.php" method="post">
        <ul>
            <?php require "php/menu.php";?>
        </ul>
    </form>
</nav>

<main>
    <?php require "php/main.php";?>
</main>

<footer>
    <p>&copy; 2024 Ростовская ферма. Все права защищены.</p>
</footer>
<script>
    window.onload = function () {
        
    var chart = new CanvasJS.Chart("chartContainer", {
        animationEnabled: true,
        exportEnabled: true,
        theme: "light1", // "light1", "light2", "dark1", "dark2"
        title:{
            text: "График зависимости продукции и их числа"
        },
        axisY:{
            includeZero: true
        },
        data: [{
            type: "column", //change type to bar, line, area, pie, etc
            //indexLabel: "{y}", //Shows y value on all Data Points
            indexLabelFontColor: "#5A5757",
            indexLabelPlacement: "outside",   
            dataPoints: <?php echo json_encode($dataPoints, JSON_NUMERIC_CHECK); ?>
        }]
    });
    chart.render();      
}
</script>
<script src="data.json"></script>
<script src="js/func.js"></script>
<script src="https://cdn.canvasjs.com/canvasjs.min.js"></script>
</body>
</html>
