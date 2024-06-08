<%-- 
    Document   : Messaging
    Created on : Sep 6, 2019, 3:43:26 PM
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
                overflow: auto;
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
            #create-message{
                position: relative;
                margin: 10px;
                margin-top: 35px;
                margin-bottom: 50px;
                width: 125px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity:80);
            }
            #delete-message{
                position: relative;
                margin: 10px;
                margin-top: 35px;
                margin-bottom: 50px;
                width: 125px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity:80);
            }
            #ul-message{
                list-style-type: none;
                margin-left: 103px;
                margin-right: 103px;
            }
            .li-message{
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) transparent transparent transparent;
                height: 90px;
            }
            .li-message:hover{
                background-color: #555;
                color: white;
            }
            #div-deskripsi-message{
                height: 67px;
            }
            #div-checkbox{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
                height: 67px;
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
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    
                    <!-- Panel Submenu Messaging -->
                    <div class="w3-row-padding">
                        
                       <!--Space Kosong-->
                        <div class="w3-col s9"></div>
                        
                        <!--Form Pencarian Message-->
                        <div class="w3-col s3 form-inline">
                            <form id="search-form" method="POST">
                                <input id="search-input" type="text" name="search-message" placeholder="Name">
                            </form>
                            <input id="button-search" type="image" src="../apps-img/browser.png" alt="Submit">
                        </div>
                        
                        <!-- Modal Search Result Messaging-->
                        <div id="myModal" class="modal">
                            
                            <!-- Modal Content-->
                            <div class="modal-content">
                                <span class="close">&times;</span>
                                <h4>Search Result</h4><br>
                                <ul id="ul-result"></ul>
                            </div>
                            
                        </div>
                        
                        <!--Button Create Message-->
                        <div class="w3-col s2">
                            <input id="create-message" type="submit" value="Create"  class="w3-button w3-blue w3-round ">
                        </div>
                        
                        <!--Button Delete-->
                        <div id="div-btn-delete-message" class="w3-col s2"> 
                            
                        </div> 
                        
                    </div>
                    
                    <!-- Panel Opsi Messaging -->
                    <div id="panel-messaging">
                        <ul id="ul-message">

                        </ul>
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
            /**Memuat daftar message*/
            var html_message = '';
            function load_list_message(id = ''){
                console.log(id);
                $.ajax({
                    url:"../GetAllMessage",
                    method:"POST",
                    data:{id: id},
                    dataType:"json",
                    success:function(data){
                        if(data.daftarMessage.length){
                            data.daftarMessage.forEach(function(item){
                                var detail = "";
                                if(item.detailMessage.length > 135){
                                    detail = item.detailMessage.substring(0, 135)+" . . .";
                                } else{
                                    detail = item.detailMessage;
                                }
                                
                                html_message += "<li class=\"li-message w3-row-padding\">"+
                                                    "<div id=\"div-deskripsi-message\" class=\"w3-col s11\">"+
                                                        "<a href=\'RecordMessage.jsp?id-responden="+item.idResponden+"&id-level="+item.idLevel+"\'>"+
                                                            "<strong>"+item.respondenMessage+"</strong><br>"+
                                                            "<small>"+detail+"<br>"+
                                                            "<small>"+item.datetime+"</small></small>"+
                                                        "</a>"+
                                                    "</div>"+
                                                    "<div id=\"div-checkbox\" class=\"w3-col s1\">"+
                                                        "<input class=\"checkbox\" type=\"checkbox\" name=\"id-responden\" value=\""+item.idResponden+"\" hidden>"+
                                                    "</div>"+
                                                "</li>";
                            });
                        }else{
                            
                        }
                        
                        $('#ul-message').html(html_message);
                        
                        $('.li-message').dblclick(function(){
                            $('.checkbox').toggle();
                            $('.checkbox').removeAttr("checked");
                        });
                        
                        $('#div-btn-delete-message').html("<input id=\"delete-message\" type=\"submit\" value=\"Delete\" class=\"w3-button w3-blue w3-round \"><br/>");
                        
                        $('#delete-message').click(function(){
                            var id_delete_message = new Array();
                            
                            var chks = document.getElementsByClassName("checkbox");
                            for(var i = 0; i < chks.length; i++){
                                if(chks[i].checked){
                                    id_delete_message.push(chks[i].value);
                                }
                            }
                            
                            if(id_delete_message.length == 0){
                                alert('Pesan yang akan dihapus belum dipilih!');
                                $('.checkbox').show();
                            }else{
                                var konfirmasi = window.confirm("Apakah kamu yakin akan menghapus pesan?");
                                if(konfirmasi){
                                    $.ajax({
                                        url:"../DeleteMessage",
                                        method:"POST",
                                        data:{id_delete_message: id_delete_message},
                                        dataType:"json",
                                        success:function(data){
                                            alert('Pesan berhasil dihapus!');
                                            window.location = 'Messaging.jsp';
                                        }
                                    });
                                }
                            }
                        });
                        
                    }
                });
            }
            
            load_list_message('<% out.print(idUser); %>');
            
        });
        
    </script>
    <script type="text/javascript">
            
            // Get the modal
        var modal = document.getElementById("myModal");

        // Get the button that opens the modal
        var btn = document.getElementById("button-search");
        
        // Get the create button
        var btn_create = document.getElementById("create-message");

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
                                
                                if(item.id !== '<% out.print(idUser); %>'){
                                    
                                    if(item.tipe == "mahasiswa"){
                                        tipe = "0";
                                    } else if(item.tipe == "kaprodiSi"){
                                        tipe = "2";
                                    } else if(item.tipe == "wadek"){
                                        tipe = "1";
                                    }else if(item.tipe == "admin"){
                                        tipe = "3";
                                    }else{
                                        ref = ""
                                    }
                                    html_result += "<li id=\"li-result\" >"
                                        + "<a href=\'RecordMessage.jsp?id-responden="+item.id+"&id-level="+tipe+"\'>"
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

        // When the user click create button, open the modal to display all people than can to send message
        btn_create.onclick = function(){
            var query_search = "";
            
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

                            if(item.id !== '<% out.print(idUser); %>'){

                                if(item.tipe == "mahasiswa"){
                                    tipe = "0";
                                } else if(item.tipe == "kaprodiSi"){
                                    tipe = "2";
                                } else if(item.tipe == "wadek"){
                                    tipe = "1";
                                }else if(item.tipe == "admin"){
                                    tipe = "3";
                                }else{
                                    ref = ""
                                }
                                html_result += "<li id=\"li-result\" >"
                                    + "<a href=\'RecordMessage.jsp?id-responden="+item.id+"&id-level="+tipe+"\'>"
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
</html>