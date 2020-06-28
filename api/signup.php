<?php


require 'DB.php';
require 'Cors.config.php';



//$entityBody = file_get_contents('php://input');
//echo $entityBody;
//echo json_decode(file_get_contents('php://input'), true);

if ($_POST) {
    //echo "POST TRY";
    //echo "<script>console.log('POST TRY!!!!!!!!!!!!!!' );</script>";


    // header("location:index.html");
    //echo $username;
    //echo "<script>console.log('$username' );</script>";
    $usernameExist = verifyByUsername($database, $_POST['username']);
    $emailExist = verifyByEmail($database, $_POST['email']);
    if ($usernameExist == 1) {
        $response['status'] = 409;
        $response['message'] = "This username is already in use";
    } else if ($emailExist == 1) {
        $response['status'] = 409;
        $response['message'] = "This email is already in use";
    } else {
        // if ($_POST['password'] == $_POST['password_confirm']) {
        if (($_POST['username'] != null) && ($_POST['email'] != null) && ($_POST['password'] != null) && ($_POST['account_type'] != null)) {

            $username = $_POST['username'];
            $password = password_hash($_POST["password"], PASSWORD_DEFAULT);
            $email = $_POST['email'];
            $account_type = accountType($_POST['account_type']);
            //   var_dump($username, $password, $account_type, $email);
            createAccount($database, $username, $account_type, $email, $password);
            $response['status'] = 200;
            $response['message'] = "Account Created!";
        }
    }
    header("Content-type: application/json");
    echo json_encode($response);
}



$database = null;


function accountType($value)
{
    $type = null;
    switch ($value) {
        case 1:
            $type = "ADMIN";
            break;
        case 2:
            $type = "USER";
            break;
        default:
            $type = "USER";
            break;
    }
    return $type;
}

//CREATE ACCOUNT SP call
function createAccount($database, $username, $account_type, $email, $password)
{
    $sql = 'CALL CREATE_ACCOUNT (?,?,?,?)';
    $sth = $database->pdo->prepare($sql);

    $sth->bindParam(1, $username, PDO::PARAM_STR, 25);
    $sth->bindParam(2, $account_type, PDO::PARAM_STR, 25);
    $sth->bindParam(3, $password, PDO::PARAM_STR, 255);
    $sth->bindParam(4, $email, PDO::PARAM_STR, 25);

    $sth->execute();
}


function verifyByUsername($database, $username)
{
    $sql = 'CALL VERIFY_USER_EXISTS_USERNAME (?)';
    $sth = $database->pdo->prepare($sql);

    $sth->bindParam(1, $username, PDO::PARAM_STR, 25);
    $sth->execute();
    $exist = $sth->fetchAll(PDO::FETCH_ORI_FIRST);
    return $exist[0]["COUNT(*)"];
}

function verifyByEmail($database, $email)
{
    $sql = 'CALL VERIFY_USER_EXISTS_EMAIL (?)';
    $sth = $database->pdo->prepare($sql);

    $sth->bindParam(1, $email, PDO::PARAM_STR, 25);
    $sth->execute();
    $exist = $sth->fetchAll(PDO::FETCH_ORI_FIRST);
    return $exist[0]["COUNT(*)"];
}
