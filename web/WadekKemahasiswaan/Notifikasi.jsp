<%-- 
    Document   : Notifikasi
    Created on : Aug 30, 2019, 11:38:08 AM
    Author     : ASUS
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kmsclass.Koneksi"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(session.getAttribute("idUser") == null){
        out.println("<script type=\"text/javascript\">alert(\'Anda harus log in terlebih dahulu\'); window.location = \'../LoginRegistrasi.jsp?menu=LOG IN\';</script>");
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
        <style type="text/css">
            *{margin: 0px auto;
            padding:0;
            }
            html, body{
                height:100%;
            }
            #container{
                min-height:2000px;
                background-color: #0066cc;
            }
            #header{
                height: 75px;
                background: #fff;
                color: #000;
            }
            #main{
                overflow:auto;
                padding-bottom:40px;
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
            #home{
                margin-top: 18px;
            }
            input[type=submit]{
                margin-top: 10px;
                margin-right: 20px;
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
            #panel-notifikasi{
                opacity: 0.7;
                filter: alpha(opacity=70); /* For IE8 and earlier*/
                position: absolute;
                right: 0px;
                margin-top:50px;
                margin-right: 50px;
                padding-bottom: 30px;
                width: 75%;
                background-color: #ffffff;
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
            #title-notifikasi{
                font-weight: bold;
            }
            #ul-notifikasi {
                list-style-type: none;
                margin-left: 30px;
                margin-right: 30px;
            }
            #tipe-notifikasi {
                border: 2px solid;
            }
            #notifikasi-registrasi{
                list-style-type: none;
                margin-left: 20px;
                margin-right: 20px;
            }
            #notifikasi-messaging{
                list-style-type: none;
                margin-left: 20px;
                margin-right: 20px;
            }
            #tipe-notifikasi-nested {
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) transparent transparent transparent;
            }
            #a-nonlink{
               text-decoration: none; 
               font-size: 15pt;
               font-weight: bold;
            }
            #a-no-found{
                text-decoration: none;
                text-align: center;
                font-size: 9pt;
            }
            #load-notifikasi-messaging {
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) transparent transparent transparent;
                text-align: center;
                font-size: 9pt;
                margin-left: 20px;
                margin-right: 20px;
            }
        </style>
    </head>
    
    <body>
        <%! String idUser;%>
        <%! String tipeUser;%>
        <% 
            if(session.getAttribute("idUser") != null){
                idUser = session.getAttribute("idUser").toString();
                tipeUser = session.getAttribute("tipeUser").toString();
            }
        %>
        <div id="container">
            
            <div id="header">
                <div class="w3-half">
                    <h1 id="title-header">KMS Mahasiswa SI</h1>
                </div>
                <div class="w3-half w3-row-padding">
                    
                    <div class="w3-col s8 w3-padding-16">
                        
                    </div>
                    
                    <!--BUTTON HOME-->
                    <div class="w3-col s1 w3-padding-16">
                        <a href="Home.jsp"><span id="home" class="glyphicon glyphicon-home" style="font-size:18px;"></span></a>
                    </div>
                    
                    <!--BUTTON LOGOUT-->
                    <div class="w3-col s3 w3-padding-16">
                        <form action="../Logout" method="post">
                            <input type="submit" name="menu" value="LOG OUT" class="w3-button w3-round w3-black w3-right">
                        </form>
                    </div>
                </div>
            </div>
            
            <div id="main">
                <ul id="nav-samping">
                    <li id="list-user"><a href="User.jsp">
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
                    <li>
                        <a href="Mahasiswa.jsp">Mahasiswa</a>
                    </li>
                    <li>
                        <a href="Messaging.jsp">Messaging</a>
                    </li>
                    <li>
                        <a href="SistemInformasi.jsp">Sistem Informasi</a>
                    </li>
                    <li>
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!-- PANEL NOTIFIKASI -->
                <div id="panel-notifikasi">
                    <h3 id="title-notifikasi" class="w3-center">NOTIFICATIONS</h3><br/>
                    
                    <!-- Jenis - Jenis Notifikasi -->
                    <ul id="ul-notifikasi">
                        <li id="tipe-notifikasi">
                            <a id="a-nonlink"><span>Registrasi Mahasiswa</span></a>
                            <ul id="notifikasi-registrasi" ></ul>
                        </li>
                        <li id="tipe-notifikasi">
                            <a id="a-nonlink"><span>Messaging</span></a>
                            <ul id="notifikasi-messaging" ></ul>
                            <a id="load-notifikasi-messaging">Load Notification</a>
                        </li>
                    </ul>
                </div>
                
            </div>
        </div>
        
        <footer id="footer">
            <h6 class="w3-center">© 2019 AMO. All rights reserved</h6>
        </footer>
        <script type="text/javascript" src="../jquery.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                
                var html_registrasi = "";
                function load_notification_registrasi(id = '', n = ''){
                    $.ajax({
                        url:"../NotifikasiRegistrasi",
                        method:"POST",
                        data:{id: id, n: n},
                        dataType:"json",
                        success:function(data){
                            if(data.notifikasiRegistrasi.length){
                                data.notifikasiRegistrasi.forEach(function(item) {
                                    html_registrasi += "<li id=\"tipe-notifikasi-nested\">"
                                   + "<a href=\'RecordRegistrasi.jsp?nim="+item.nim+"\'>" 
                                 + "<strong>" + item.namaMahasiswa
                                 + "</strong><br/>"
                                 + "<small>" + item.nim
                                 + "<br/>"
                                 + "</small>"
                                 + "</a>"
                                 + "</li>";
                                });
                            } else {
                                html_registrasi += "<li id=\"tipe-notifikasi-nested\"><a id=\"a-no-found\">No Notification Found</a></li>";
                            }

                            $('#notifikasi-registrasi').html(html_registrasi);
                            
                        }
                    });
                }
                
                var n_notifikasi_messaging = 0;
                var html_messaging = "";
                function load_notification_messaging(id = '', n = ''){
                    $.ajax({
                        url:"../NotifikasiMessaging",
                        method:"POST",
                        data:{id: id, n: n},
                        dataType:"json",
                        success:function(data){
                            if(data.notifikasi.length){
                                data.notifikasi.forEach(function(item) {
                                    html_messaging += "<li id=\"tipe-notifikasi-nested\">"
                                   + "<a href=\'RecordMessage.jsp?id-responden="+item.idPengirim+"&id-level="+item.idLevelPengirim+"\'>"
                                 + "<strong>" + item.pengirim
                                 + "</strong><br/>"
                                 + "<small>" + item.detailMessage
                                 + "...<br/>"
                                 + "<small>" + item.datetime
                                 + "</small></small>"
                                 + "</a>"
                                 + "</li>";
                                });
                            } else {
                                html_messaging += "<li id=\"tipe-notifikasi-nested\"><a id=\"a-no-found\">No Notification Found</a></li>";
                                $('#load-notifikasi-messaging').remove();
                            }

                            $('#notifikasi-messaging').html(html_messaging);
                            
                        }
                    });
                }
                
               load_notification_registrasi('<% out.print(idUser); %>', '');
               load_notification_messaging('<% out.print(idUser); %>', '');
               
               $(document).on('click', '#load-notifikasi-messaging', function(){
                   
                   n_notifikasi_messaging++;
                   load_notification_messaging(<% out.print(idUser); %>, n_notifikasi_messaging);
                });
               
            });
        </script>
    </body>
</html>
