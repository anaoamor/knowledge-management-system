<%-- 
    Document   : MateriKuliah
    Created on : Jul 20, 2019, 10:28:47 AM
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
        <link rel="stylesheet" type="text/css" href="w3.css">
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
                margin-top:100px;
                margin-right: 50px;
                width: 75%;
                background-color: #ffffff;
                padding-top: 10px;
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
            .form-inline{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
                margin-top: 45px;
                margin-left: 344px;
            }
            input[type=text]{
                border: 2px solid transparent;
                border-color: transparent transparent rgba(0, 0, 0, 0.5) transparent;
                background: rgba(255,255, 255,.1);
            }
            #button-search{
                background: transparent;
                border: none;
            }
            #button-search:hover{
                color: white;
                opacity: 0.5;
            }
            /* The Modal (background) - For Display Search Result*/
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
            /*Modal Content*/
            .modal-content{
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 40%;
            }
            /* The close button*/
            .close{
                color: #aaaaaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }
            .close:hover,
            .close:focus{
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }
            h4{
                text-align: center;
                font-weight: bold;
            }
            #ul-result{
                list-style-type: none;
                margin-left: 20px;
                margin-right: 20px;
            }
            #li-result{
                border: 1px solid;
                border-color: transparent transparent rgba(0, 0, 0, 0.5) transparent;
                width: 380px;
            }
            #request{
                position: relative;
                margin: 10px;
                margin-top: 35px;
                margin-bottom: 50px;
                width: 125px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity:80);
            }
            #my-upload{
                position: relative;
                margin: 10px;
                margin-top: 35px;
                margin-bottom: 50px;
                width: 125px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity:80);
            }
            #panel-opsi-si{
                /*padding-left: 10px;*/
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            .div-opsi-si{
                margin-top: 50px;
                display: flex;
                flex-flow: column wrap;
                align-items: center;
            }
            .div-opsi-si:hover{
                color:gray;
                opacity: 0.7;
            }
            .opsi-si{
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
                        <form action="Logout" method="post">
                            <input type="submit" name="menu" value="LOG OUT" class="w3-button w3-round w3-black w3-right">
                        </form>
                    </div>
                </div>
            </div>
            
            <div id="main">
                <!-- NAVIGASI SAMPING -->
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
                
                <!-- PANEL CONTENT -->
                <div id="panel-content">
                    
                    <!-- Panel Submenu Materi Kuliah-->
                    <div class="w3-row-padding">
                        
                        <!--Space Kosong-->
                        <div class="w3-col s9"></div>
                        
                        <!--Form Pencarian Materi Kuliah-->
                        <div class="w3-col s3 form-inline">
                            <form id="search-form" method="POST">
                                <input id="search-input" type="text" name="search-materi" placeholder="Materi Kuliah">
                            </form>
                            <input id="button-search" type="image" src="apps-img/browser.png" alt="Submit">
                        </div>
                        
                        <!-- Modal Search Result Materi Kuliah-->
                        <div id="myModal" class="modal">
                            
                            <!-- Modal Content-->
                            <div class="modal-content">
                                <span class="close">&times;</span>
                                <h4>Search Result</h4><br>
                                <ul id="ul-result"></ul>
                            </div>
                            
                        </div>
                        
                        <!--Button Add Request-->
                        <div class="w3-col s2">
                            <input id="request" type="submit" value="Request"  class="w3-button w3-blue w3-round " onclick="window.location.href = 'Request.jsp';">
                        </div>
                        
                        <!--Button My Uploads-->
                        <div class="w3-col s2"> 
                            <input id="my-upload"type="submit" value="My Upload" class="w3-button w3-blue w3-round " onclick="window.location.href = 'MyUploadMateriKuliah.jsp';"><br/>
                        </div>
                        
                    </div>
                    
                    <!--Panel Opsi Prodi SI-->
                    <div id="panel-opsi-si">
                        
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
    <script>
        
        $(document).ready(function(){
            load_materi_kuliah();
        });
        
        /** Memuat Opsi Materi Kuliah Per Perguruan Tinggi(Kurikulum)*/
        var html_kurikulum = '';
        function load_materi_kuliah(){
            $.ajax({
                url:"GetKurikulum",
                method:"POST",
                data:{},
                dataType:"json",
                success:function(data){
                    if(data.kurikulum.length){
                        data.kurikulum.forEach(function(item){
                            html_kurikulum += "<div class=\"div-opsi-si\">"+
                                "<button class=\"opsi-si\" onclick=\"window.location.href=\'AllMataKuliah.jsp?id-kurikulum="+item.idKurikulum+"\'\"><img src=\"apps-img/folder.png\"></button>"+
                                "<label>"+item.pt+"</label></div>";
                        });
                    }
                    
                    $('#panel-opsi-si').html(html_kurikulum);
                }
            });
        }
    </script>
    <script type='text/javascript'>
        
        //Get the modal
        var modal = document.getElementById("myModal");
        
        // Get the button that opens the modal
        var btn = document.getElementById("button-search");
        
        //Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];
        
        //When the user clicks the button, open the modal
        btn.onclick = function(){
            var query_search = $('#search-input').val();
            
            if(query_search !== ""){
                $.ajax({
                    url:"SearchMateriKuliah",
                    method:"POST",
                    data:{query_search: query_search},
                    dataType:"json",
                    success:function(data){
                        var html_result = "";
                        if(data.result.length){
                            data.result.forEach(function(item){
                                html_result += "<li id=\'li-result\'><a href=\'SatuMateriKuliah.jsp?id-materi="+item.idMateri+"\'><strong>"+item.judulMateri+"</strong></a></li>"
                            });
                        }else{
                            html_result += "<li id=\'li-result\'><a>No Result Found</a></li>";
                        }
                        $('#ul-result').html(html_result);
                    }
                });
            } else{
                $('#ul-result').html("<li id=\'li-result\'><a>No Result Found</a></li>");
            }
            
            modal.style.display = "block";
        }
        
        //When the user clicks on <span> (x), close the modal
        span.onclick = function(){
            modal.style.display = "none";
        }
        
        //When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event){
            if(event.target === modal){
                modal.style.display = "none";
            }
        }
    </script>
</html>
