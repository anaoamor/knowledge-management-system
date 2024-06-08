<%-- 
    Document   : Home
    Created on : Aug 28, 2019, 4:26:56 PM
    Author     : ASUS
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kmsclass.Koneksi"%>
<%@page import="java.sql.SQLException"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" type="text/css" href="../w3.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style type="text/css">
            .pembungkus{
                position: relative;
            }
            .form-inline{
                display:flex;
                flex-flow: row wrap;
                align-items: center;
                margin-top: 20px;
            }
            .notification{
                text-decoration: none;
                position: relative;
                display: inline-block;
                border-radius: 2px;
                margin-top: 13px;
            }
            #badge{
                position: absolute;
                top: -0px;
                right: -0px;
            }
            img{
                position: relative;
            }
            span{
                font-size: 12px;
                align-content: center;
            }
            p{
                position:absolute;
                left: 40px;
                top: 150px;
                /**opacity: 0.7;*/
                filter: alpha(opacity=70);/* For IE8 and earlier*/
            }
            h2{
                margin-bottom:40px;
            }
            .layer-transparent{
                opacity: 0.9;
                filter: alpha(opacity=90);/* For IE8 and earlier*/
                position: fixed;
                left: 300px;
                right: 300px;
                top: 150px;
                
            }
            input[type=text]{
                border: 2px solid transparent;
                border-color: transparent transparent rgba(0, 0, 0, 0.5) transparent;
                background: rgba(255,255,255,.1);
            }
            input[type=submit]{
                margin-top: 20px;
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
            
            /** Dari w3.schools-Fix-Full Height Side Nav*/
            #nav-samping {
                list-style-type: none;
                margin: 0;
                padding: 0;
                width: 15%;
                background-color: #f1f1f1;
                opacity: 0.85;
                filter: alpha(opacity=85);/* For IE8 and earlier*/
                position: absolute;
                left: 0px;
                top: 0px;
                height: 100%;
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
              background-color: #4CAF50;
              color: white;
            }
            li a.current{
                background: #ff3300;
                color: white;
                opacity: 0.5;
            }

            li a:hover:not(.active) {
              background-color: #555;
              color: white;
            }
        </style>
        <title>KMS Mahasiswa SI</title>
    </head>
    
    <body>
        <div class="w3-container w3-row w3-white" >
            
            <div class="w3-container w3-white w3-half">
                <h1>KMS Mahasiswa SI</h1>
            </div>
            
            <div class="w3-container w3-white w3-half w3-row-padding">
                <!-- Button Search-->
                <div class="w3-col s8 w3-padding-16 form-inline">
                    <form  id="search-form" method="POST">
                        <input id="search-input" type="text" name="user-search" placeholder="People">
                        
                    </form>
                    <input id="button-search" type="image" src="../apps-img/browser.png" alt="Submit">
                
                </div>
                <!-- Modal User Search Result -->
                <div id="myModal" class="modal">

                    <!-- Modal Content -->
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h4>Search Result</h4><br>
                        <ul id="ul-result"></ul>

                    </div>

                </div>

                <!-- Notification badge-->
                <div class="w3-col s1 w3-padding-16 notification">
                
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="Notifikasi.jsp" class="dropdown-toggle " data-toggle="dropdown"><span id="badge" class="label label-pill label-danger count" style="border-radius:10px;"></span> <span class="glyphicon glyphicon-bell" style="font-size:18px;"></span></a>
                            
                        </li>
                    </ul>
                </div>
                
                
                <!-- Button Log Out -->
                <div class="w3-col s3 w3-padding-16">
                    <form action="../Logout" method="post">
                        <input type="submit" name="menu" value="LOG OUT" class="w3-button w3-round w3-black w3-right" >
                    </form>
                </div>
                
            </div>
            
        </div>
        
        <div class="pembungkus">
            
            <img src="../book.jpg" alt="BOOK" style="width:device-width; height: 934px">
            
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
            
        </div>
        
        <div class="w3-container w3-white w3-center">
            <footer >
                <h6>© 2019 AMO. All rights reserved</h6>
            </footer>
        </div>
        
        <script>
            var ID_USER = '<% out.print(idUser); %>';
        </script>
        <script type="text/javascript" src="../jquery.js"></script>
        <script type="text/javascript" src="notifikasi.js"></script>
        <script type="text/javascript">
            
            // Get the modal
        var modal = document.getElementById("myModal");

        // Get the button that opens the modal
        var btn = document.getElementById("button-search");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        
        // When the user clicks the button, open the modal 
        btn.onclick = function() {
            var query_search = $('#search-input').val();
            
            if(query_search !== ""){
                $.ajax({
                   url:"../SearchUser",
                   method:"POST",
                   data:{query_search:query_search},
                   dataType:"json",
                   success:function(data){
                       var html_result = "";
                       if(data.resultQuery.length){
                            data.resultQuery.forEach(function(item) {
                                var ref = "";
                                var tipe = "";
                                
                                if(item.id == <% out.print(idUser); %>){
                                    html_result += "<li id=\"li-result\" >"
                                        + "<a href=\"User.jsp\">"
                                      + "<strong>" + item.nama
                                      + "</strong><br/>"
                                      + "</a>"
                                      + "</li>";
                                } else{
                                    if(item.tipe == "mahasiswa"){
                                        ref = "ViewMahasiswa.jsp";
                                        tipe = "0";
                                    } else if(item.tipe == "kaprodiSi"){
                                        ref = "ViewStaff.jsp";
                                        tipe = "2";
                                    } else if(item.tipe == "wadek"){
                                        ref = "ViewStaff.jsp";
                                        tipe = "1";
                                    }else if(item.tipe == "admin"){
                                        ref = "ViewStaff.jsp";
                                        tipe = "3";
                                    }else{
                                        ref = ""
                                    }
                                    html_result += "<li id=\"li-result\" >"
                                        + "<a href=\""+ref+"?user_id="+item.id+"&tipe-search="+tipe+"\">"
                                      + "<strong>" + item.nama
                                      + "</strong><br/>"
                                      + "</a>"
                                      + "</li>";
                                }
                              
                            });
                        } else {
                            html_result += "<li id=\"li-result\"><a>No Result Found</a></li>";
                            
                        }
                        $('#ul-result').html(html_result);
                   }
                });
            } else{
                $('#ul-result').html("<li id=\"li-result\">No Result Found</li>");
            }
            
            modal.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
          modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
          if (event.target === modal) {
            modal.style.display = "none";
          }
        }
       
        </script>
    </body>
</html>
</html>