<?php
    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\Exception;

    require 'vendor/autoload.php';



    function returnNumbers($name, $con)
    {
        $sql = 'SELECT GetTotalWeightByGrainType("'.$name.'")';
        $query = mysqli_query($con, $sql);

        while($r = mysqli_fetch_assoc($query))
        {
            $result = $r['GetTotalWeightByGrainType("'.$name.'")'];
            return $result;
        }
    }

    if(isset($_POST['aboutus']))
    {
        echo '<section id="about">
        <h2>О нас</h2>
        <p>Наша история началась более 40 лет назад, когда небольшая семья из Ростовской области решила посвятить себя фермерству. Начав с одного поля, мы постепенно развивали наше дело, вкладывая душу и труд в каждый этап. 
        Сегодня "Ростовская ферма" — это большая команда людей, объединённых любовью к природе и желанием приносить нашим клиентам только самое лучшее. 
        Мы гордимся тем, что сохраняем традиции экологического земледелия, поддерживая устойчивое развитие нашего региона. Спасибо, что выбираете нас!</p>
    </section>';
    }
    else if (isset($_POST['products']) || isset($_POST['subadd1']) || isset($_POST['subadd2']) || isset($_POST['subadd3']) || isset($_POST['subadd4']) || isset($_POST['subadd5']) || isset($_POST['subdel1']) || isset($_POST['subdel2']) || isset($_POST['subdel3']) || isset($_POST['subdel4']) || isset($_POST['subdel5']))
    {
        if(!isset($_POST['products']) && !(isset($_POST['subdel1']) || isset($_POST['subdel2']) || isset($_POST['subdel3']) || isset($_POST['subdel4']) || isset($_POST['subdel5'])))
        {
            $_SESSION['add1'] = $_POST['add1'];
            $_SESSION['add2'] = $_POST['add2'];
            $_SESSION['add3'] = $_POST['add3'];
            $_SESSION['add4'] = $_POST['add4'];
            $_SESSION['add5'] = $_POST['add5'];
        }
        else if(isset($_POST['subdel1']) || isset($_POST['subdel2']) || isset($_POST['subdel3']) || isset($_POST['subdel4']) || isset($_POST['subdel5']))
        {
            if(isset($_POST['subdel1']))
            {
                $_SESSION['add1'] = 0;
            }
            if(isset($_POST['subdel2']))
            {
                $_SESSION['add2'] = 0;
            }
            if(isset($_POST['subdel3']))
            {
                $_SESSION['add3'] = 0;
            }
            if(isset($_POST['subdel4']))
            {
                $_SESSION['add4'] = 0;
            }
            if(isset($_POST['subdel5']))
            {
                $_SESSION['add5'] = 0;
            }
        }

        if(!isset($_SESSION['add1']))
            {
                $start_value = array('0', '0', '0', '0', '0');
                $_SESSION['add1'] = 0;
                $_SESSION['add2'] = 0;
                $_SESSION['add3'] = 0;
                $_SESSION['add4'] = 0;
                $_SESSION['add5'] = 0;
            }
            else
            {
                $start_value = array($_SESSION['add1'], $_SESSION['add2'], $_SESSION['add3'], $_SESSION['add4'], $_SESSION['add5']);
            }

        $numbersArray = array("", "", "", "", "");
        $product_array = array("", "", "", "", "");
        $del_array = array("", "", "", "", "");
        if(isset($_COOKIE[session_id()]))
        {
            if(json_decode($_COOKIE[session_id()], true)[2] == 2)
            {
                $numbersArray = array(returnNumbers("Пшеница", $con), returnNumbers("Ячмень", $con), returnNumbers("Кукуруза", $con), returnNumbers("Подсолнух", $con), returnNumbers("Гречиха", $con));
                $product_array = array("<input name='add1' type='number' value='".$_SESSION['add1']."' max='$numbersArray[0]' min='0'/><button class='addbut' type='submit' name='subadd1'>Добавить в корзину</button>", "<input name='add2' type='number' value='".$_SESSION['add2']."' max='$numbersArray[1]' min='0'/><button class='addbut' type='submit' name='subadd2'>Добавить в корзину</button>", "<input name='add3' type='number' value='".$_SESSION['add3']."' max='$numbersArray[2]' min='0'/><button class='addbut' type='submit' name='subadd3'>Добавить в корзину</button>", "<input name='add4' type='number' value='".$_SESSION['add4']."' max='$numbersArray[3]' min='0'/><button class='addbut' type='submit' name='subadd4'>Добавить в корзину</button>", "<input name='add5' type='number' value='".$_SESSION['add5']."' max='$numbersArray[4]' min='0'/><button class='addbut' type='submit' name='subadd5'>Добавить в корзину</button>");
                if($_SESSION['add1'] != 0)
                {
                    $del_array[0] = "<button class='delbut' type='submit' name='subdel1'>Удалить</button>";
                }
                if($_SESSION['add2'] != 0)
                {
                    $del_array[1] = "<button class='delbut' type='submit' name='subdel2'>Удалить</button>";
                }
                if($_SESSION['add3'] != 0)
                {
                    $del_array[2] = "<button class='delbut' type='submit' name='subdel3'>Удалить</button>";
                }
                if($_SESSION['add4'] != 0)
                {
                    $del_array[3] = "<button class='delbut' type='submit' name='subdel4'>Удалить</button>";
                }
                if($_SESSION['add5'] != 0)
                {
                    $del_array[4] = "<button class='delbut' type='submit' name='subdel5'>Удалить</button>";
                }
            }
        }

        echo '<section id="products">
        <h2>Продукция</h2>
        <div class="products-section">
        <form action="index.php" method="post">
            <div class="product">
                <img src="png/пшеница.png" alt="Пшеница">
                <div class="product-description">
                    <h3>Пшеница</h3>
                    <p>Качественная пшеница, идеально подходящая для выпечки и производства муки.</p>
                </div>
                <div class="product-bd">
                
                
                '.$product_array[0].'
                '.$del_array[0].'
                </div>
                
            </div>
            <div class="product">
                <img src="png/ячмень.png" alt="Ячмень">
                <div class="product-description">
                    <h3>Ячмень</h3>
                    <p>Свежий ячмень для приготовления каш и кормов для животных.</p>
                </div>
                <div class="product-bd">
                <form action="index.php" method="post">
                
                '.$product_array[1].'
                '.$del_array[1].'
                </div>
            </div>
            <div class="product">
                <img src="png/кукуруза.png" alt="Кукуруза">
                <div class="product-description">
                    <h3>Кукуруза</h3>
                    <p>Сладкая и сочная кукуруза, выращенная с любовью.</p>
                </div>
                <div class="product-bd">
                <form action="index.php" method="post">
                
                '.$product_array[2].'
                '.$del_array[2].'
                </div>
            </div>
            <div class="product">
                <img src="png/подсолнух.png" alt="Подсолнух">
                <div class="product-description">
                    <h3>Подсолнух</h3>
                    <p>Подсолнухи для производства масла и семечек.</p>
                </div>
                <div class="product-bd">
                <form action="index.php" method="post">
                
                '.$product_array[3].'
                '.$del_array[3].'
                </div>
            </div>
            <div class="product">
                <img src="png/гречиха.png" alt="Гречиха">
                <div class="product-description">
                    <h3>Гречиха</h3>
                    <p>Полезная и питательная гречиха для здорового питания.</p>
                </div>
                <div class="product-bd">
                <form action="index.php" method="post">
                
                '.$product_array[4].'
                '.$del_array[4].'
                </div>
            </div>
        </form>    
        </div>
    </section>';
    }
    else if (isset($_POST['contacts']))
    {
        echo '<section id="contacts">
        <h2>Контакты</h2>
        <p>Мы всегда рады общению с нашими клиентами и партнёрами! Если у вас есть вопросы, пожелания или вы хотите сделать заказ, свяжитесь с нами:</p>
        <ul>
            <li>Адрес: Ростовская область, ул. Фермерская, д. 10</li>
            <li>Телефон: +7 (800) 123-45-67</li>
            <li>Email: info@rostovfarm.ru</li>
        </ul>
        <p>Следите за нашими новостями и акциями в социальных сетях:</p>
        <ul>
            <li><a href="#">ВКонтакте</a></li>
            <li><a href="#">Instagram</a></li>
            <li><a href="#">Facebook</a></li>
        </ul>
    </section>';
    }
    else if (isset($_POST['basket']) || isset($_POST['send']))
    {
        if(isset($_POST['send']))
        {
            $jsonarray = json_decode($_COOKIE[session_id()], true);
            $mail = new PHPMailer();
            $mail->setFrom('testmailforvoucher@gmail.com', 'Valery Drobilko');
            $mail->addAddress($jsonarray[5], $jsonarray[3]);
            $mail->Subject = "Заказ в Ростовской ферме для ".$jsonarray[3]." на ".date('d-m-Y');
            // $mail->AddEmbeddedImage($img, 'logo');
            // $mail->AddAttachment($name.".txt");

            $mail->msgHTML("<html><body>
                            <h1>Уважаемый ".$jsonarray[3]."</h1>
                            <p>Наш ферма рад предложить Вам услугу <b>поставки зерна</b>.<br>"
                            ."Вы заказали: ".$_SESSION['summ']." тон.<br></html></body>"
                        );
            $mail->CharSet = "UTF-8";
            $mail->send();
        }

        $basket_array = array("","","","","");
        $summ = 0;
        $_SESSION['summ'] = 0;
        if($_SESSION['add1'] != 0)
        {
            $basket_array[0] = '<li>Пшеница: '.$_SESSION['add1'].' тон</li>';
            $summ += $_SESSION['add1'];
        }
        if($_SESSION['add2'] != 0)
        {
            $basket_array[1] = '<li>Ячмень: '.$_SESSION['add2'].' тон</li>';
            $summ += $_SESSION['add2'];
        }
        if($_SESSION['add3'] != 0)
        {
            $basket_array[2] = '<li>Кукуруза: '.$_SESSION['add3'].' тон</li>';
            $summ += $_SESSION['add3'];
        }
        if($_SESSION['add4'] != 0)
        {
            $basket_array[3] = '<li>Подсолнух: '.$_SESSION['add4'].' тон</li>';
            $summ += $_SESSION['add4'];
        }
        if($_SESSION['add5'] != 0)
        {
            $basket_array[4] = '<li>Гречиха: '.$_SESSION['add5'].' тон</li>';
            $summ += $_SESSION['add5'];
        }
        $_SESSION['summ'] = $summ;
        
        echo '<section id="contacts">
        <h2>Корзина</h2>
        <p>Прежде, чем оформить заказ, не забудьте указать свою почту в разделе "Главная"! Вы выбрали:</p>
        <ul>
            '.$basket_array[0].'
            '.$basket_array[1].'
            '.$basket_array[2].'
            '.$basket_array[3].'
            '.$basket_array[4].'
        </ul>
        <p>Итого: '.$summ.' тон</p>
        <form action="index.php" method="post">
            <button class="sendemail" type="submit" name="send">Отправить на почту</button>
        </form>
    </section>';
    }
    else if (isset($_POST['info']) || isset($_POST['work']) ||isset($_POST['alltype']) || isset($_POST['allempl']) || isset($_POST['graf']) || isset($_POST['delempl']) || isset($_POST['addempl']) || isset($_POST['loadtobd']) || isset($_POST['delfrombd']))
    {
        if(json_decode($_COOKIE[session_id()], true)[2] == 0)
        {
            $nameH = "Работа с базой";
            $butwork = '<button class="flbut" type="submit" name="delempl">Удалить работника</button>
                <button class="flbut" type="submit" name="addempl" onclick="refresh();">Добавить работника</button>';
        }
        else
        {
            $nameH = "Информация о базе";
            $butwork = "";
        }

        echo '<section id="info">
        <h2>'.$nameH.'</h2>
        <form action="index.php" method="post">
            <div class="listbutton">
                <button class="flbut" type="submit" name="alltype">Показать все типы продукции</button>
                <button class="flbut" type="submit" name="allempl">Показать всех работников</button>
                <button class="flbut" type="submit" name="graf">Показать график распределения продукции</button>
                '.$butwork.'
            </div>
        </form>        
    </section>';

        if(isset($_POST['alltype']))
        {
            $sql = 'SELECT * FROM allgraintypes';

            echo '<table border="1" width="700" cellpadding="0" cellspacing="0" style="font-size: 20px;">';

            $query = mysqli_query($con, $sql);

            echo '<tr><td><b>Id</b></td><td><b>Название продукции</b></td></tr>';

            while($r = mysqli_fetch_assoc($query))
            {
                $с1 = $r['grain_type_id'];
                $с2 = $r['grain_name'];
                echo "<tr><td>$с1</td><td>$с2</td></tr>";
            }
            echo '</table>';
        }
        else if(isset($_POST['allempl']))
        {
            $sql = 'SELECT * FROM Employees';

            echo '<table border="1" width="700" cellpadding="0" cellspacing="0" style="font-size: 20px;">';

            $query = mysqli_query($con, $sql);

            echo '<tr><td><b>Id</b></td><td><b>Имя</b></td><td><b>Фамилия</b></td><td><b>Номер должность</b></td><td><b>Дата вступления на работу</b></td></tr>';

            while($r = mysqli_fetch_assoc($query))
            {
                $с1 = $r['employee_id'];
                $с2 = $r['first_name'];
                $с3 = $r['last_name'];
                $с4 = $r['position_id'];
                $с5 = $r['hire_date'];
                echo "<tr><td>$с1</td><td>$с2</td><td>$с3</td><td>$с4</td><td>$с5</td></tr>";
            }
            echo '</table>';
        }
        else if(isset($_POST['graf']))
        {
            $dataPoints = array();

            $sql = "SELECT * FROM viewforgraf";
            $query = mysqli_query($con, $sql);
            while($r = mysqli_fetch_assoc($query))  
            {
                array_push($dataPoints, array("x"=> (float)$r["grain_id"], "y"=> (float)$r["sum"], "indexLabel"=> $r["grain_name"]));
            }

            echo '<div id="chartContainer" style="height: 370px; width: 100%;"></div>';
        }
        else if(isset($_POST['addempl']) || isset($_POST['loadtobd']))
        {
            if(isset($_POST['loadtobd']))
            {
                for($i = 1; $i <= $_COOKIE["count_table"]; $i++)
                {
                    $countEm = 0;
                    $sql = "SELECT * FROM maxempl";
                    $res = $connect->prepare($sql);
                    $res->execute();
                    foreach($res as $row)
                    {
                        $countEm += $row[0];
                    }
                    $countEm++;

                    $sql = "CALL AddEmployees(:arg1, :arg2, :arg3, :arg4);";
                    $res = $connect->prepare($sql);
                    $res->bindParam('arg1', $countEm);
                    $res->bindParam('arg2', $_POST['fn'.$i]);
                    $res->bindParam('arg3', $_POST['ln'.$i]);
                    $res->bindParam('arg4', $_POST['s'.$i]);
                    $res->execute();

                    if(isset($_POST['cb'.$i]))
                    {
                        $countMan = 0;
                        $sql = "SELECT * FROM maxman";
                        $res = $connect->prepare($sql);
                        $res->execute();
                        foreach($res as $row)
                        {
                            $countMan += $row[0];
                        }
                        $countMan++;

                        $sql = "CALL AddManagers(:arg1, :arg2);";
                        $res = $connect->prepare($sql);
                        $res->bindParam('arg1', $countMan);
                        $res->bindParam('arg2', $countEm);
                        $res->execute();
                    }
                }
            }

            $sql = "SELECT * FROM allposition";
            $query = mysqli_query($con, $sql);
            $arrayPos = array();
            $countPos = 0;
            while($r = mysqli_fetch_assoc($query))
            {
                $с1 = $r['position_id'];
                $с2 = $r['position_name'];
                $arrayPos["".$r["position_id"].""] = $r['position_name'];
                $countPos++;
            }
            $OptionSt = "";

            for($i = 0; $i < $countPos;$i++)
            {
                $OptionSt .= '<option value='.($i + 1).'>'.$arrayPos[(string)($i + 1)].'</option>';
            }

            $dataLoad = "data = '";
            $dataLoad .= json_encode($arrayPos, JSON_UNESCAPED_UNICODE) . "';";
            file_put_contents('data.json', $dataLoad);

            echo '
            <div class="listbutton2">
                <button class="foraddbut" name="pusbut" onclick="sayp();">+</button>
                <button class="foraddbut" name="minbut" onclick="saym();">-</button>
            </div>
            <form action="index.php" id="formloadtobd" method="post">
                <table border="1" width="700" cellpadding="0" cellspacing="0" style="font-size: 20px;">
                    <tr><td><b>Имя</b></td><td><b>Фамилия</b></td><td><b>Должность</b></td><td><b>Начальник?</b></td></tr>
                    <tr id="tr1"><td><input name="fn1" type="text"/></td><td><input name="ln1" type="text"/></td><td><select name="s1">'.$OptionSt.'</select></td><td><input name="cb1" type="checkbox"/></td></tr>
                </table> 
                <div id="loadtobd">
                    <button class="foraddbut" type="submit" name="loadtobd">Загрузить в базу</button>
                </div>
            </form>';
        }
        else if(isset($_POST['delempl']) || isset($_POST['delfrombd']))
        {
            if(isset($_POST['delfrombd']))
            {
                for($i = 1; $i < $_SESSION["count_for_del"]; $i++)
                {
                    if(isset($_POST['cbd'.$i]))
                    {
                        $sql = "CALL ExistsMan(:arg1);";
                        $res = $connect->prepare($sql);
                        $res->bindParam('arg1', $_POST["cbd".$i]);
                        $res->execute();
                        $c = 0;
                        foreach($res as $row)
                        {
                            $c = $row[0];
                        }
                        if($c == "1")
                        {
                            $sql = "CALL DelManagers(:arg1);";
                            $res = $connect->prepare($sql);
                            $res->bindParam('arg1', $_POST["cbd".$i]);
                            $res->execute();
                        }

                        $sql = "CALL DelEmployees(:arg1);";
                        $res = $connect->prepare($sql);
                        $res->bindParam('arg1', $_POST["cbd".$i]);
                        $res->execute();
                    }
                }
            }

            $sql = 'SELECT * FROM Employees';

            echo '<form action="index.php" id="formloadtobd" method="post">
            <table border="1" width="700" cellpadding="0" cellspacing="0" style="font-size: 20px;">';

            $query = mysqli_query($con, $sql);

            echo '<tr><td><b>Id</b></td><td><b>Имя</b></td><td><b>Фамилия</b></td><td><b>Номер должность</b></td><td><b>Дата вступления на работу</b></td><td><b>Удалить?</b></td></tr>';

            $count = 1;
            while($r = mysqli_fetch_assoc($query))
            {
                $с1 = $r['employee_id'];
                $с2 = $r['first_name'];
                $с3 = $r['last_name'];
                $с4 = $r['position_id'];
                $с5 = $r['hire_date'];
                echo "<tr><td>$с1</td><td>$с2</td><td>$с3</td><td>$с4</td><td>$с5</td><td><input name='cbd".$count."' type='checkbox' value='$с1'/></td></tr>";
                $count++;
            }
            echo '</table>
                <div id="delfrombd">
                    <button class="foraddbut" type="submit" name="delfrombd">Удалить</button>
                </div>
                </form>';
            $_SESSION["count_for_del"] = $count;
        }
    }
    else
    {
        echo '<h2>Добро пожаловать на Ростовскую ферму!</h2>
    <p>Мы предлагаем свежие и качественные продукты прямо с наших полей и ферм. Узнайте больше о нашей продукции и деятельности.</p>
    <form action="index.php" method="post">';
        
            if(isset($_COOKIE[session_id()]))
            {
                
                $jsonarray = json_decode($_COOKIE[session_id()], true);
                
                echo '<div class="auth-reg">
            <div class="exitdiv"><input name="subexit" type="submit" style="background-color: #333; color: white; height: 80%;
    width: 200%;
    border-radius: 20px;
    cursor: pointer;
    border: none;
    margin: 2.5% 0%;" value="Выйти из аккаунта"/></div>
            </div>
            </form>
            <section class="save-section">
        <h2>Введите данные</h2>
        <form action="index.php" method="post">
            <label for="name">Имя</label>
            <input type="text" id="name" name="name" placeholder="Введите ваше имя" value="'.$jsonarray[3].'" required>

            <label for="phone">Номер</label>
            <input type="tel" id="phone" name="phone" placeholder="Введите ваш номер" value="'.$jsonarray[4].'" required>

            <label for="email">Почта</label>
            <input type="email" id="email" name="email" placeholder="Введите вашу почту" value="'.$jsonarray[5].'" required>

            <button name="saveinfo" type="submit">Сохранить</button>
        </form>
    </section>';
            }
            else if(isset($_POST["reg"]))
            {
                echo '<div class="auth-reg">
            <div class="authdiv"><input name="auth" type="submit" style="background-color: #333; color: white;" value="Авторизация"/></div>
            <div class="regdiv"><input name="reg" type="submit" style="background-color: #4CAF50" value="Регистрация"/></div>
            </div>
            </form>
    <section class="auth-section">
        <h2>Регистрация</h2>
        <form action="index.php" method="post">
            <label for="username">Имя пользователя</label>
            <input type="text" id="username" name="username" placeholder="Введите имя пользователя" required>

            <label for="password">Пароль</label>
            <input type="password" id="password" name="password" placeholder="Введите пароль" required>

            <button name="subreg" type="submit">Зарегистрироваться</button>
        </form>
    </section>';
            }
            else
            {
                echo '<div class="auth-reg">
            <div class="authdiv"><input name="auth" type="submit" style="background-color: #4CAF50" value="Авторизация"/></div>
            <div class="regdiv"><input name="reg" type="submit" style="background-color: #333; color: white;" value="Регистрация"/></div>
            </div>
            </form>
    <section class="auth-section">
        <h2>Авторизация</h2>
        <form action="index.php" method="post">
            <label for="username">Имя пользователя</label>
            <input type="text" id="username" name="username" placeholder="Введите имя пользователя" required>

            <label for="password">Пароль</label>
            <input type="password" id="password" name="password" placeholder="Введите пароль" required>

            <button name="subinput" type="submit">Войти</button>
        </form>
    </section>';
            }
    }
?>