<%-- 
    Document   : LoginRegistrasi
    Created on : Jun 24, 2019, 7:51:53 AM
    Author     : ASUS
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kmsclass.Koneksi" %>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>KMS Mahasiswa SI</title>
        <link rel="stylesheet" type="text/css" href="codepen.css">
        
<!----------- style untuk select options perguruan tinggi----------------------- -->
        <style>
            
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
                right: 10px;
                width: 0;
                height: 0;
                border: 6px solid transparent;
                border-color: #fff transparent transparent transparent;
            }

            /*point the arrow upwards when the select box is open (active):*/
            .select-selected.select-arrow-active:after {
                border-color: transparent transparent #fff transparent;
                top: 7px;
            }

            /*style the items (options), including the selected item:*/
            .select-items div,.select-selected {
                color: #ffffff;
                padding: 8px 16px;
                border: 1px solid transparent;
                border-color: transparent transparent rgba(0, 0, 0, 0.1) transparent;
                cursor: pointer;
                user-select: none;
                background: rgba(255,255,255,.1);
                height: 45px;
            }

            /*style items (options):*/
            .select-items {
                position: absolute;
                background-color: #1161ee;/*your modified*/
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
        
    </head>
    <body>
        
<!---------- jika button log in index.html diklik, tambahkan nilai checked-->
        <%! String menuOption;%>
        <% menuOption = request.getParameter("menu"); %>
        
        <div class="login-wrap"><!-- background dasar-->
            <div class="login-html"> <!-- background transparan -->
                <!-- jika button log in index.html diklik, tambahkan nilai checked-->
                <input id="tab-1" type="radio" name="tab" class="sign-in" <% if (menuOption.equals("LOG IN")) {out.print("checked");} %> ><label for="tab-1" class="tab">Log In</label>
		
                <!-- jika button daftar index.html diklik, tambahkan nilai checked-->
                <input id="tab-2" type="radio" name="tab" class="sign-up" <% if (menuOption.equals("DAFTAR")) {out.print("checked");} %> ><label for="tab-2" class="tab">Registrasi</label>
		<div class="login-form">
                    <div class="sign-in-htm">
                        
                        <!-- javascript untuk memeriksa textfield form-->
                            <script type="text/javascript" src="jquery.js"></script>
                            <script type="text/javascript">
                                
                                function validasi_input(form){
                                    if (form.username.value == ""){
                                        alert("Username masih kosong!");
                                        form.username.focus();
                                        return (false);
                                    } else if(form.password.value == ""){
                                        alert("Password masih kosong!");
                                        form.password.focus();
                                        return (false);
                                    }
                                    return true;
                                }
                                
                                $(document).ready(function(){
                                    $('div.custom-select select').val("1");
                                    $('#user').val("admin12");
                                    $('#pass').val("test1234");
                                });
                            </script>
                        
<!----------------------------------- form log in ------------------------------------------------------>
                        <form action="Login" method="post" onsubmit="return validasi_input(this)">
                            
                            <!-- TEXTFIELD TIPE USER -->
                             <div class="group">
                                <label for="user-type" class="label" >User</label>
                                <div class="custom-select" style="width:383px;">
                                    <select name="user">
                                        <option>Pilih</option>
                                        <option value="0">Mahasiswa</option>
                                        <option value="2">Kepala Prodi</option>
                                        <option value="1">Wadek III</option>
                                        <option value="3">Admin</option>
                                    </select>
                                </div>
                                
                            </div>
                            
                            <!-- textfield username-->
                            <div class="group">
                                <label for="user" class="label">Username</label>
                                <input id="user" type="text" class="input" name="username">
                            </div>

                            <!-- textfield password-->
                            <div class="group">
                                <label for="pass" class="label">Password</label>
                                <input id="pass" type="password" class="input" data-type="password" name="password">
                            </div>

                            <div class="hr"></div>
                            
                            <!-- button login-->
                            <div class="group">
                                <input type="submit" class="button" value="Log In">
                            </div>

                            <div class="hr"></div>
                            
                            <div class="foot-lnk">
                                <a href="ForgotPassword.jsp">Forgot Password?</a>
                            </div>
                        </form>
                    </div>
		
<!----------------------------------- Form Registrasi ------------------------------------------------------>
                    
                    <!-- javascript untuk memeriksa terisi atau tidak textfield form-->
                    <script type="text/javascript">
                        function validasi_input_registrasi(form){
                            var jumlahUsername = 0;
                            var jumlahHurufUsername = 0;
                            var jumlahAngkaUsername = 0;
                            
                            var nilaiUsername = document.getElementById("username").value; 
                            for (var i = 0; i< nilaiUsername.length; i++){
                                if(isNaN(nilaiUsername.charAt(i))) {
                                    jumlahHurufUsername++;
                                    jumlahUsername++;
                                } else {
                                    jumlahAngkaUsername++;
                                    jumlahUsername++;
                                } 
                            }
                            
                            var jumlahPassword = 0;
                            var jumlahHurufPassword = 0;
                            var jumlahAngkaPassword = 0;
                            
                            var nilaiPassword = document.getElementById("password").value; 
                            for (var i = 0; i< nilaiPassword.length; i++){
                                if(isNaN(nilaiPassword.charAt(i))) {
                                    jumlahHurufPassword++;
                                    jumlahPassword++;
                                } else {
                                    jumlahAngkaPassword++;
                                    jumlahPassword++;
                                } 
                            }
                            
                            var nilaiTglLahir = document.getElementById("tgl_lahir").value;
                            var jumlahAngkaTglLahir = 0;
                            var jumlahStrip = 0;
                            for (var i = 0; i< nilaiTglLahir.length; i++){
                                if(isNaN(nilaiTglLahir.charAt(i)) == false) {
                                    jumlahAngkaTglLahir++;
                                } else if(nilaiTglLahir.charAt(i) == '-'){
                                    jumlahStrip++;
                                } 
                            }
                            
                            if (form.perguruan_tinggi.value == "0"){
                                alert("Pilihan Perguruan Tinggi masih kosong!");
                                form.perguruan_tinggi.focus();
                                return (false);
                            } else if(form.nim.value == ""){
                                alert("NIM masih kosong!");
                                form.nim.focus();
                                return (false);
                            } else if(form.nama.value == ""){
                                alert("Nama masih kosong!");
                                form.nama.focus();
                                return (false);
                            } else if(form.tgl_lahir.value == ""){
                                alert("Tanggal lahir masih kosong!");
                                form.tgl_lahir.focus();
                                return (false);
                            } else if(jumlahAngkaTglLahir !== 8 || jumlahStrip !== 2){/** ------------------*/
                                alert("Format tanggal lahir 'DD-MM-CCYY'!");
                                form.tgl_lahir.focus();
                                return (false);
                            } else if(form.jenis_kelamin.value == "0"){
                                alert("Jenis kelamin masih kosong!");
                                form.tgl_lahir.focus();
                                return (false);
                            } else if(form.agama.value == "0"){
                                alert("Agama masih kosong!");
                                form.agama.focus();
                                return (false);
                            } else if(form.no_hp.value == ""){
                                alert("No handpone masih kosong!");
                                form.no_hp.focus();
                                return (false);
                            } else if(form.alamat.value == ""){
                                alert("Alamat masih kosong!");
                                form.alamat.focus();
                                return (false);
                            } else if(form.angkatan.value == ""){
                                alert("Angkatan masih kosong!");
                                form.angkatan.focus();
                                return (false);
                            } else if(form.status.value == ""){ 
                                alert("Pilihan status masih kosong!");
                                form.status.focus();
                                return (false);
                            }else if(form.email.value == ""){
                                alert("E-Mail masih kosong!");
                                form.email.focus();
                                return (false);
                            } else if(form.username.value == ""){
                                alert("Username masih kosong!");
                                form.username.focus();
                                return (false);
                            } else if(jumlahUsername < 8 || jumlahHurufUsername < 1 || jumlahAngkaUsername < 1){ 
                                alert("Username min. 8 karakter terdiri dari huruf dan angka");
                                form.username.focus();
                                return(false);
                            }else if(form.password.value == ""){
                                alert("Password masih kosong!");
                                form.password.focus();
                                return (false);
                            } else if(jumlahPassword < 8 || jumlahHurufPassword < 1 || jumlahAngkaPassword < 1){ 
                                alert("Password min. 8 karakter terdiri dari huruf dan angka");
                                form.password.focus();
                                return(false);
                            }else if(form.repeat_password.value == ""){
                                alert("Masukkan kembali password!");
                                form.repeat_password.focus();
                                return (false);
                            } else if (form.password.value !== form.repeat_password.value){
                                alert("Password yang Kamu masukkan tidak sama!");
                                form.repeat_password.focus();
                                return (false); 
                            }
                            
                            
                        
                            return true;
                        }
                    </script>

                    <!-- FORM REGISTRASI-->
                    <div class="sign-up-htm">
                        <form action="Registrasi?no=0" method="post" onsubmit="return validasi_input_registrasi(this)">
                            <!-- SELECT OPTIONS -->
                            <div class="group">
                                <label for="perguruan_tinggi" class="label" >Perguruan Tinggi</label>
                                <div class="custom-select" style="width:383px;">
                                    <select name="perguruan_tinggi">
                                        <option value="0">Pilih</option>
                                        <% try{ 
                                            Connection konek = Koneksi.getKoneksi();
                                            PreparedStatement statement = konek.prepareStatement("SELECT col_id_pt, col_nama_pt FROM tbl_pt;");
                                            ResultSet rs = statement.executeQuery();
                                            
                                            while(rs.next()) {
                                               out.print("<option value=\""+rs.getInt("col_id_pt")+"\">"+rs.getString("col_nama_pt")+"</option>");
                                            }
                                        } catch(SQLException ex) {
                                        
                                        }
                                        %>
                                    </select>  
                                </div>
                                
                            </div>
                            
                            <!-- NIM-->
                            <div class="group">
                                <label for="nim" class="label">NIM</label>
                                <input id="nim" type="text" class="input" name="nim">
                            </div>

                            <!--NAMA-->
                            <div class="group">
                                <label for="nama" class="label">Nama</label>
                                <input id="nama" type="text" class="input" name="nama">
                            </div>

                            <!--TANGGAL LAHIR-->
                            <div class="group">
                                <label for="tgl_lahir" class="label">Tanggal Lahir</label>
                                <input id="tgl_lahir" type="text" class="input" name="tgl_lahir" placeholder="DD-MM-CCYY">
                            </div>

                            <!--JENIS KELAMIN-->
                            <div class="group">
                                <label for="jenis_kelamin" class="label">Jenis Kelamin</label>
                                <div class="custom-select" style="width:383px;">
                                    <select name="jenis_kelamin">
                                        <option value="0"></option>
                                        <option value="L">Laki-Laki</option>
                                        <option value="P">Perempuan</option>
                                    </select>
                                </div>
                            </div>

                            <!--AGAMA-->
                            <div class="group">
                                <label for="agama" class="label">Agama</label>
                                 <div class="custom-select" style="width:383px;">
                                    <select name="agama">
                                        <option value="0"></option>
                                        <option value="Islam">Islam</option>
                                        <option value="Kristen">Kristen</option>
                                        <option value="Hindu">Hindu</option>
                                        <option value="Budha">Budha</option>
                                    </select>
                                </div>
                            </div>

                            <!-- No Handphone-->
                            <div class="group">
                                <label for="no_hp" class="label">No Handphone</label>
                                <input id="no_hp" type="text" class="input" name="no_hp">
                            </div>

                            <!-- ALAMAT -->
                            <div class="group">
                                <label for="alamat" class="label">Alamat</label>
                                <input id="alamat" type="text" class="input" name="alamat">
                            </div>

                            <!-- ANGKATAN -->
                            <div class="group">
                                <label for="angkatan" class="label">Angkatan</label>
                                <input id="angkatan" type="text" class="input" name="angkatan">
                            </div>

                            <!-- STATUS -->
                            <div class="group">
                                <label for="status" class="label">Status</label>
                                <div class="custom-select" style="width:383px;">
                                    <select name="status">
                                        <option value="">Pilih</option>
                                        <option value="0">Non-Aktif</option>
                                        <option value="1">Aktif</option>
                                    </select>
                                </div>
                            </div>

                            <!-- EMAIL -->
                            <div class="group">
                                <label for="email" class="label">E-Mail</label>
                                <input id="email" type="text" class="input" name="email">
                            </div>

                            <!-- USERNAME -->
                            <div class="group">
                                <label for="username" class="label">Username</label>
                                <input id="username" type="text" class="input" name="username">
                            </div>

                            <!-- PASSWORD -->
                            <div class="group">
                                <label for="password" class="label">Password</label>
                                <input id="password" type="password" class="input" data-type="password" name="password">
                            </div>

                            <!-- REPEAT PASSWORD -->
                            <div class="group">
                                <label for="repeat_password" class="label">Repeat Password</label>
                                <input id="repeat_password" type="password" data-type="password" class="input" name="repeat_password">
                            </div>

                            <div class="group">
                                <input type="submit" class="button" value="Daftar">
                            </div>

                            <div class="hr"></div>
                            
                            <div class="foot-lnk">
                                <label for="tab-1">Already Member?</a>
                            </div>
                     
                        </form>    
                    </div>
                     
                </div>
            </div>
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
