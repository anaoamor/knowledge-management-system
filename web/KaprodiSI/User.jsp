<%-- 
    Document   : User
    Created on : Sep 9, 2019, 11:49:46 AM
    Author     : ASUS
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kmsclass.Koneksi" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(session.getAttribute("idUser") == null){
        out.println("<script type=\"text/javascript\">alert(\'Anda harus log in terlebih dahulu\'); window.location = \'../LoginRegistrasi.jsp?menu=LOG IN\';</script>");
    }
%>
<%! String idUser;%>
<%! String tipeUser;%>
<%
    if(session.getAttribute("idUser") != null){
        idUser = session.getAttribute("idUser").toString();
        tipeUser = session.getAttribute("tipeUser").toString();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KMS Mahasiswa SI</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="../w3.css">
        <style type="text/css">
            *{margin: 0px auto;
            padding:0;}
            html, body{
                height: 100%;
            }
            #container{
                min-height: 1300px;
                background-color: #0066cc;
            }
            #header{
                height: 75px;
                background: #fff;
                color: #000;
            }
            #main{
                overflow: auto;
                padding-bottom: 40px;
            }
            #footer{
                height: 30px;
                background: #fff;
                color: #000;
                margin-top:-30px;
                clear: both;
                position: relative;
            }
            #title-header{
                padding-left: 20px;
            }
            #icon-button{
                margin-top: 11px;
            }
            .notification{
                text-decoration: none;
                position: relative;
                display: inline-block;
                border-radius: 2px;
                margin-top: 0px;
            }
            #badge{
                position: absolute;
                top: -0px;
                right: -0px;
            }
            span{
                font-size: 12px;
                align-content: center;
            }
            #button-logout{
                margin-top: 10px;
                margin-right: 10px;
            }
            #nav-samping {
                list-style-type: none;
                margin: 0;
                padding: 0;
                width: 15%;
                background-color: #f1f1f1;
                opacity: 0.85;
                filter: alpha(opacity:85);/* For IE8 and earlier*/
                position: absolute;
                left: 0px;
                height: 400px;
                overflow: auto;
            }
            #panel-content{
                opacity: 0.8;
                filter: alpha(opacity=70); /* For IE8 and earlier*/
                position: absolute;
                right: 0px;
                margin-top:200px;
                margin-right: 50px;
                width: 75%;
                background-color: #ffffff;
                padding-top: 50px;
                padding-bottom: 50px;
            }
            li a {
                display: block;
                color: #000;
                padding: 8px 16px;
                text-decoration: none;
            }
            li img{
                display: block;
                color: #000;
                padding: 8px 56px;
                text-decoration: none;
                height: 64px;
            }
            li img a{
                display: block;
                color: #000;
                padding: 8px 16px;
                text-decoration: none;
                height: 64px;
            }
            li a.active {
                background-color:white;
                color: white;
            }
            li a:hover:not(.active) {
                background-color: #555;
                color: white;
            }
            li a.current{
                background:#ff3300;
                color:white;
                opacity: 0.5;
            }
            #img-pane{
                position: absolute;
                right: 0px;
                margin-top:50px;
                margin-right: 505px;
                align-content: center;
                width: 8%;
                height: 18%;
                background-color: #ffffff;
                border:5px inset blue;
            }
            #img-pane img{
                width: 96px;
                height: 104px;
            }
            #img-pane #change-img{
                position: relative;
                margin-left: 77px;
                margin-top: -21px;
                display: table;
                cursor: pointer;
                background: transparent;
                border-color: transparent;
            }
            #change-img:hover{
                color: blue;
            }
            /* The Modal (background) - For Upload Image Pop Up*/
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                padding-top: 100px; /* Location of the box */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
              }
            /* Modal Content */
            .modal-content {
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 40%;
              }
            /* The close button*/
            .close {
                color: #aaaaaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
              }
            .close:hover,
            .close:focus {
              color: #000;
              text-decoration: none;
              cursor: pointer;
            }
            h4{
                text-align: center;
                font-weight: bold;
            }
            #submit-img{
                margin-left: 207px;
            }
            #h6-img-size{
                font-size: 10px;
            }
            
            /* The switch - the box around the slider */
            .switch{
                position: relative;
                display: inline-block;
                width: 50px;
                height: 24px;
            }
            /* Hide default HTML checkbox */
            .switch input{
                opacity: 0;
                width: 0;
                height: 0;
            }
            /* The slider */
            .slider{
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                -webkit-transition: .4s;
                transition: .4s;
            }
            .slider:before{
                position: absolute;
                content: "";
                height: 20px;
                width: 20px;
                left: 2px;
                bottom: 2px;
                background-color:white;
                -webkit-transition: .4s;
            }
            input:checked + .slider{
                background-color: #2196F3;
            }
            input:focus + .slider{
                box-shadow: 0 0 1px #2196F3;
            }
            input:checked + .slider:before{
                -webkit-transform: translateX(26px);
                -ms-transform: translateX(26px);
                transform: translateX(26px);
            }
            /* Rounded sliders */
            .slider.round{
                border-radius: 34px;
            }
            .slider.round:before{
                border-radius: 50%;
            }
            #button-save{
                position: relative;
                margin: 10px;
                margin-top: 45px;
                margin-bottom: 50px;
                width: 95px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity: 80);
            }
            #button-cancel{
                position: relative;
                margin: 10px;
                margin-top: 45px;
                margin-bottom: 50px;
                width: 95px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity: 80);
            }
            #form-user{
                
            }
            #label-edit{
                position: relative;
                margin: 10px;
                margin-top: 30px;
                margin-left: 100px;
                width: 515px;
                height: 40px;
                font-size: 25px;
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
            .unedit-form{
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
                            PreparedStatement statement = konek.prepareStatement("SELECT col_user_image, col_jenis_kelamin, col_nama_kaprodi FROM "
                                    + "tbl_user INNER JOIN tbl_kaprodi_si ON (tbl_kaprodi_si.col_nip = tbl_user.col_id_user) "
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
                                out.print(rs.getString("col_nama_kaprodi"));
                            }
                        }catch(SQLException ex){
                            out.print(ex.getMessage());
                        }
                        %>
                    </a></li>
                    <li>
                        <a href="MateriKuliah.jsp">Materi Kuliah</a>
                    </li>
                    <li>
                        <a href="Kurikulum.jsp">Kurikulum</a>
                    </li>
                    <li>
                        <a href="Messaging.jsp">Messaging</a>
                    </li>
                    <li>
                        <a href="ForumDiskusi.jsp">Forum Diskusi</a>
                    </li>
                    <li>
                        <a href="SistemInformasi.jsp">Sistem Informasi</a>
                    </li>
                    <li>
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!-- PANEL CONTENT -->
                <div id="img-pane">
                   <img id="img-profil">
                   <button id="change-img">
                       <span id="icon-image" class="glyphicon glyphicon-camera" style="font-size:18px;"></span>
                   </button>
                   
                   <!--Modal image upload-->
                   <div id="myModal" class="modal">
                       
                       <!-- Modal content-->
                       <div class="modal-content">
                           <span class="close">&times;</span>
                           <h4>Update Profile Image</h4><br>
                           <form name="form-img" method="POST" action="../UpdateProfilImageKaprodi" enctype="multipart/form-data">
                               
                                <input type="file" size="60px" accept="image/png" name="file-img">
                                <h6 id="h6-img-size">Images(*.png) size min. 10KB & max. 100KB</h6><br>
                                <input id="submit-img" type="submit" name="submit-img" value="Submit" class="w3-button w3-blue w3-opacity w3-round ">
                           </form>
                       </div>
                       
                   </div>
                </div>
                
                <div id="panel-content">
                    <label id="label-edit">Edit</label>
                    <label class="switch">
                        <input id="check-edit" type="checkbox">
                        <span class="slider round"></span>
                    </label>
                    <input id="button-save" type="submit" name="opsi-edit" value="SAVE" form="form-user" class="w3-button w3-blue w3-round ">
                    <input id="button-cancel"type="submit" name="opsi-edit" value="CANCEL" class="w3-button w3-blue w3-round "><br/>
                    <form id="form-user" method="POST" action="../UpdateProfilKaprodi?id=<% out.print(idUser);%>&tipe=<% out.print(tipeUser); %>" onSubmit="return validasi_input(this)">
                        <div>
                            <label class="label-form">NIP</label>
                            <input id="nip" class="unedit-form"  name="nip" type="text" ><br/>
                        </div>
                        <div>
                            <label class="label-form">Nama</label>
                            <input id="nama" class="input-form"name="nama" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Tanggal Lahir</label>
                            <input id="tgl_lahir" class="input-form" name="tgl_lahir" type="text"><br/>
                        </div>
                        <div id="panel_jenis_kelamin">
                            <label class="label-form">Jenis Kelamin</label>
                            <select id="jenis_kelamin" class="select-form" name="jenis_kelamin" type="text">
                            </select><br/>
                        </div>
                        <div>
                            <label class="label-form">No Handphone</label>
                            <input id="no_hp" class="input-form"name="no_hp" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Alamat</label>
                            <input id="alamat" class="input-form"name="alamat" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Status</label>
                            <select id="status" class="select-form" name="status" type="text">
                            </select><br/>
                        </div>
                        <div>
                            <label class="label-form">Jabatan</label>
                            <input id="jabatan" class="input-form"name="jabatan" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Golongan</label>
                            <input id="golongan" class="input-form" name="golongan" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">E-Mail</label>
                            <input id="email" class="input-form" name="email" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Fakultas</label>
                            <input id="fakultas" class="unedit-form" name="fakultas" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Perguruan Tinggi</label>
                            <input id="pt" class="unedit-form" name="pt" type="text"><br/>
                        </div>
                    </form>
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
    <script>
        
        //UPLOAD PROFIL IMAGE
        // Get the modal
        var modal = document.getElementById("myModal");

        // Get the button that opens the modal
        var btn = document.getElementById("change-img");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks the button, open the modal 
        btn.onclick = function() {
          modal.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
          modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
          if (event.target == modal) {
            modal.style.display = "none";
          }
        }
        
    </script>
    <script type="text/javascript">
        
        $(document).ready(function(){
            
            load_profil('<% out.print(idUser); %>', '<% out.print(tipeUser); %>');
            
            /**Jika button edit on*/
            $('#check-edit').click(function(){
                if($(this).prop("checked") === true){
                    $('.input-form').removeAttr("readonly");
                    $('#button-save').removeAttr("disabled");
                    $('#button-cancel').removeAttr("disabled");
                    $('#jenis_kelamin').html("<option value=\"0\"></option>"+
                            "<option value=\"L\">Laki-Laki</option>"+
                            "<option value=\"P\">Perempuan</option>");
                    $('#status').html("<option value=\"\"></option>"+
                            "<option value=\"0\">PNS Dosen</option>"+
                            "<option value=\"1\">Non-PNS Dosen</option>"+
                            "<option value=\"2\">PNS Administrasi</option>"+
                            "<option value=\"3\">Non-PNS</option>");
                } else {
                    load_profil('<% out.print(idUser); %>', '<% out.print(tipeUser); %>');
                }
            });
            
            $("#button-cancel").click(function(){
                $('#check-edit').removeAttr("checked");
                load_profil('<% out.print(idUser); %>', '<% out.print(tipeUser); %>');
            });
        });
        
        /** Memuat profil user*/
        function load_profil(id = '', tipe = ''){
            $('.input-form').attr("readonly", "readonly");
            $('.select-form').attr("readonly", "readonly");
            $('.unedit-form').attr("readonly", "readonly");
            $('#button-save').attr("disabled", "disabled");
            $('#button-cancel').attr("disabled", "disabled");
            
            $.ajax({
                url:"../GetProfilStaff",
                method:"POST",
                data:{id: id, tipe: tipe},
                dataType:"json",
                success:function(data){
                          $('#nip').val(data.nip); 
                          $('#nama').val(data.namaStaff);
                          $('#tgl_lahir').val(data.tglLahir);
                          if(data.jenisKelamin == "L"){
                              $('#jenis_kelamin').html("<option value='L'>Laki-Laki</option>");
                          }else{
                              $('#jenis_kelamin').html("<option value='P'>Perempuan</option>");
                          }
                          if(data.noHp == "" || data.noHp == null){
                              $('#no_hp').val("-");
                          } else{
                            $('#no_hp').val(data.noHp);
                          }
                          if(data.alamat == "" || data.alamat == null){
                              $('#alamat').val("-");
                          } else{
                            $('#alamat').val(data.alamat);
                          }
                          
                          if(data.status == "0"){
                              $('#status').html("<option value='0'>PNS Dosen</option>");
                          }else if(data.status == 1){
                              $('#status').html("<option value='1'>Non-PNS Dosen</option>");
                          } else if(data.status == "2"){
                              $('#status').html("<option value='2'>PNS Administrasi</option>");
                          }else if(data.status == 1){
                              $('#status').html("<option value='3'>Non-PNS</option>");
                          }
                          $('#jabatan').val(data.jabatan);
                          $('#golongan').val(data.golongan);
                          $('#email').val(data.email);
                          $('#fakultas').val(data.fakultas);
                          $('#pt').val(data.pt);
                          
                          
                          if(data.userImage == null){
                              if(data.jenisKelamin == "L"){
                                  $('#img-profil').attr('src', '../apps-img/boy.png');
                              }else{
                                $('#img-profil').attr('src', '../apps-img/woman.png');
                              }
                          }else{
                            $('#img-profil').attr('src', '../'+data.userImage);
                          }
                }
            });
        }
        
        /** Memvalidasi input*/
        function validasi_input(form){

            var nilaiTglLahir = $('#tgl_lahir').val();
            var jumlahAngkaTglLahir = 0;
            var jumlahStrip = 0;
            for (var i = 0; i< nilaiTglLahir.length; i++){
                if(isNaN(nilaiTglLahir.charAt(i)) == false) {
                    jumlahAngkaTglLahir++;
                } else if(nilaiTglLahir.charAt(i) == '-'){
                    jumlahStrip++;
                } 
            }

            //Memerikasi field form jika ada yang kosong
            if($('#nip').val() == ""){
                alert("NIP masih kosong!");
                $('#nip').focus();
                return (false);
            } else if($('#nama').val() == ""){
                alert("Nama masih kosong!");
                $('#nama').focus();
                return (false);
            } else if($('#tgl_lahir').val() == ""){
                alert("Tanggal lahir masih kosong!");
                $('#tgl_lahir').focus();
                return (false);
            } else if(jumlahAngkaTglLahir !== 8 || jumlahStrip !== 2 || nilaiTglLahir.charAt(2) != '-' || nilaiTglLahir.charAt(5) != '-'){/** ------------------*/
                alert("Format tanggal lahir 'DD-MM-CCYY'!");
                $('#tgl_lahir').focus();
                return (false);
            }else if($('#jenis_kelamin').val() == "0"){
                alert("Jenis kelamin masih kosong!");
                $('#jenis_kelamin').focus();
                return (false);
            } else if($('#status').val() == ""){
                alert("Status masih kosong!");
                $('#status').focus();
                return (false);
            } else if($('#no_hp').val() == ""){
                alert("No handphone masih kosong!");
                $('#no_hp').focus();
                return (false);
            } else if($('#alamat').val() == ""){
                alert("Alamat masih kosong!");
                $('#alamat').focus();
                return (false);
            } else if($('#jabatan').val() == ""){
                alert("Jabatan masih kosong!");
                $('#jabatan').focus();
                return (false);
            } else if($('#golongan').val() == ""){
                alert("Golongan masih kosong!");
                $('#golongan').focus();
                return (false);
            } else if($('#email').val() == ""){
                alert("Email masih kosong!");
                $('#email').focus();
                return (false);
            }
            
            return true;
        }
        
    </script>
</html>
