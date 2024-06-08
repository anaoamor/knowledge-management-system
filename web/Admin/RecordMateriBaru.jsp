<%-- 
    Document   : RecordMateriBaru
    Created on : Sep 18, 2019, 12:22:00 PM
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
<%! String idMateri; %>
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
            #nav-samping{
                height: 500px;
            }
            #label-materi{
                 position: relative;
                margin-top: 30px;
                margin-left: 100px;
                margin-bottom: 30px;
                font-size: 20pt;
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
            .div-ok{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
                margin-top: 50px;
                padding-left: 230px;
                padding-right: 230px;
            }.button-form{
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
                    <!--LABEL MATERI BARU-->
                    <label id="label-materi">Materi Kuliah Baru</label>
                    
                    <!--FORM DESKRIPSI MATERI KULIAH-->
                    <% out.print("<form id=\"form-materi-baru\" method=\"POST\" action=\"../VerifikasiMateriBaru?id-materi="+idMateri+"\">"); %> 
                        <div>
                            <label class="label-form">Mata Kuliah</label>
                            <input id="nama-matkul" class="input-form"  name="matkul" type="text" ><br/>
                        </div>
                        <div>
                            <label class="label-form">Judul Materi</label>
                            <input id="nama-materi" class="input-form" name="materi" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Deskripsi</label>
                            <input id="deskripsi" class="textarea-form" name="deskripsi" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Upload By</label>
                            <input id="upload-by" class="input-form" name="upload-by" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Tanggal</label>
                           <input id="tgl" class="input-form" name="tgl" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">File Author</label>
                            <input id="file-author" class="input-form" name="file-author" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Alamat</label>
                            <div id="panel-file">
                                <a id="a-file" download><img id="img-tipe-file"></a>
                                <span id="icon-download" class="glyphicon glyphicon-download" style="font-size:18px;"></span>
                                <label class="label-nama-file"></label>
                            </div>
                        </div>
                        
                    </form>
                    
                    <!--PANEL OK-->
                    <div class="div-ok">
                        <div class="div-button">
                            <input id="button-ok" type="submit" value="OK" onclick="window.location='MateriKuliahBaru.jsp'" class="w3-button w3-round w3-blue button-form">
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
            load_materi_kuliah('<% out.print(idMateri); %>');
            
        });
        
        /** Memuat Deskripsi Materi Baru*/
        function load_materi_kuliah(kode = ''){
            $.ajax({
                url:"../GetMateriBaru",
                method:"POST",
                data:{kode: kode},
                dataType:"json",
                success:function(data){
                    $('.input-form').attr("readonly", "readonly");
                    $('.textarea-form').attr("readonly", "readonly");

                    $('#nama-matkul').val(data.namaMatkul);
                    $('#nama-materi').val(data.namaMateri);
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

                }
            });
        }
          
    </script>
</html>