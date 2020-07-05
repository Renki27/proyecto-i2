<?php

require 'DB.php';
require 'Cors.config.php';






if ($_POST) {

    $id_game = $_POST['id_game'];


    if ($id_game != "") {
        deleteGame($database, $id_game);
        $response['status'] = 200;
        $response['message'] = "Game deleted!";
    } else {
        $response['status'] = 409;
        $response['message'] = "Oops!, can't delete the game!";
    }

    header("Content-type: application/json");
    echo json_encode($response);
}

$database = null;





//  SP call Delete game
function deleteGame($database, $id_game)

{
    $sql = 'CALL DELETE_GAME (?)';
    $sth = $database->pdo->prepare($sql);

    $sth->bindParam(1, $id_game, PDO::PARAM_INT, 5);
    $sth->execute();
}
