
    <?php

    include 'dbh.inc.php';
    include 'getdata.php';

    $q = strval($_GET["q"]);
    $sql = "SELECT * FROM " . "$q";
    $result = mysqli_query($conn, $sql);

    generateTable($result);


    ?>
