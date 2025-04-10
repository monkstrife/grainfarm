<?php 
        session_start();

        // $users = array("admin"=>array("admin", "123", "0", "Валерий", "89286123636", "drobilko2002@mail.ru"), "employeer"=>array("employeer", "777", "1", "Алексей", "", ""));
        // file_put_contents("users.dat", serialize($users));

        $users = unserialize(file_get_contents("users.dat"));
        setcookie("count_table", 1, time() + 3600);
        if(isset($_POST["subinput"]))
        {
            if(array_key_exists($_POST["username"], $users) && $_POST["password"] == $users[$_POST["username"]][1])
            {
                if(!array_key_exists(session_id(), $_COOKIE))
                {
                    setcookie(session_id(), json_encode($users[$_POST["username"]]), time() + 3600); // , "/", "valerauk.beget.tech"
                    header("Refresh:0");
                } 
            }
        }
        else
        if(isset($_POST["subreg"]))
        {
            if(!array_key_exists($_POST["username"], $users))
            {
                $users[$_POST["username"]] = array($_POST["username"], $_POST["password"], 2, "", "", "");
                
                file_put_contents("users.dat", serialize($users));
                if(array_key_exists($_POST["username"], $users) && $_POST["password"] == $users[$_POST["username"]][1])
                {
                    if(!array_key_exists(session_id(), $_COOKIE))
                    {
                        setcookie(session_id(), json_encode($users[$_POST["username"]]), time() + 3600); // , "/", "valerauk.beget.tech"
                        header("Refresh:0");
                    } 
                }
            }
        }
        else
        if(isset($_POST["subexit"]))
        {
            setcookie(session_id(), "1", time() - 7, "/", "valerauk.beget.tech");
            header('Location: '.$_SERVER['REQUEST_URI']);
        }
        else 
        if(isset($_POST["saveinfo"]))
        {
            
            $jsonarray = json_decode($_COOKIE[session_id()], true);
            $jsonarray[3] = $_POST["name"];
            $jsonarray[4] = $_POST["phone"];
            $jsonarray[5] = $_POST["email"];

            $users[$jsonarray[0]] = array($jsonarray[0], $jsonarray[1], $jsonarray[2], $jsonarray[3], $jsonarray[4], $jsonarray[5]);
            file_put_contents("users.dat", serialize($users));

            setcookie(session_id(), json_encode($jsonarray), time() + 3600); // , "/", "valerauk.beget.tech"
            header("Refresh:0");
        }
    ?>