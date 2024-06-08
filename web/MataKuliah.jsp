<%-- 
    Document   : MataKuliah
    Created on : Aug 4, 2019, 6:32:05 AM
    Author     : ASUS
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kmsclass.Koneksi"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
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
<%! String kodeMatkul;%>
<% kodeMatkul = request.getParameter("id-matkul"); %>
            
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KMS Mahasiswa SI</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
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
            #label-matkul{
                position: relative;
                margin-top: 30px;
                margin-left: 100px;
                font-size: 20pt;
            }
            #button-add{
                position: relative;
                /*margin-top: 20px;*/
                margin-left: 813px;
                margin-bottom: 30px;
                height: 40px;
                width: 95px;
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
            #div-textarea{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            .label-textarea{
                position: relative;
                margin: 10px;
                margin-left: 100px;
                width: 290px;
            }
            .textarea-form{
                position: relative;
                margin-left: 600px;
                margin: 10px;
                margin-top: 20px;
                width: 495px;
                height: 150px;
                overflow: hidden;
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5);
                resize: none;
            }
            #panel-daftar-materi{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            .div-materi-kuliah{
                margin-top: 50px;
                display: flex;
                flex-flow: column wrap;
                align-items: center;
            }
            .div-materi-kuliah:hover{
                color: gray;
                opacity: 0.7;
            }
            .opsi-materi-kuliah{
                position: relative;
                width: 150px;
                height: 150px;
                background-color: #fff;
            }
            .label-materi-kuliah{
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
                    <!--BUTTON HOME-->
                    <div class="w3-col s1 w3-padding-16">
                        <a href="HomeMahasiswa.jsp"><span id="icon-button" class="glyphicon glyphicon-home" style="font-size:18px;"></span></a>
                    </div>
                    
                    <!--BUTTON NOTIFIKASI-->
                    <div class="w3-col s1 w3-padding-16 notification ">
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
                    
                    <div id="subheader">
                        <!--LABEL MATA KULIAH-->
                        
                        <!--BUTTON ADD MATERI KULIAH SESUAI MATA KULIAH-->
                        
                    </div>
                    
                    <!--DESKRIPSI MATA KULIAH-->
                    <form id="form-matkul" method="POST" action="#">
                        <div id="div-textarea">
                            <label class="label-form">Kode Mata Kuliah</label>
                            <input id="kode_matkul" class="input-form" type="text"><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-form">Kelompok</label>
                            <input id="klmpk_matkul" class="input-form" type="text"><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-form">SKS</label>
                            <input id="sks" class="input-form" type="text"><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-textarea">Deskripsi</label>
                            <textarea id="deskripsi" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-textarea">Prasyarat</label>
                            <textarea id="prasyarat" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-textarea">Standar Kompetensi</label>
                            <textarea id="standar-kompetensi" class="textarea-form" type="text"></textarea><br/>
                        </div>
                    </form>
                    
                    <!--DAFTAR MATERI KULIAH-->
                    <div id="panel-daftar-materi">
                        
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
                
            /**Memuat profil mata kuliah dan materi terkait*/
            function load_mata_kuliah(kode = ''){
                $('.input-form').attr("readonly", "readonly");
                $('.textarea-form').attr("readonly", "readonly");

                $.ajax({
                    url:"GetMataKuliah",
                    method:"POST",
                    data:{kode: kode},
                    dataType:"json",
                    success:function(data){
                        $('#kode_matkul').val(data.kodeMatkul);
                        $('#klmpk_matkul').val(data.namaKlmpkMatkul);
                        $('#sks').val(data.sks);
                        if(data.deskripsi == null || data.deskripsi == ''){
                            $('#deskripsi').val("-");
                        }else{
                            $('#deskripsi').val(data.deskripsi);
                        }
                        if(data.prasyarat == null || data.prasyarat == ""){
                            $('#prasyarat').val("-");
                        }else{
                            $('#prasyarat').val(data.prasyarat);
                        }
                        if(data.standarKompetensi == null || data.standarKompetensi == ""){
                            $('#standar-kompetensi').val("-");
                        }else{
                            $('#standar-kompetensi').val(data.standarKompetensi);
                        }
                        
                        if(data.matkulProdiUser == "yes"){
                            $('#subheader').html("<label id=\"label-matkul\">"+data.namaMatkul+"</label>"+
                                "<button id=\"button-add\" class=\"w3-button w3-blue w3-round\" onclick=\"window.location.href=\'CreateMateriKuliah.jsp?id-matkul=<% out.print(kodeMatkul); %>\';\">"+
                                    "<label>Add</label>"+
                                "</button>");
                        }else{
                            $('#subheader').html("<label id=\"label-matkul\">"+data.namaMatkul+"</label>");
                        }
                        
                    }
                });
            }

            /**Memuat Daftar Materi Kuliah*/
            var html_all_materi_kuliah = "";
            function load_all_materi_kuliah(kode = ''){
                console.log(kode);
                $.ajax({
                    url:"GetAllMateriKuliah",
                    method:"POST",
                    data:{kode: kode},
                    dataType:"json",
                    success:function(data){
                        if(data.listMateri.length){
                            data.listMateri.forEach(function(item){
                                if(item.namaMateri.length > 15){
                                    var label_materi = item.namaMateri.substring(0, 15);
                                    html_all_materi_kuliah += "<div class=\"div-materi-kuliah\">"+
                                            "<button class=\"opsi-materi-kuliah\" onclick=\"window.location.href=\'SatuMateriKuliah.jsp?id-materi="+item.idMateriKuliah+"\'\"><img src=\"apps-img/folder.png\"></button>"+
                                            "<label>"+label_materi+"...</label></div>";
                                }else{
                                    html_all_materi_kuliah += "<div class=\"div-materi-kuliah\">"+
                                            "<button class=\"opsi-materi-kuliah\" onclick=\"window.location.href=\'SatuMateriKuliah.jsp?id-materi="+item.idMateriKuliah+"\'\"><img src=\"apps-img/folder.png\"></button>"+
                                            "<label>"+item.namaMateri+"</label></div>";
                                }
                            });
                        }
                        $('#panel-daftar-materi').html(html_all_materi_kuliah);
                    }
                });
            }
                
            load_mata_kuliah('<% out.print(kodeMatkul); %>');
            load_all_materi_kuliah('<% out.print(kodeMatkul); %>');
        });
        
    </script>
</html>
