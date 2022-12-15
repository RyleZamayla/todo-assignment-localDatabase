<?php
use LDAP\Result;

  $servername = "localhost";
  $username = "root";
  $password = '';
  $dbname = "todo_assignment-localDatabase";
  $table = "Todos";

  $action = $_POST["action"];

  $conn = new mysqli($servername, $username, $password, $dbname, $table);
  if($conn -> connect_error){
    die("Connection Failed".$conn->connect_error);
    return;
  }

  if("CREATE_TABLE" == $action){
    $sql = "CREATE TABLE IF NOT EXISTS $table (
      id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      titleTodos VARCHAR(30) NOT NULL,
      descTodos VARCHAR(75) NOT NULL
    )";
      if($conn->query($sql ===  TRUE)){
        echo "process was a success...";
      }else{
        echo "process failed...";
      }
      $conn->close();
      return;
  }

  if("GET_ALL" == $action){
    $db_data = array();
    $sql = "SELECT id, titleTodos, descTodos from $table ORDER BY id DESC";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
      while($row = $result->fetch_assoc()){
        $db_data[] = $row;
      }
      echo json_encode($db_data);
    }else{
      echo "fetching data was a success...";
    }
    $conn->close();
    return;
  }

  if("ADD_TODO" == $action){
    $titleTodos = $_POST["titleTodos"];
    $descTodos = $_POST["descTodos"];
    $sql = "INSERT INTO $table (titleTodos, descTodos) VALUES ('$titleTodos', '$descTodos')";
    $result = $conn->query($sql);
    echo "adding data was a success...";
    $conn->close();
    return;
  }

  if("UPDATE_TODO" == $action){
    $todoId = $_POST['$todoId'];
    $titleTodos = $_POST['titleTodos'];
    $descTodos = $_POST['descTodos'];
    $sql = "UPDATE $table SET titleTodos = '$titleTodos', descTodos = '$descTodos' WHERE id = '$todoId'";
    if($conn->query($sql) === TRUE){
      echo "updating data was a success...";
    }else{
      echo "update failed...";
    }
  }

  if("DELETE_TODO" == $action){
    $todoId = $_POST['$todoId'];
    $sql = "DELETE FROM $table WHERE id = $todoId";
    if($conn->query($sql) === TRUE){
      echo "deleting was a succhess...";
    }else{
      echo "delete failed";
    }
    $conn->close();
    return;
  }
?>