<?php 

function generateTable($result) {

    $i = 0;
    while ($row = $result->fetch_assoc()) {
        if ($i == 0) {
            $i++;
            echo "<tr>";
            $col="";
            foreach ($row as $key => $value) {
                $col = $col . "," . $key;
                echo "<th style='background-color:#dc3545' scope='col'><button class='btn btn-danger' style='width:100%' value = " . $key . " onclick='orderBy(this.value)'>" . $key . "</button></th>";
            }
            echo "<th style='background-color:#dc3545' scope='col'>Actions</th>";
            echo "</tr>";
        }
        echo "<tr>";
        $p = 0;
        foreach ($row as $value) {
            if ($p == 0) {
                $p++;
                $pk = $value;
                $pk = preg_replace('/\s+/', '.', $pk); 
            }
            echo "<td scope='row'>" . $value . "</td>";
        }
        echo "<td>";
        echo "<a class='add' data-col=" . $col . " data-value=" . $pk . " title='Add' data-toggle='tooltip'><i class='material-icons'>&#xE03B;</i></a>";
        echo "<a class='edit' data-col=" . $col . " data-value=" . $pk . " title='Edit' data-toggle='tooltip'><i class='material-icons'>&#xE254;</i></a>";
        echo "<a class='delete' data-col=" . $col . " data-value=" . $pk . " title='Delete' data-toggle='tooltip'><i class='material-icons'>&#xE872;</i></a>";
        echo "</td>";
        echo "</tr>";
    }

    echo "</tbody>";


}
