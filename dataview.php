<!DOCTYPE html>

<head>
    <meta charset="utf-8">
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
            background: #f50000;
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
            table-layout: auto;
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
    </style>
    <script type="text/javascript" src="jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('[data-toggle="tooltip"]').tooltip();
            var actions = $("table td:last-child").html();
            $(document).on("click", ".add", function() {
                var empty = false;
                var textInput;
                var input = $(this).parents("tr").find('input[type="text"]');
                input.each(function() {
                    if (!$(this).val()) {
                        $(this).addClass("error");
                        empty = true;
                    } else {
                        $(this).removeClass("error");
                    }
                    textInput = [textInput, $(this).val()].join(",");
                });
                $(this).parents("tr").find(".error").first().focus();
                if (!empty) {
                    input.each(function() {
                        $(this).parent("td").html($(this).val());
                    });
                    $(this).parents("tr").find(".add, .edit").toggle();
                    $(".add-new").removeAttr("disabled");
                }
    
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("txtHint").innerHTML = this.responseText;
                    }
                };
                var val = $(this).data("value");
                var col = $(this).data("col");
                
                xmlhttp.open("GET", "functions/updatedata.php?q=" + val + "/" + col + "/" + document.getElementById("tables").value + "/" + textInput, true);
                xmlhttp.send();

            });
            // Edit row on edit button click
            $(document).on("click", ".edit", function() {
                $(this).parents("tr").find("td:not(:last-child)").each(function() {
                    $(this).html('<input type="text" class="form-control" value="' + $(this).text() + '">');
                });
                $(this).parents("tr").find(".add, .edit").toggle();
                $(".add-new").attr("disabled", "disabled");
            });
            // Delete row on delete button click
            $(document).on("click", ".delete", function() {
                $(this).parents("tr").remove();

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("txtHint").innerHTML = this.responseText;
                    }
                };
                var pk = $(this).data("value");
                var col = $(this).data("col");
                xmlhttp.open("GET", "functions/deletedata.php?q=" + pk + "/" + col + "/" + document.getElementById("tables").value, true);
                xmlhttp.send();

                $(".add-new").removeAttr("disabled");
            });
        });
    </script>
    <script type="text/javascript">
        function showTables(str) {
            if (str == "") {
                document.getElementById("txtHint").innerHTML = "";
                return;
            } else {
                var xmlhttp = new XMLHttpRequest();

                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("txtHint").innerHTML = this.responseText;
                    }
                };
                xmlhttp.open("GET", "functions/selectdata.php?q=" + str, true);
                xmlhttp.send();
            }
        }
    </script>
    <script type="text/javascript">
        var order = "DESC";
        function orderBy(str) {
            if (str == "") {
                document.getElementById("txtHint").innerHTML = "";
                return;
            } else {
                var xmlhttp = new XMLHttpRequest();

                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("txtHint").innerHTML = this.responseText;
                    }
                };
                if(order === "DESC")    
                    order = "ASC";
                else
                    order = "DESC";
                xmlhttp.open("GET", "functions/orderdata.php?q=" + str + "/" + document.getElementById("tables").value + "/" + order, true);
                xmlhttp.send();
            }
        }
    </script>
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

<body style="background-image: url('resources/6.jpg');" onload="showTables('echipe')">
    <div class="container-lg">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-8">
                            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" id="tables" onchange="showTables(this.value)">
                                <option value="echipe">Echipe</option>
                                <option value="echipe_participante">Echipe participante</option>
                                <option value="piloti">Piloti</option>
                                <option value="angajati_echipe">Angajati</option>
                                <option value="grands_prix">Grands Prix</option>
                                <option value="circuite">Circuite</option>
                                <option value="furnizori_motoare">Furnizori motoare</option>
                                <option value="sponsori">Sponsori</option>
                            </select>
                        </div>
                    </div>
                </div>
                <table class="table table-bordered" style="width:100%" id="txtHint">
                </table>
            </div>
        </div>
    </div>
</body>

</html>