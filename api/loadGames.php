<?php


require 'DB.php';
require 'Cors.config.php';

if ($_GET["request"] == "loadGames") {




    $gamesPayload = loadGames($database);

    if ($gamesPayload) {
        $length = count($gamesPayload);
        $library = [];
        for ($i = 0; $i < $length; $i++) {
            $gameData =
                array(
                    "username" => $gamesPayload[$i]["USERNAME"],
                    "id_game" => $gamesPayload[$i]["ID_GAME"],
                    "title" => $gamesPayload[$i]["TITLE"],
                    "genre" => $gamesPayload[$i]["GENRE"],
                    "publisher" => $gamesPayload[$i]["PUBLISHER"],
                    "developer" => $gamesPayload[$i]["DEVELOPER"],
                    "platform" => $gamesPayload[$i]["PLATFORM"],
                    "released_on" => $gamesPayload[$i]["RELEASED_ON"],
                    "multiplayer" => $gamesPayload[$i]["MULTIPLAYER"],
                    "description" => $gamesPayload[$i]["DESCRIPTION"],
                    "image" => $gamesPayload[$i]["IMAGE"],
                    "video_link" => $gamesPayload[$i]["VIDEO_LINK"],
                );
                array_push($library, $gameData); 
        }


        $response['status'] = 200;
        $response['message'] = "Library loaded!";
        $response['gamesLibrary'] = $library;
    } else {
        $response['status'] = 404;
        $response['message'] = "Library not found!"; 
    }







    header("Content-type: application/json");
    echo json_encode($response);
}



function loadGames($database)
{
    $sql = 'CALL `SELECT_ALL_GAMES`()';
    $sth = $database->pdo->prepare($sql);
    $sth->execute();
    return $sth->fetchAll(PDO::FETCH_SERIALIZE);
}
