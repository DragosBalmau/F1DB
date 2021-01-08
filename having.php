<?php
include 'functions/dbh.inc.php';
$sql = "SELECT furnizor_id, count(echipe_id) as numar FROM echipe GROUP BY furnizor_id HAVING count(echipe_id) > 1";
$result = mysqli_query($conn, $sql);
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="dataview.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round|Open+Sans">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        body {
            color: #404E67;
            background: #f50000;;
            font-family: 'Open Sans', sans-serif;
        }

        .table-wrapper {
            width: auto;
            margin: 30px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
        }

        .table-title {
            padding-bottom: 10px;
            margin: 0 0 10px;
        }

        .table-title h2 {
            margin: 6px 0 0;
            font-size: 22px;
        }

        .table-title .add-new {
            float: right;
            height: 30px;
            font-weight: bold;
            font-size: 12px;
            text-shadow: none;
            min-width: 100px;
            border-radius: 50px;
            line-height: 13px;
        }

        .table-title .add-new i {
            margin-right: 4px;
        }

        table.table {
            table-layout: fixed;
        }

        table.table tr th,
        table.table tr td {
            border-color: #e9e9e9;
        }

        table.table th i {
            font-size: 13px;
            margin: 0 5px;
            cursor: pointer;
        }

        table.table th:last-child {
            width: 100px;
        }

        table.table td a {
            cursor: pointer;
            display: inline-block;
            margin: 0 5px;
            min-width: 24px;
        }

        table.table td a.add {
            color: #27C46B;
        }

        table.table td a.edit {
            color: #FFC107;
        }

        table.table td a.delete {
            color: #E34724;
        }

        table.table td i {
            font-size: 19px;
        }

        table.table td a.add i {
            font-size: 24px;
            margin-right: -1px;
            position: relative;
            top: 3px;
        }

        table.table .form-control {
            height: 32px;
            line-height: 32px;
            box-shadow: none;
            border-radius: 2px;
        }

        table.table .form-control.error {
            border-color: #f50000;
        }

        table.table td .add {
            display: none;
        }

        .table-title {
            text-align: center;
            font-size: 48px;
        }
    </style>
    <nav class="navbar navbar-light bg-light navbar-expand-lg">
        <a class="navbar-brand" href="index.html">
            <img src="https://logodownload.org/wp-content/uploads/2016/11/formula-1-logo-1-1.png" height="30" alt="" loading="lazy" /></a>
        <div class="navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="dataview.php">Dataview</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="select3cereri2cond.php">Piloti</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="having.php">Furnizori</a>
                </li>
            </ul>
        </div>
    </nav>
</head>

<body style="background-image: url('resources/6.jpg');">
    <div class="container-lg">
        <div class="table-responsive">
            <div class="table-wrapper">
                <table class="table table-bordered" id="txtHint">
                <div class="table-title">Furnizorii care pun la dispoziție motoare pentru mai mult de o echipă</div>
                    <tbody>
                        <?php
                        $i = 0;
                        while ($row = $result->fetch_assoc()) {
                            if ($i == 0) {
                                $i++;
                                echo "<tr>";
                                foreach ($row as $key => $value) {
                                    echo "<th style='background-color:#dc3545' scope='col'>" . $key . "</th>";
                                }
                                echo "</tr>";
                            }
                            echo "<tr>";

                            foreach ($row as $value) {
                                echo "<td>" . $value . "</td>";
                            }
                            echo "</tr>";
                        }
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

</html>