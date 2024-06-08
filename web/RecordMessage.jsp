<%-- 
    Document   : RecordMessage
    Created on : Aug 20, 2019, 2:21:31 PM
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
        out.println("<script type=\"text/javascript\">alert(\'Kamu harus log in terlebih dahulu\'); window.location = \'LoginRegistrasi.jsp?menu=LOG IN\';</script>");
    }
%>
<%! String idUser;%>
<%
    if(session.getAttribute("idUser") != null){
        idUser = session.getAttribute("idUser").toString();
    }
%>
<!--Identity Responden-->
<%! String idResponden;%>
<%! String idLevel; %>

<% idResponden = request.getParameter("id-responden"); 
    idLevel = request.getParameter("id-level");
%>
<html>
    <head>
        <title>KMS Mahasiswa SI</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"><script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="w3.css">
        <style type="text/css" media="all">
            @import "default-template.css";
        </style>
        <style type="text/css">
            #container{
                min-height: 2000px;
            }
            #panel-identitas-responden{
                position: relative;
                margin-top: 30px;
                margin-left: 70px;
                margin-right: 77px;
                padding: 10px;
                background-color: #d9e6f2;
            }
            #label-responden{
                margin-left: 29px;
            }
            .div-img{
                align-content: center;
            }
            .img-responden{
                margin: 0px;
                width: 30px;
                height: 30px;
                background-color: #ffffff;
                border:1px inset blue;
            }
            #div-daftar-message{
                overflow: auto;
                height: 300px;
            }
            .div-message-responden{
                position: relative;
                margin-left: 100px;
                margin-top: 20px;
                padding: 10px;
                width: 495px;
                border: 2px solid;
                border-color: transparent; /*#ccc;*/
                background-color: #e7e7e7;
            }
            .div-message-user{
                position: relative;
                margin-left: 409px;
                margin-top: 20px;
                padding: 10px;
                width: 495px;
                border: 2px solid;
                border-color: transparent;
                background-color: #ccc;
            }
            .content-message{
                margin-left: 10px;
                margin-right: 10px;
            }
            .waktu{
                font-size: 7pt;
                margin-left: 375px;
            }
            #textarea-message{
                position: relative;
                margin-left: 100px;
                margin-top: 80px;
                margin-right: 20px;
                padding: 10px;
                width: 675px;
                border: 1px solid;
                border-color: #0066cc; 
                background-color: #f0f5f5;
                resize: none;
            }
            #button-send{
                position: relative;
                margin-top: -70px;
                width: 103px;
                text-align: center;
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
                        <a href="HomeMahasiswa.jsp"><span id="icon-button" class="glyphicon glyphicon-home" style="font-size:18px;"></span></a>
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
                        <form action="Logout" method="post">
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
                            PreparedStatement statement = konek.prepareStatement("SELECT col_user_image, col_jenis_kelamin, col_agama, col_nama_mhs FROM "
                                    + "tbl_user INNER JOIN tbl_mahasiswa ON (tbl_mahasiswa.col_nim = tbl_user.col_id_user) "
                                    + "WHERE col_nim = \'"+idUser+"\'");
                            ResultSet rs = statement.executeQuery();
                            
                            while(rs.next()){
                                if(rs.getString("col_user_image") == null){
                                    if(rs.getString("col_jenis_kelamin").equals("L")){
                                        out.print("<img src=\"apps-img/boy.png\">");
                                    }else{
                                        if(rs.getString("col_agama").equals("Islam")){
                                            out.print("<img src=\"apps-img/woman.png\">");
                                        }else{
                                            out.print("<img src=\"apps-img/girl.png\">");
                                        }
                                    }
                                }else{
                                    out.print("<img src=\""+rs.getString("col_user_image")+"\">");
                                }
                                out.print(rs.getString("col_nama_mhs"));
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
                        <a href="Messaging.jsp" class="current">Messaging</a>
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
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    <!--PANEL IDENTITIAS RESPONDEN-->
                    <div id="panel-identitas-responden" class="w3-row-padding">
                        <div class="w3-col s11"><label id="label-responden"></label>
                        </div>
                        <div class="div-img" class="w3-col s1">
                            <img class="img-responden">
                        </div>
                        
                    </div>
                    
                    <!--PANEL DAFTAR MESSAGE-->
                    <div id="div-daftar-message">
                        <!--MESSAGE RESPONDEN-->
                        
                        <!--MESSAGE USER-->
                        
                    </div>
                        
                    <!--PANEL FORM REPLY/SEND MESSAGE-->
                    <div>
                        <form id="form-message" method="POST" action="SendMessage?id-responden=<% out.print(idResponden); %>&id-level=<% out.print(idLevel); %>" onsubmit="return validasi_input(this)">
                            <textarea id="textarea-message" name="message" placeholder="Message.." ></textarea>
                            <input id="button-send" type="submit" value="SEND" class="w3-button w3-round w3-blue">
                        </form>
                    </div>
                      
                </div>
            </div>
        </div>
        
        <footer id="footer">
            <h6 class="w3-center">© 2019 AMO. All rights reserved</h6>
        </footer>
    </body>
    
    <script>
        var ID_USER = <% out.println(idUser); %>
    </script>
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="notifikasi.js"></script>
    <script type="text/javascript">
        
        $(document).ready(function(){
                
            load_message('<% out.print(idResponden); %>', '<% out.print(idLevel); %>');
        });
        
        /** Memuat semua message dari responden*/
        var html_message = '';
        function load_message(id_responden = '', id_level = ''){
            console.log(id_responden, id_level);
            $.ajax({
                url:"GetMessage",
                method:"POST",
                data:{id_responden: id_responden, id_level: id_level},
                dataType:"json",
                success:function(data){
                    $('#label-responden').text(data.namaResponden);
                    if(data.userImage == null){
                        $('.img-responden').attr('src', 'apps-img/man-user.png');
                    }else{
                        $('.img-responden').attr('src', data.userImage);
                    }
                    
                    if(data.listMessage.length){
                        data.listMessage.forEach(function(item){
                            
                            if(item.pengirim == '<% out.print(idResponden); %>'){
                                html_message += "<div class=\"div-message-responden\">"+
                                                    "<p class=\"content-message\">"+item.detailMessage+"</p>"+
                                                    "<h6 class=\"waktu\">"+item.tglMessage+", "+item.waktu+"</h6>"+
                                                "</div>";
                            }else{
                                html_message += "<div class=\"div-message-user\">"+
                                                    "<p class=\"content-message\">"+item.detailMessage+"</p>"+
                                                    "<h6 class=\"waktu\">"+item.tglMessage+", "+item.waktu+"</h6>"+
                                                "</div>";
                            }
                        });
                    }
                    $('#div-daftar-message').html(html_message);
                    $('#textarea-message').focus();
                    $('#div-daftar-message').animate({scrollTop: $('#div-daftar-message').prop('scrollHeight')}, 0);
                }
            });
        }
        
        /**Memvalidasi input form pesan*/
        function validasi_input(form){
            if($('#textarea-message').val() == ""){
                alert("Pesan masih kosong!");
                $('#textarea-message').focus();
                return false;
            }
            
            return true;
        }
    </script>
</html>