<%-- 
    Document   : RecordProdiSI
    Created on : Aug 27, 2019, 10:13:36 AM
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
<%! String idProdi;%>
<% idProdi = request.getParameter("id-prodi");%>
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
            #label-prodi{
                position: relative;
                margin-top: 30px;
                margin-left: 100px;
                margin-bottom: 50px;
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
                height: 100px;
                overflow: hidden;
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5);
                resize: none;
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
                        <a href="SistemInformasi.jsp" class="current">Sistem Informasi</a>
                    </li>
                    <li>
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    
                    <div id="subheader">
                        <!--LABEL PRODI SI-->
                        <label id="label-prodi"></label>
                    </div>
                    
                    <!--DESKRIPSI PRODI SI-->
                    <form id="form-prodi" method="POST" >
                        <div class="div-form">
                             <label class="label-form">Kepala Prodi</label>
                             <input id="kaprodi" name="kaprodi" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                             <label class="label-form">Tahun Berdiri</label>
                             <input id="tahun" name="tahun" class="input-form" type="text"><br/>
                        </div>
                        
                        <div class="div-form">
                            <label class="label-form">Alamat</label>
                            <textarea id="alamat" name="alamat" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">No Telepon</label>
                            <input id="no-telepon" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">E-Mail</label>
                            <input id="email" name="email" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                             <label class="label-form">Durasi Program</label>
                             <input id="durasi" name="durasi" class="input-form" type="text"><br/>
                        </div>
                        
                        <div class="div-form">
                            <label class="label-form">Jumlah SKS</label>
                            <input id="jmlh-sks" name="jmlh-sks" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Semester Maksimal</label>
                            <input id="max-sem" name="max-sem" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Kurikulum</label>
                            <input id="kurikulum" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Fakultas</label>
                            <input id="fakultas" name="fakultas" class="input-form" type="text"><br/>
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
        var ID_USER = <% out.println(idUser); %>
    </script>
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="notifikasi.js"></script>
    <script type="text/javascript">
        
        $(document).ready(function(){
            load_prodi_si('<% out.print(idProdi); %>');
        });
        
        /** MEMUAT DESKRIPSI PRODI SI*/
        function load_prodi_si(id = ''){
            $.ajax({
                url:"GetProdi",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   $('.input-form').attr("readonly", "readonly");
                   $('#textarea-form').attr("readonly", "readonly");
                   $('#label-prodi').text("Prodi Sistem Informasi "+data.pt);
                   if(data.kaprodiSI == null){
                       $('#kaprodi').val("-");
                   }else{
                        $('#kaprodi').val(data.kaprodiSI);
                    }
                    if(data.tahunBerdiri == null){
                       $('#tahun').val("-");
                   }else{
                        $('#tahun').val(data.tahunBerdiri);
                    }
                    if(data.alamat == null){
                       $('#alamat').val("-");
                   }else{
                        $('#alamat').val(data.alamat);
                    }
                    if(data.noTelepon == null){
                       $('#no-telepon').val("-");
                   }else{
                        $('#no-telepon').val(data.noTelepon);
                    }
                   if(data.emailProdi == null){
                       $('#email').val("-");
                   }else{
                        $('#email').val(data.emailProdi);
                    }
                    if(data.durasiProgram == null){
                       $('#durasi').val("-");
                   }else{
                        $('#durasi').val(data.durasiProgram+" Tahun");
                    }
                    if(data.jumlahSKS == null){
                       $('#jmlh-sks').val("-");
                   }else{
                        $('#jmlh-sks').val(data.jumlahSKS);
                    }
                    if(data.semMaksimal == null){
                       $('#max-sem').val("-");
                   }else{
                        $('#max-sem').val(data.semMaksimal);
                    }
                    if(data.kurikulum == null){
                       $('#kurikulum').val("-");
                   }else{
                        $('#kurikulum').val(data.kurikulum);
                    }
                    if(data.fakultas == null){
                       $('#fakultas').val("-");
                   }else{
                        $('#fakultas').val(data.fakultas);
                    }
                   
                }
            });
        }
    </script>
</html>