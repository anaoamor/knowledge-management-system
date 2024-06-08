<%-- 
    Document   : ForgotPassword
    Created on : Jun 24, 2019, 1:52:46 PM
    Author     : ASUS
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="w3.css">
        <style type="text/css">
            .pembungkus{
                position: relative;
            }
            h2{
                margin-bottom: 20px;
            }
            .layer-transparent{
                opacity: 0.9;
                filter: alpha(opacity=90);/* For IE8 and earlier*/
                position: fixed;
                left: 300px;
                right: 300px;
                top: 150px;
                
            }
            
            label{
                margin-left: 176px;
            }
            
            /* From w3shcools*/
            input[type=text], 
            input[type=password]{
              width: 50%;
              padding: 12px 20px;
              margin: 8px 0;
              margin-left: 176px;
              margin-right: 176px;
              display: inline-block;
              border: 1px solid #ccc;
              border-radius: 4px;
              box-sizing: border-box;
            }

            input[type=submit] {
              width: 30%;
              background-color: #4CAF50;
              color: white;
              padding: 14px 20px;
              margin: 8px 0;
              margin-left: 250px;
              margin-right: 250px;
              border: none;
              border-radius: 4px;
              cursor: pointer;
            }

            input[type=submit]:hover {
              background-color: #45a049;
            }
            
        /**----------- style untuk select options user----------------------- -->*/
       
            /*the container must be positioned relative:*/
            .custom-select {
                position: relative;
                font-family: Arial;
            }
            
            .custom-select select {
                display: none; /*hide original SELECT element:*/
            }

            .select-selected {
                background-color: DodgerBlue;
            }

            /*style the arrow inside the select element:*/
            .select-selected:after {
                position: absolute;
                content: "";
                top: 14px;
                margin-right: 150px;
                right: 50px;
                width: 0;
                height: 0;
                border: 6px solid transparent;
                border-color: #000 transparent transparent transparent;
            }

            /*point the arrow upwards when the select box is open (active):*/
            .select-selected.select-arrow-active:after {
                border-color: transparent transparent #000 transparent;
                top: 7px;
            }

            /*style the items (options), including the selected item:*/
            .select-items div,.select-selected {
                color: #000;
                padding: 8px 16px;
                width: 50%;
                margin-left: 176px;
                margin-right: 176x;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                
                cursor: pointer;
                user-select: none;
                background: rgba(255,255,255,.1);
                height: 45px;
            }

            /*style items (options):*/
            .select-items {
                position: absolute;
                background-color: #ffffff;/*your modified*/
                top: 100%;
                left: 0;
                right: 0;
                z-index: 99;
            }

            /*hide the items when the select box is closed:*/
            .select-hide {
                display: none;
            }

            .select-items div:hover, .same-as-selected {
                background-color: rgba(0, 0, 0, 0.1);
            }
            
        </style>
        
        <title>KMS Mahasiswa SI</title>
    </head>
    
    <body>
        <!-- Script Untuk validasi input-->
        <script type="text/javascript">
            function validation(form){
                if (form.user.value == ""){
                    alert("Tipe user masih kosong!");
                    form.user.focus();
                    return (false);
                } else if(form.username.value == ""){
                    alert("Username masih kosong!");
                    form.username.focus();
                    return (false);
                } else if(form.email.value == ""){
                    alert("E-Mail masih kosong!");
                    form.email.focus();
                    return (false);
                }
                return true;
            }
            
        </script>
       
        <div class="w3-row w3-white" >
            
            <div class="w3-container w3-white w3-threequarter">
                <h1>KMS Mahasiswa SI</h1>
            </div>
           
        </div>

        <div class="pembungkus">
            <img src="book.jpg" alt="BOOK" style="width:device-width; height: 934px">
            <div class="w3-container w3-white w3-round-large layer-transparent">
                <h2 class="w3-center">FORGOT PASSWORD?</h2>
                
                <form action="ForgotPassword" method="post" onsubmit="return validation(this)">
                    <!-- TEXTFIELD TIPE USER -->
                    <div class="group">
                        <label for="user-type" class="label" >User</label>
                        <div class="custom-select" >
                            <select name="user">
                                <option>Pilih</option>
                                <option value="0">Mahasiswa</option>
                                <option value="2">Kepala Prodi</option>
                                <option value="1">Wadek III</option>
                                <option value="3">Admin</option>
                            </select>
                        </div>
                             
                    </div>
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Username">

                    <label for="email">E-Mail</label>
                    <input type="text" id="email" name="email" placeholder="E-Mail">
                    
                    <input type="submit" name="submit" value="Submit">
                </form>
                
            </div>
        </div>
        
        <div class="w3-container w3-white w3-center w3-bottom">
            <footer >
                <h6>© 2019 AMO. All rights reserved</h6>
            </footer>
        </div>
        
        <script>
            var x, i, j, selElmnt, a, b, c;
            /*look for any elements with the class "custom-select":*/
            x = document.getElementsByClassName("custom-select");
            for (i = 0; i < x.length; i++) {
              selElmnt = x[i].getElementsByTagName("select")[0];
              /*for each element, create a new DIV that will act as the selected item:*/
              a = document.createElement("DIV");
              a.setAttribute("class", "select-selected");
              a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
              x[i].appendChild(a);
              /*for each element, create a new DIV that will contain the option list:*/
              b = document.createElement("DIV");
              b.setAttribute("class", "select-items select-hide");
              for (j = 1; j < selElmnt.length; j++) {
                /*for each option in the original select element,
                create a new DIV that will act as an option item:*/
                c = document.createElement("DIV");
                c.innerHTML = selElmnt.options[j].innerHTML;
                c.addEventListener("click", function(e) {
                    /*when an item is clicked, update the original select box,
                    and the selected item:*/
                    var y, i, k, s, h;
                    s = this.parentNode.parentNode.getElementsByTagName("select")[0];
                    h = this.parentNode.previousSibling;
                    for (i = 0; i < s.length; i++) {
                      if (s.options[i].innerHTML == this.innerHTML) {
                        s.selectedIndex = i;
                        h.innerHTML = this.innerHTML;
                        y = this.parentNode.getElementsByClassName("same-as-selected");
                        for (k = 0; k < y.length; k++) {
                          y[k].removeAttribute("class");
                        }
                        this.setAttribute("class", "same-as-selected");
                        break;
                      }
                    }
                    h.click();
                });
                b.appendChild(c);
              }
              x[i].appendChild(b);
              a.addEventListener("click", function(e) {
                  /*when the select box is clicked, close any other select boxes,
                  and open/close the current select box:*/
                  e.stopPropagation();
                  closeAllSelect(this);
                  this.nextSibling.classList.toggle("select-hide");
                  this.classList.toggle("select-arrow-active");
                });
            }
            function closeAllSelect(elmnt) {
              /*a function that will close all select boxes in the document,
              except the current select box:*/
              var x, y, i, arrNo = [];
              x = document.getElementsByClassName("select-items");
              y = document.getElementsByClassName("select-selected");
              for (i = 0; i < y.length; i++) {
                if (elmnt == y[i]) {
                  arrNo.push(i)
                } else {
                  y[i].classList.remove("select-arrow-active");
                }
              }
              for (i = 0; i < x.length; i++) {
                if (arrNo.indexOf(i)) {
                  x[i].classList.add("select-hide");
                }
              }
            }
            /*if the user clicks anywhere outside the select box,
            then close all select boxes:*/
            document.addEventListener("click", closeAllSelect);
        </script>
        
    </body>
</html>
