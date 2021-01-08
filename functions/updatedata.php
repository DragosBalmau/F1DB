
    <?php
    include 'dbh.inc.php';
    include 'getdata.php';

    $q = strval($_GET["q"]);
    $data = explode("/", $q);

    $pk = str_replace(".", " ", $data[0]);
    $pk = '"' . $pk . '"';

    $tableName = $data[2];

    $columns = explode(",", $data[1]);

    $input = explode(",", $data[3]);

    $colval = "";
    for ($i = 1; $i < count($columns); $i++) {
        $colval = $colval . $columns[$i] . "=" . '"' . $input[$i] . '"' . ",";
    };
    $colval = $colval . " ";
    $colval = rtrim($colval, ", ");
    $sql = "UPDATE " . "$tableName" . " SET " . $colval . " WHERE " . $columns[1] . "=" . $pk;
    mysqli_query($conn, $sql);
    $sql = "SELECT * FROM " . $tableName;
    $result = mysqli_query($conn, $sql);

    generateTable($result);

    ?>
