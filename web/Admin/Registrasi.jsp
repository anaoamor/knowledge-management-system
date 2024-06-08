<%-- 
    Document   : Registrasi
    Created on : Sep 15, 2019, 9:28:21 PM
    Author     : ASUS
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kmsclass.Koneksi"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(session.getAttribute("idUser") == null){
        out.println("<script type=\"text/javascript\">alert(\'Anda harus log in terlebih dahulu\'); window.location = \'../LoginRegistrasi.jsp?menu=LOG IN\';</script>");
    }
%>
<%! String idUser;%>
<%
    if(session.getAttribute("idUser") != null){
        idUser = session.getAttribute("idUser").toString();
    }
%>
<html>
    <head>
        <title>KMS Mahasiswa SI</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"><script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="../w3.css">
        <style type="text/css" media="all">
            @import "../default-template.css";
        </style>
        <style type="text/css">
            #nav-samping{
                height: 500px;
            }
            #panel-subheader{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            #label-registrasi{
                position: relative;
                margin-top: 10px;
                margin-bottom: 30px;
                height: 40px;
                font-size: 15pt;
            }
            .div-form{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            .label-form{
                position: relative;
                margin: 10px;
                margin-left: 100px;
                width: 290px;
            }
            .input-form{
                position: relative;
                margin-left: 600px;
                margin: 10px;
                width: 495px;
                border: 1px solid;
                border-color: transparent transparent rgba(0, 0, 0, 0.5) transparent;
            }
            .select-form{
                position: relative;
                margin-left: 600px;
                margin: 10px;
                width: 495px;
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5);
            }
            .div-submit-button{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
                padding-top: 50px;
                padding-left: 230px;
                padding-right: 230px;
            }
            .button-form{
                position: relative;
                margin: 10px;
                width: 95px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity: 80);
            }
        </style>
    </head>
    
    <body>
        <div id="container">
            <div id="header">
                <div class="w3-half">
                    <h1 id="title-header">KMS Mahasiswa SI</h1>
                </div>
            
                <div class="w3-half w3-row-padding">
                    <div class="w3-col s6 w3-padding-16"></div>
                    <!--BUTTON HOME-->
                    <div class="w3-col s1 w3-padding-16">
                        <a href="Home.jsp"><span id="icon-button" class="glyphicon glyphicon-home" style="font-size:18px;"></span></a>
                    </div>

                    <!--BUTTON NOTIFIKASI-->
                    <div class="w3-col s1 w3-padding-16 notification">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="Notifikasi.jsp" class="dropdown-toggle" data-toggle="dropdown"><span id="badge" class="label label-pill label-danger count" style="border-radius:10px;"></span><span class="glyphicon glyphicon-bell" style="font-size:18px;"></span></a>
                            </li>
                        </ul>
                    </div>

                    <!--BUTTON LOG OUT-->
                    <div class="w3-col s3 w3-padding-16">
                        <form action="../Logout" method="post">
                            <input type="submit" name="menu" value="LOG OUT" class="w3-button w3-round w3-black w3-right">
                        </form>
                    </div>

                </div>
            </div>
            
            <div id="main">
                <!--NAVIGASI SAMPING-->
                <ul id="nav-samping">
                    <li id="list-user"><a href="User.jsp">
                        <% try{
                            Connection konek = Koneksi.getKoneksi();
                            PreparedStatement statement = konek.prepareStatement("SELECT col_user_image, col_jenis_kelamin, col_nama_admin FROM "
                                    + "tbl_user INNER JOIN tbl_admin ON (tbl_admin.col_nip = tbl_user.col_id_user) "
                                    + "WHERE col_nip = \'"+idUser+"\'");
                            ResultSet rs = statement.executeQuery();
                            
                            while(rs.next()){
                                if(rs.getString("col_user_image") == null){
                                    if(rs.getString("col_jenis_kelamin").equals("L")){
                                        out.print("<img src=\"../apps-img/boy.png\">");
                                    }else{
                                        out.print("<img src=\"../apps-img/woman.png\">");
                                    }
                                }else{
                                    out.print("<img src=\"../"+rs.getString("col_user_image")+"\">");
                                }
                                out.print(rs.getString("col_nama_admin"));
                            }
                        }catch(SQLException ex){
                            out.print(ex.getMessage());
                        }
                        %>
                    </a></li>
                    <li>
                        <a href="Mahasiswa.jsp" class="current">Mahasiswa</a>
                    </li>
                    <li>
                        <a href="UserManagement.jsp">User Management</a>
                    </li>
                    <li>
                        <a href="MateriKuliah.jsp">Materi Kuliah</a>
                    </li>
                    <li>
                        <a href="Messaging.jsp">Messaging</a>
                    </li>
                    <li>
                        <a href="ForumDiskusi.jsp">Forum Diskusi</a>
                    </li>
                    <li>
                        <a href="Feedback.jsp">Feedback</a>
                    </li>
                    <li>
                        <a href="Kurikulum.jsp">Kurikulum</a>
                    </li>
                    <li>
                        <a href="SistemInformasi.jsp">Sistem Informasi</a>
                    </li>
                    <li>
                        <a href="PerguruanTinggi.jsp">Perguruan Tinggi</a>
                    </li>
                    <li>
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    <div id="panel-subheader">
                        <label id="label-registrasi">Registrasi</label>
                    </div>
                    
                    <!--FORM REGISTRASI MAHASISWA-->
                    <form id="form-registrasi" method="POST" action="../Registrasi?no=1" onsubmit="return validasi_input_registrasi(this)">
                       
                        <div class="div-form">
                            <label class="label-form">Perguruan Tinggi</label>
                            <select id="perguruan_tinggi" name="perguruan_tinggi" class="select-form" type="text">
                                <% try{ 
                                    Connection konek = Koneksi.getKoneksi();
                                    PreparedStatement statement = konek.prepareStatement("SELECT tbl_pt.col_id_pt, col_nama_pt FROM tbl_pt "
                                            + "INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = tbl_pt.col_id_pt) WHERE tbl_admin.col_nip = ?");
                                    statement.setString(1, idUser);
                                    ResultSet rs = statement.executeQuery();

                                    while(rs.next()) {
                                       out.print("<option value=\""+rs.getString("col_id_pt")+"\">"+rs.getString("col_nama_pt")+"</option>");
                                    }
                                } catch(SQLException ex) {
                                    out.print("<option>"+ex.getMessage()+"</option>");
                                }
                                %>
                            </select><br>
                        </div>
                            
                         <div class="div-form">
                            <label class="label-form">NIM</label>
                            <input id="nim" name="nim" class="input-form" type="text"><br/>
                        </div>
                         
                        <!--NAMA-->
                            <div class="div-form">
                                <label for="nama" class="label-form">Nama</label>
                                <input id="nama" type="text" class="input-form" name="nama">
                            </div>

                            <!--TANGGAL LAHIR-->
                            <div class="div-form">
                                <label for="tgl_lahir" class="label-form">Tanggal Lahir</label>
                                <input id="tgl_lahir" type="text" class="input-form" name="tgl_lahir" placeholder="DD-MM-CCYY">
                            </div>

                            <!--JENIS KELAMIN-->
                            <div class="div-form">
                                <label for="jenis_kelamin" class="label-form">Jenis Kelamin</label>
                                <select id="jenis_kelamin" name="jenis_kelamin" class="select-form" type="text">
                                    <option value="0"></option>
                                    <option value="L">Laki-Laki</option>
                                    <option value="P">Perempuan</option>
                                </select>
                                
                            </div>

                            <!--AGAMA-->
                            <div class="div-form">
                                <label for="agama" class="label-form">Agama</label>
                                <select id="agama" name="agama" class="select-form" type="text">
                                        <option value="0"></option>
                                        <option value="Islam">Islam</option>
                                        <option value="Kristen">Kristen</option>
                                        <option value="Hindu">Hindu</option>
                                        <option value="Budha">Budha</option>
                                    </select>
                            </div>

                            <!-- No Handphone-->
                            <div class="div-form">
                                <label for="no_hp" class="label-form">No Handphone</label>
                                <input id="no_hp" type="text" class="input-form" name="no_hp">
                            </div>

                            <!-- ALAMAT -->
                            <div class="div-form">
                                <label for="alamat" class="label-form">Alamat</label>
                                <input id="alamat" type="text" class="input-form" name="alamat">
                            </div>

                            <!-- ANGKATAN -->
                            <div class="div-form">
                                <label for="angkatan" class="label-form">Angkatan</label>
                                <input id="angkatan" type="text" class="input-form" name="angkatan">
                            </div>

                            <!-- STATUS -->
                            <div class="div-form">
                                <label for="status" class="label-form">Status</label>
                                <select id="status" name="status" type="text" class="select-form">
                                    <option value="">Pilih</option>
                                    <option value="0">Non-Aktif</option>
                                    <option value="1">Aktif</option>
                                </select>
                            </div>

                            <!-- EMAIL -->
                            <div class="div-form">
                                <label for="email" class="label-form">E-Mail</label>
                                <input id="email" type="text" class="input-form" name="email">
                            </div>

                            <!-- USERNAME -->
                            <div class="div-form">
                                <label for="username" class="label-form">Username</label>
                                <input id="username" type="text" class="input-form" name="username">
                            </div>

                            <!-- PASSWORD -->
                            <div class="div-form">
                                <label for="password" class="label-form">Password</label>
                                <input id="password" type="password" class="input-form" data-type="password" name="password">
                            </div>

                            <!-- REPEAT PASSWORD -->
                            <div class="div-form">
                                <label for="repeat_password" class="label-form">Repeat Password</label>
                                <input id="repeat_password" type="password" data-type="password" class="input-form" name="repeat_password">
                            </div>

                    </form>
                    
                    <!--BUTTON SUBMIT DAN CANCEL-->
                    <div class="div-submit-button">
                        <div class="div-button">
                            <input id="button-submit" type="submit" value="SUBMIT" form="form-registrasi" class="w3-button w3-round w3-blue button-form">
                        </div>
                        <div class="div-button">
                            <input id="button-cancel" type="submit" value="CANCEL" class="w3-button w3-round w3-blue button-form">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <footer id="footer">
            <h6 class="w3-center">© 2019 AMO. All rights reserved</h6>
        </footer>
    </body>
    
    <script>
        var ID_USER = '<% out.print(idUser); %>';
    </script>
    <script type="text/javascript" src="../jquery.js"></script>
    <script type="text/javascript" src="notifikasi.js"></script>
    <script type="text/javascript">
        
        $(document).ready(function(){
            $('#button-cancel').click(function(){
                var konfirmasi = window.confirm("Batalkan registrasi akun mahasiswa?");
                if(konfirmasi){
                    window.location = 'RegistrasiMahasiswa.jsp';
                }
            });
        });
        
        <!-- javascript untuk memeriksa terisi atau tidak textfield form-->
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
</html>