<%-- 
    Document   : ViewMahasiswa
    Created on : Jul 31, 2019, 2:50:55 PM
    Author     : ASUS
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kmsclass.Koneksi"%>
<%@page import="java.sql.Connection"%>
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
            padding: 0;}
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
                margin-top: -30px;
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
            #button-message{
                position: relative;
                margin: 10px;
                margin-top: 45px;
                margin-left: 805px;
                margin-bottom: 50px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity: 80);
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
                    <!-- BUTTON HOME-->
                    <div class="w3-col s1 w3-padding-16">
                        <a href="Home.jsp"><span id="icon-button" class="glyphicon glyphicon-home" style="font-size:18px;"></span></a>
                    </div>
                    
                    <!-- BUTTON NOTIFIKASI -->
                    <div class="w3-col s1 w3-padding-16 notification ">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="Notifikasi.jsp" class="dropdown-toggle" data-toggle="dropdown"><span id="badge" class="label label-pill label-danger count" style="border-radius:10px;"></span><span class="glyphicon glyphicon-bell" style="font-size:18px;"></span></a>
                            </li>
                        </ul>
                    </div>
                    <!-- BUTTON LOG OUT-->
                    <div class="w3-col s3 w3-padding-16">
                        <form action="../Logout" method="post">
                            <input type="submit" name="menu" value="LOG OUT" class="w3-button w3-round w3-black w3-right">
                        </form>
                    </div>
                </div>
            </div>
            
            <div id="main">
                <!-- NAVIGASI SAMPING -->
                <ul id="nav-samping">
                    <li><a href="User.jsp">
                        <% try{
                            Connection konek = Koneksi.getKoneksi();
                            PreparedStatement statement = konek.prepareStatement("SELECT col_user_image, col_jenis_kelamin, col_nama_wadek FROM "
                                    + "tbl_user INNER JOIN tbl_wadek_kemahasiswaan ON (tbl_wadek_kemahasiswaan.col_nip = tbl_user.col_id_user) "
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
                                out.print(rs.getString("col_nama_wadek"));
                            }
                        }catch(SQLException ex){
                            out.print(ex.getMessage());
                        }
                        %>
                </a></li> 
                <li><a href="Mahasiswa.jsp">Mahasiswa</a></li>
                <li><a href="Messaging.jsp">Messaging</a></li>
                <li><a href="SistemInformasi.jsp">Sistem Informasi</a></li>
                <li><a href="Setelan.jsp">Setelan</a></li>
                </ul>
                
                <!--PANEL IMAGE-->
                <div id="img-pane">
                    <img id="img-profil">
                </div>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    <button id="button-message" name="message-user" value="" class="w3-button w3-blue w3-round">
                        <a id="link-message">MESSAGE</a>
                    </button>
                    <form id="form-user" method="POST" action="#" \>
                        <div>
                            <label class="label-form">NIM</label>
                            <input id="nim" class="input-form"  name="nim" type="text" ><br/>
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
                            <input id="jenis_kelamin" class="input-form" name="jenis_kelamin" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Agama</label>
                           <input id="agama" class="input-form" name="agama" type="text"><br/>
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
                            <label class="label-form">Perguruan Tinggi</label>
                            <input id="pt" class="input-form" name="pt" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Angkatan</label>
                            <input id="angkatan" class="input-form"name="angkatan" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Status</label>
                            <input id="status" class="input-form" name="status" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">E-Mail</label>
                            <input id="email" class="input-form" name="email" type="text"><br/>
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
    <script type="text/javascript">
        
        $(document).ready(function(){
            <%! String idMahasiswa;%>
            <%! String tipeSearch; %>   
            <% idMahasiswa = request.getParameter("user_id");%>
            <% tipeSearch = request.getParameter("tipe-search");%>
                
            load_profil('<% out.print(idMahasiswa);%>', '<% out.print(tipeSearch); %>');
        });
        
        /** Memuat profil User*/
        function load_profil(id = '', tipe = ''){
            $('.input-form').attr("readonly", "readonly");
            
            $.ajax({
                url:"../GetProfil",
                method:"POST",
                data:{id: id, tipe: tipe},
                dataType:"json",
                success:function(data){
                          $('#link-message').attr("href", "RecordMessage.jsp?id-responden="+id+"&id-level="+tipe);
                          $('#nim').val(data.nim); 
                          $('#nama').val(data.namaMahasiswa);
                          $('#tgl_lahir').val(data.tglLahir);
                          if(data.jenisKelamin == "L"){
                              $('#jenis_kelamin').val("Laki-Laki");
                          }else{
                              $('#jenis_kelamin').val("Perempuan");
                          }
                          $('#agama').val(data.agama);
                          $('#no_hp').val(data.noHp);
                          $('#alamat').val(data.alamat);
                          $('#pt').val(data.pt);
                          $('#angkatan').val(data.angkatan);
                          if(data.status == "0"){
                              $('#status').val("Non-Aktif");
                          }else if(data.status == 1){
                              $('#status').val("Aktif");
                          }
                          $('#email').val(data.email);
                          if(data.userImage == null){
                              if(data.jenisKelamin == "L"){
                                  $('#img-profil').attr('src', '../apps-img/boy.png');
                              }else{
                                  if(data.agama == "Islam"){
                                    $('#img-profil').attr('src', '../apps-img/woman.png');
                                  }else{
                                      $('#img-profil').attr('src', '../apps-img/girl.png');
                                  }
                              }
                          }else{
                            $('#img-profil').attr('src', '../'+data.userImage);
                          }
                }
            });
        }
    </script>
</html>
