<?php

use PhpParser\Node\Stmt\TryCatch;

require 'DB.php';
require 'Cors.config.php';




if ($_POST) {

    $id_game = $_POST['id_game'];
    $username = $_POST['username'];
    $title = $_POST['title'];
    $genre = $_POST['genre'];
    $publisher = $_POST['publisher'];
    $developer = $_POST['developer'];
    $platform = $_POST['platform'];
    $released_on = $_POST['released_on'];
    $multiplayer = multiplayerType($_POST['multiplayer']);
    $description = $_POST['description'];
    $video_link = $_POST['video_link'];
    $uploadfile;
    $file;


    //error_reporting(error_reporting() & ~E_NOTICE);
    $target_path = "../uploads/";


    if (isset($_FILES['image']['name'])) {
        $path = pathinfo($_FILES['image']['name']);
        $uploadfile = $target_path .   $path['filename'] . "_" .  date('YmdHis') . "." . $path['extension'];
        $file = $_FILES['image']['name'];
    } else {
        $uploadfile = "none";
        //$uploadfile = $target_path . basename($_FILES['image']['name']) ?? 'none';
    }





    /*        //cerifica si el archivo existe
    if (file_exists($file)) {
        $response['status'] = 409;
        $response['message'] = "The image file already exists!";
    } else { */
    //Si el archivo contiene algo y es diferente de vacio


    if (isset($file) && $file != "") {

        //Obtenemos algunos datos necesarios sobre el archivo
        $type = $_FILES['image']['type'];
        $size = $_FILES['image']['size'];
        $temp = $_FILES['image']['tmp_name'];

        //Se comprueba si el archivo a cargar es correcto observando su extensión y tamaño
        if (!((strpos($type, "jpeg") || strpos($type, "jpg") || strpos($type, "png")))) {
            $response['status'] = 409;
            $response['message'] = "Only .jpeg, .jpg and .png are allowed!";
        } else {
            // You should also check filesize here.
            if ($_FILES['image']['size'] > 5000000) {
                $response['status'] = 409;
                $response['message'] = "Filesize limit is exceeded, the max size is 5Mb !";
            } else {
                if (move_uploaded_file($_FILES['image']['tmp_name'], $uploadfile)) {
                    //   echo $_FILES['image']['tmp_name'];
                   // echo $uploadfile;
                    updateGame($database, $id_game, $username, $title, $genre, $publisher, $developer, $platform, $released_on, $multiplayer, $description, $uploadfile, $video_link);

                    $response['status'] = 200;
                    $response['message'] = "Game updated!";
                } else {
                    $response['status'] = 409;
                    $response['message'] = "Oops!, image not uploaded!";
                }
            }
        }
    } else {
        if ($uploadfile == "none") {
            updateGame_NoImage($database, $id_game, $username, $title, $genre, $publisher, $developer, $platform, $released_on, $multiplayer, $description, $video_link);

            $response['status'] = 200;
            $response['message'] = "Game updated!";
        } else {
            $response['status'] = 409;
            $response['message'] = "Oops!, image file is empty!";
        }
    }




    header("Content-type: application/json");
    echo json_encode($response);
}



$database = null;




//  SP call Update game
function updateGame($database, $id_game, $username, $title, $genre, $publisher, $developer, $platform, $released_on, $multiplayer, $description, $image, $video_link)

{
    $sql = 'CALL UPDATE_GAME (?,?,?,?,?,?,?,?,?,?,?,?)';
    $sth = $database->pdo->prepare($sql);

    $sth->bindParam(1, $id_game, PDO::PARAM_INT, 5);
    $sth->bindParam(2, $username, PDO::PARAM_STR, 25);
    $sth->bindParam(3, $title, PDO::PARAM_STR, 50);
    $sth->bindParam(4, $genre, PDO::PARAM_STR, 50);
    $sth->bindParam(5, $publisher, PDO::PARAM_STR, 50);
    $sth->bindParam(6, $developer, PDO::PARAM_STR, 50);
    $sth->bindParam(7, $platform, PDO::PARAM_STR, 50);
    $sth->bindParam(8, $released_on, PDO::PARAM_INT, 4);
    $sth->bindParam(9, $multiplayer, PDO::PARAM_STR, 25);
    $sth->bindParam(10, $description, PDO::PARAM_STR, 1000);
    $sth->bindParam(11, $image, PDO::PARAM_STR, 100);
    $sth->bindParam(12, $video_link, PDO::PARAM_STR, 50);
    $sth->execute();
}

//  SP call Update game
function updateGame_NoImage($database, $id_game, $username, $title, $genre, $publisher, $developer, $platform, $released_on, $multiplayer, $description, $video_link)

{
    $sql = 'CALL UPDATE_GAME_NO_IMAGE (?,?,?,?,?,?,?,?,?,?,?)';
    $sth = $database->pdo->prepare($sql);

    $sth->bindParam(1, $id_game, PDO::PARAM_INT, 5);
    $sth->bindParam(2, $username, PDO::PARAM_STR, 25);
    $sth->bindParam(3, $title, PDO::PARAM_STR, 50);
    $sth->bindParam(4, $genre, PDO::PARAM_STR, 50);
    $sth->bindParam(5, $publisher, PDO::PARAM_STR, 50);
    $sth->bindParam(6, $developer, PDO::PARAM_STR, 50);
    $sth->bindParam(7, $platform, PDO::PARAM_STR, 50);
    $sth->bindParam(8, $released_on, PDO::PARAM_INT, 4);
    $sth->bindParam(9, $multiplayer, PDO::PARAM_STR, 25);
    $sth->bindParam(10, $description, PDO::PARAM_STR, 1000);
    $sth->bindParam(11, $video_link, PDO::PARAM_STR, 50);
    $sth->execute();
}

function multiplayerType($value)
{
    $type = null;
    switch ($value) {
        case 1:
            $type = "YES";
            break;
        case 2:
            $type = "NO";
            break;
        default:
            $type = "NO";
            break;
    }
    return $type;
}
