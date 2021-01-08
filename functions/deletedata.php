
    <?php
    include 'dbh.inc.php';
    include 'getdata.php';

    $q = strval($_GET["q"]);
    $data = explode("/", $q);
    $data[0] = str_replace(".", " ", $data[0]);
    $data[0] = "'". $data[0] ."'";
    $columns = explode(",", $data[1]);
    $sql = "DELETE FROM " . "$data[2]" . " WHERE " . "$columns[1] = " . "$data[0]";
    mysqli_query($conn, $sql);
    $sql = "SELECT * FROM " . "$data[2]";
    $result = mysqli_query($conn, $sql);

    generateTable($result);

    ?>
