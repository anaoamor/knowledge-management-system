<%-- 
    Document   : RecordKurikulum
    Created on : Aug 27, 2019, 5:47:44 PM
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
<%! String idKurikulum;%>
<% idKurikulum = request.getParameter("id-kurikulum");%>
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
                min-height: 3500px;
            }
            #label-kurikulum{
                position: relative;
                margin-top: 30px;
                margin-left: 100px;
                margin-bottom: 50px;
                font-size: 15pt;
            }
            #form-kurikulum{
                margin-bottom: 50px;
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
            #ul-klmpk-mata-kuliah {
                list-style-type: none;
                margin-left: 103px;
                margin-right: 103px;
            }
            #tipe-klmpk {
                border: 2px solid;
            }
            .load-mata-kuliah{
               text-decoration: none; 
               font-size: 11pt;
               font-weight: bold;
            }
            .ul-mata-kuliah{
                list-style-type: none;
                margin-left: 20px;
                margin-right: 20px;
            }
            #tipe-mata-kuliah {
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) transparent transparent transparent;
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
                        <a href="Kurikulum.jsp" class="current">Kurikulum</a>
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
                        <!--LABEL KURIKULUM-->
                        <label id="label-kurikulum"></label>
                    </div>
                    
                    <!--DESKRIPSI DAN DAFTAR MATA KULIAH KURIKULUM-->
                    <form id="form-kurikulum" method="POST" >
                        <div class="div-form">
                             <label class="label-form">Jumlah SKS</label>
                             <input id="jmlh-sks" name="jmlh-sks" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                             <label class="label-form">Jumlah Semester</label>
                             <input id="jmlh-semester" name="jmlh-semester" class="input-form" type="text"><br/>
                        </div>
                    </form>
                    
                    <ul id="ul-klmpk-mata-kuliah">
                        <li id="tipe-klmpk">
                            <a class="load-mata-kuliah">Mata Kuliah Universitas</a>
                            <ul id="ul-mata-kuliah" ></ul>
                        </li>
                        <li id="tipe-klmpk">
                            <a id="a-nonlink" class="load-mata-kuliah">Mata Kuliah Prodi</a>
                            <ul id="ul-mata-kuliah" ></ul>
                        </li>
                        <li id="tipe-klmpk">
                            <a id="a-nonlink" class="load-mata-kuliah">Mata Kuliah Pilihan</a>
                            <ul id="ul-mata-kuliah" ></ul>
                        </li>
                    </ul>
                    
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
            load_klmpk_mata_kuliah('<% out.print(idKurikulum); %>');
        });
        
        /** Memuat Daftar Kelompok Mata Kuliah*/
        var html_klmpk_mata_kuliah = '';
        function load_klmpk_mata_kuliah(id = ''){
            $.ajax({
                url:"GetAllKelompokMataKuliah",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                    $('.input-form').attr("readonly", "readonly");
                    $('#label-kurikulum').text("Kurikulum "+data.tahunKurikulum);
                    $('#jmlh-sks').val(+data.jumlahSKS);
                    $('#jmlh-semester').val(data.jumlahSemester);
                    
                   if(data.listKelompokMatkul.length){
                       data.listKelompokMatkul.forEach(function(item){
                           
                            var html_mata_kuliah = "";
                            if(item.daftarMatkul.length){
                                item.daftarMatkul.forEach(function(item){
                                    html_mata_kuliah += "<li id=\"tipe-mata-kuliah\">"+
                                            "<a href=\'RecordMataKuliah.jsp?id-matkul="+item.kodeMatkul+"\'>"+item.namaMatkul+"</a></li>";
                                });
                                
                            }
                           html_klmpk_mata_kuliah += "<li id=\"tipe-klmpk\">"+
                            "<a id=\'"+item.idKelompokMatkul+"\' value=\'"+item.idKelompokMatkul+"\' class=\"load-mata-kuliah\">"+item.namaKelompokMatkul+"</a>"+
                            "<ul class=\'ul-mata-kuliah\' id=\"ul-mata-kuliah\" >"+html_mata_kuliah+"</ul>"+
                        "</li>";
                
                       });
                   }
                   $('#ul-klmpk-mata-kuliah').html(html_klmpk_mata_kuliah);
                }
            });
        }
    </script>
</html>