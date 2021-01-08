
    <?php
    include 'dbh.inc.php';
    include 'getdata.php';

    $q = strval($_GET["q"]);
    $data = explode("/", $q);
    $sql = "SELECT * FROM " . "$data[1]" . " ORDER BY " . "$data[0]" . " " . "$data[2]";
    $result = mysqli_query($conn, $sql);


    generateTable($result);

    ?>