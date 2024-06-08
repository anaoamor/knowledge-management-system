<%-- 
    Document   : RecordMateriKuliah
    Created on : Sep 11, 2019, 9:04:04 AM
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
<%! String idMateri;%>
<% idMateri = request.getParameter("id-materi"); %>
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
            .button-pengeditan{
                position: relative;
                margin: 10px;
                margin-top: 45px;
                margin-left: 810px;
                margin-bottom: 50px;
                width: 95px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity: 80);
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
            .label-file-form{
                position: relative;
                margin: 10px;
                margin-left: 100px;
                width: 200px;
            }
            #panel-file{
                display: flex;
                flex-flow: column wrap;
                align-items: center;
            }
            #panel-file:hover{
                color: gray;
                opacity: 0.7;
            }
            .label-nama-file{
                font-size: 12pt;
                margin-top: 5px;
            }
            #div-label-download{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            #jumlah-download{
                font-size: 7pt;
                margin-top: 0px;
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
                        <a href="MateriKuliah.jsp" class="current">Materi Kuliah</a>
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
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    <!--PANEL DELETE-->
                    <div id="submenu-materi-kuliah">
                        
                    </div>
                    
                    <!--DESKRIPSI MATERI KULIAH-->
                    <form id="form-materi-kuliah" method="POST" action="UpdateMateriKuliah?no=0" enctype="multipart/form-data" onsubmit="return validasi_input(this)">
                        
                         <div class="div-form">
                             <label class="label-form">ID</label>
                             <input id="id-materi" name="id-materi" class="input-form" type="text"><br/>
                         </div>
                        
                         <!--LABEL MATERI KULIAH-->
                         <div class="div-form">
                             <label class="label-form">Judul</label>
                             <input id="nama-materi" name="nama-materi" class="input-form" type="text"><br/>
                         </div>
                         
                        <div class="div-form">
                            <label class="label-form">Deskripsi</label>
                            <textarea id="deskripsi" name="deskripsi" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Upload By</label>
                            <input id="upload-by" name="upload-by" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Tanggal</label>
                            <input id="tgl" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">File Author</label>
                            <input id="file-author" name="file-author" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-file-form">File</label>
                            
                            <!--FILE MATERI-->
                            <div id="panel-file">
                                <a id="a-file" download><img id="img-tipe-file"></a>
                                <span id="icon-download" class="glyphicon glyphicon-download" style="font-size:18px;"></span>
                                <label class="label-nama-file"></label>
                                <h6 id="jumlah-download"></h6>
                            </div>
                            
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
            load_materi_kuliah('<% out.print(idMateri); %>');
            
            $('#a-file').click(function(){
                jumlah_download++;
                console.log(jumlah_download);
                update_jumlah_download('<% out.print(idMateri); %>', jumlah_download);
            });
        });
        
        /** Memuat deskripsi materi kuliah */
        var jumlah_download;
        function load_materi_kuliah(kode = ''){
            $.ajax({
                url:"../GetMateriKuliah",
                method:"POST",
                data:{kode: kode},
                dataType:"json",
                success:function(data){
                    $('#submenu-materi-kuliah').html("<input id=\"button-delete\" type=\"submit\" value=\"DELETE\" class=\"w3-button w3-round w3-blue button-pengeditan\"><br/>");

                    $('.input-form').attr("readonly", "readonly");
                    $('.textarea-form').attr("readonly", "readonly");

                    $('#nama-materi').val(data.namaMateri);
                    $('#id-materi').val(kode);
                    $('#deskripsi').val(data.deskripsi);
                    $('#upload-by').val(data.uploadBy);
                    $('#tgl').val(data.tglUpload);
                    if(data.authorFile == null || data.authorFile == ''){
                        $('#file-author').val("-");
                    }else{
                        $('#file-author').val(data.authorFile);
                    }
                    $('#a-file').attr("href", "../"+data.file);
                    var tipe_file = data.file.split('.').pop(); //img src="apps-img/pdf.png"
                    console.log(tipe_file);
                    if (tipe_file == "docx"){
                        $('#img-tipe-file').attr("src", "../apps-img/doc.png");
                    } else if(tipe_file == "pptx"){
                        $('#img-tipe-file').attr("src", "../apps-img/ppt.png");
                    } else if(tipe_file == "pdf"){
                        $('#img-tipe-file').attr("src", "../apps-img/pdf.png");
                    } else if(tipe_file == "wmv" || tipe_file == "mpeg" || tipe_file == "avi" || tipe_file == "mp4" || tipe_file == "flv" || tipe_file == "wmp"){
                        $('#img-tipe-file').attr("src", "../apps-img/video-file.png");
                    }
                    $('.label-nama-file').text(data.file.substring(14));

                    jumlah_download = data.jumlahDownload;
                    if(data.jumlahDownload <= 1){
                        $('#jumlah-download').text(data.jumlahDownload+" download");
                    } else{
                        $('#jumlah-download').text(data.jumlahDownload+" downloads");
                    }

                    $('#button-delete').click(function(){
                        var konfirmasi = window.confirm("Hapus materi ini?");
                        if(konfirmasi){
                            delete_materi_kuliah('<% out.print(idMateri); %>');
                        } else{

                        }
                    });

                }
            });
        }

        function delete_materi_kuliah(id = ''){
            $.ajax({
                url:"../DeleteMateriKuliah",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                    alert('Materi Kuliah berhasil dihapus!');
                    window.location = 'RecordMataKuliah.jsp?id-matkul='+data.kodeMatkul;
                }
            });
        }
        
        function update_jumlah_download(id = '', jumlah = ''){
            $.ajax({
                url:"../UpdateJumlahDownload",
                method:"POST",
                data:{id: id, jumlah: jumlah},
                success:function(data){
                    load_materi_kuliah('<% out.print(idMateri); %>');
                }
            });
        }
    </script>
</html>