<%-- 
    Document   : CreateMateriKuliah
    Created on : Sep 18, 2019, 12:38:00 AM
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
<%! String kodeMatkul;%>
<% kodeMatkul = request.getParameter("id-matkul"); %>
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
            #label-materi-kuliah{
                position: relative;
                margin-top: 10px;
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
            .textarea-form{
                position: relative;
                margin-left: 600px;
                margin: 10px;
                margin-top: 20px;
                width: 495px;
                height: 200px;
                overflow: hidden;
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5);
                resize: none;
            }
            .input-form{
                position: relative;
                margin-left: 600px;
                margin: 10px;
                width: 495px;
                border: 1px solid;
                border-color: transparent transparent rgba(0, 0, 0, 0.5) transparent;
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
                        <a href="Mahasiswa.jsp">Mahasiswa</a>
                    </li>
                    <li>
                        <a href="UserManagement.jsp">User Management</a>
                    </li>
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
                        <a href="PerguruanTinggi.jsp">Perguruan Tinggi</a>
                    </li>
                    <li>
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    <div id="panel-subheader">
                        <label id="label-materi-kuliah">Materi Kuliah</label>
                    </div>
                    
                    <!--FORM CREATE MATERI KULIAH BARU-->
                    <form id="form-create-materi-kuliah" method="POST" action="../CreateMateriKuliahAdmin?id-matkul=<% out.print(kodeMatkul); %>" enctype="multipart/form-data" onsubmit="return validasi_input(this)">
                        <div class="div-form">
                             <label class="label-form">Mata Kuliah</label>
                             <% try{
                                Connection konek = Koneksi.getKoneksi();
                                PreparedStatement statement = konek.prepareStatement("SELECT col_nama_matkul FROM "
                                        + "tbl_matkul WHERE col_kode_matkul = \'"+kodeMatkul+"\'");
                                ResultSet rs = statement.executeQuery();

                                while(rs.next()){
                                    out.print("<input id=\"nama-mata-kuliah\" name=\"nama-mata-kuliah\" class=\"input-form\" type=\"text\" value=\""+rs.getString("col_nama_matkul")+"\" readonly><br/>");
                                }
                            }catch(SQLException ex){
                                out.print(ex.getMessage());
                            }
                            %>
                             
                         </div>
                        
                         <!--LABEL MATERI KULIAH-->
                         <div class="div-form">
                             <label class="label-form">Judul Materi</label>
                             <input id="nama-materi" name="nama-materi" class="input-form" type="text"><br/>
                         </div>
                         
                        <div class="div-form">
                            <label class="label-form">Deskripsi</label>
                            <textarea id="deskripsi" name="deskripsi" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">File</label>
                            <input id="file" name="file" type="file" accept=".docx, .pptx, .pdf, .wmv, .mpeg, .avi, .mp4, .flv, .wmp"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">File Author</label>
                            <input id="file-author" name="file-author" class="input-form" type="text"><br/>
                        </div>
                    </form>
                    
                    <!--BUTTON SUBMIT DAN CANCEL-->
                    <div class="div-submit-button">
                        <div class="div-button">
                            <input id="button-submit" type="submit" value="SUBMIT" form="form-create-materi-kuliah" class="w3-button w3-round w3-blue button-form">
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
                var konfirmasi = window.confirm("Batalkan pembuatan materi?");
                if(konfirmasi){
                    window.location = 'MataKuliah.jsp?id-matkul=<% out.print(kodeMatkul); %>';
                }
            });
        });
        
        /** Memvalidasi input*/ 
        function validasi_input(form){
            if($('#nama-materi').val() == ""){
                alert("Judul materi masih kosong!");
                $('#nama-materi').focus();
                return false;
            } else if($('#deskripsi').val() == ""){
                alert("Deskripsi  masih kosong!");
                $('#deskripsi').focus();
                return false;
            } else if($('#file').val() == ""){
                alert("File attachment masih kosong!");
                $('#file').focus();
                return false;
            }
               
            var file_author = $('#file-author').val();
            var nilai_file_author = '';
            if(file_author == ""){
                nilai_file_author = "-";
            }else{
                nilai_file_author = file_author;
            }
            
            var konfirmasi = window.confirm("Apakah data materi kuliah sudah benar?\n\n\n"+
                    "Mata Kuliah         : "+$('#nama-mata-kuliah').val()+"\n"+
                    "Judul Materi        : "+$('#nama-materi').val()+"\n"+
                    "Deskripsi            : \n\t"+$('#deskripsi').val()+"\n"+
                    "File                        : "+$('#file').val().substring(12)+"\n"+
                    "File Author           : "+nilai_file_author);
            if(konfirmasi){
                return true;
            }else{
                return false;
            }
            
        }
    </script>
</html>