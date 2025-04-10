<?php 
    if(isset($_COOKIE[session_id()]))
    {
        if(json_decode($_COOKIE[session_id()], true)[2] == 0)
        {
            echo '<li><div><input name="main" type="submit" value="Главная"/></div></li>
            <li><div><input name="aboutus" type="submit" value="О нас"/></div></li>
            <li><div><input name="products" type="submit" value="Продукция"/></div></li>
            <li><div><input name="work" type="submit" value="Работа с базой"/></div></li>
            <li><div><input name="contacts" type="submit" value="Контакты"/></div></li>';
        }
        else if (json_decode($_COOKIE[session_id()], true)[2] == 1)
        {
            echo '<li><div><input name="main" type="submit" value="Главная"/></div></li>
            <li><div><input name="aboutus" type="submit" value="О нас"/></div></li>
            <li><div><input name="products" type="submit" value="Продукция"/></div></li>
            <li><div><input name="info" type="submit" value="Информация о базе"/></div></li>
            <li><div><input name="contacts" type="submit" value="Контакты"/></div></li>';
        }
        else
        {
            echo '<li><div><input name="main" type="submit" value="Главная"/></div></li>
            <li><div><input name="aboutus" type="submit" value="О нас"/></div></li>
            <li><div><input name="products" type="submit" value="Продукция"/></div></li>
            <li><div><input name="basket" type="submit" value="Корзина"/></div></li>
            <li><div><input name="contacts" type="submit" value="Контакты"/></div></li>';
        }
    }
    else
    {
        echo '<li><div><input name="main" type="submit" value="Главная"/></div></li>
        <li><div><input name="aboutus" type="submit" value="О нас"/></div></li>
        <li><div><input name="products" type="submit" value="Продукция"/></div></li>
        <li><div><input name="contacts" type="submit" value="Контакты"/></div></li>';
    }
?>