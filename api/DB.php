<?php

require 'Medoo.php';
use Medoo\Medoo;

$database = new Medoo([
    'database_type' => 'mysql',
    'database_name' => 'games_db',
    'server' => 'localhost',
    'username' => 'root',
    'password' => ''
]);

?>