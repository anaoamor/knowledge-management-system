<%-- 
    Document   : AllMataKuliah
    Created on : Aug 3, 2019, 3:57:52 PM
    Author     : ASUS
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kmsclass.Koneksi"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KMS Mahasiswa SI</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="w3.css">
        <style type="text/css">
            *{margin: 0px auto;
            padding: 0;}
            html, body{
                height: 100%;
            }
            #container{
                min-height: 3300px;
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
            #nav-samping{
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
            li a{
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
            li a.active{
                background-color:white;
                color: white;
            }
            li a:hover:not(.active){
                background-color: #555;
                color: white;
            }
            li a.current{
                background:#ff3300;
                color:white;
                opacity: 0.5;
            }
            #panel-content{
                opacity: 0.8;
                filter: alpha(opacity=70); /* For IE8 and earlier*/
                position: absolute;
                right: 0px;
                margin-top:100px;
                margin-right: 50px;
                width: 75%;
                background-color: #ffffff;
                padding-top: 10px;
                padding-bottom: 50px;
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            .div-mata-kuliah{
                margin-top: 50px;
                display: flex;
                flex-flow: column wrap;
                align-items: center;
            }
            .div-mata-kuliah:hover{
                color: gray;
                opacity: 0.7;
            }
            .opsi-mata-kuliah{
                position: relative;
                width: 150px;
                height: 150px;
                background-color: #fff;
            }
            label{
                font-size: 10pt;
                margin-top: 5px;
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
                        <a href="HomeMahasiswa.jsp"><span id="icon-button" class="glyphicon glyphicon-home" style="font-size:18px;"></span></a>
                    </div>
                    
                    <!-- BUTTON NOTIFIKASI-->
                    <div class="w3-col s1 w3-padding-16 notification ">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="Notifikasi.jsp" class="dropdown-toggle" data-toggle="dropdown"><span id="badge" class="label label-pill label-danger count" style="border-radius:10px;"></span><span class="glyphicon glyphicon-bell" style="font-size:18px;"></span></a>
                            </li>
                        </ul>
                        
                    </div>
                    
                    <!-- BUTTON LOG OUT-->
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
                        <a href="MateriKuliah.jsp" class="current">Materi Kuliah</a>
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
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    
                </div>
            </div>
        </div>
        
        <footer id="footer">
            <h6 class="w3-center">© 2019 AMO. All rights reserved</h6>
        </footer>
    </body>
    
    <script> var ID_USER = <% out.println(idUser); %></script>
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="notifikasi.js"></script>
    <script type="text/javascript">
        
        $(document).ready(function(){
            <%! String idKurikulum;%>
            <% idKurikulum = request.getParameter("id-kurikulum");%>
                
            load_all_mata_kuliah('<% out.print(idKurikulum); %>');    
        });
        
        /** Memuat semua daftar Mata Kuliah Prodi SI di PT tertentu*/
        var html_all_matkul = '';
        function load_all_mata_kuliah(id_kurikulum = ''){
            $.ajax({
                url:"GetAllMataKuliah",
                method:"POST",
                data:{id_kurikulum: id_kurikulum},
                dataType:"json",
                success:function(data){
                    if(data.listMatkul.length){
                        data.listMatkul.forEach(function(item){
                            if(item.namaMatkul.length > 15){
                                var label_matkul = item.namaMatkul.substring(0, 15);
                                html_all_matkul += "<div class=\"div-mata-kuliah\">"+
                                    "<button class=\"opsi-mata-kuliah\" onclick=\"window.window.location.href=\'MataKuliah.jsp?id-matkul="+item.kodeMatkul+"\'\"><img src=\"apps-img/folder.png\"></button>"+
                                    "<label>"+label_matkul+"..</label></div>";
                            }else{
                                html_all_matkul += "<div class=\"div-mata-kuliah\">"+
                                    "<button class=\"opsi-mata-kuliah\" onclick=\"window.location.href=\'MataKuliah.jsp?id-matkul="+item.kodeMatkul+"\'\"><img src=\"apps-img/folder.png\"></button>"+
                                    "<label>"+item.namaMatkul+"</label></div>";
                            }
                        });
                        
                    }
                    $('#panel-content').html(html_all_matkul);
                }
            });
        }
    </script>
</html>
