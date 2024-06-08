<%-- 
    Document   : UserManagement
    Created on : Sep 17, 2019, 6:31:45 AM
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
            #nav-samping{
                height: 500px;
            }
            #label-user{
                position: relative;
                margin-top: 30px;
                margin-left: 114px;
                margin-bottom: 30px;
                font-size: 15pt;
            }
            #ul-user{
                list-style-type: none;
                margin-left: 114px;
                margin-right: 114px;
            }
            .li-user{
                border-color: transparent transparent transparent transparent;
                margin-bottom: 20px;
                height: 20px;
            }
            .li-user:hover{
                background-color: #555;
                color: white;
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
                        <a href="PerguruanTinggi.jsp">Perguruan Tinggi</a>
                    </li>
                    <li>
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    
                    <label id="label-user">User</label>
                    
                    <ul id="ul-user">
                        <%
                            Connection koneksi = Koneksi.getKoneksi();
                            PreparedStatement prepare;
                            String sql1 = "SELECT tbl_kaprodi_si.col_nip FROM tbl_kaprodi_si "+
                                    "INNER JOIN tbl_prodi_si ON (tbl_prodi_si.col_nip = "+
                                    "tbl_kaprodi_si.col_nip) INNER JOIN tbl_fakultas ON "+
                                    "(tbl_fakultas.col_id_fakultas = tbl_prodi_si.col_id_fakultas) "+
                                    "INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_pt) "+
                                    "INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = tbl_pt.col_id_pt) "+
                                    "WHERE tbl_admin.col_nip = ?";
                            prepare = koneksi.prepareStatement(sql1);
                            prepare.setString(1, idUser);
                            ResultSet rs1 = prepare.executeQuery();
                            while(rs1.next()){
                                out.println("<li class=\"li-user\"><a href=\"KaprodiSI.jsp?nip="+rs1.getString("col_nip")+"&tipe-user=2\">Kaprodi SI</a></li>");
                            }
                            
                            String sql2 = "SELECT tbl_wadek_kemahasiswaan.col_nip FROM tbl_wadek_kemahasiswaan "+
                                    "INNER JOIN tbl_fakultas ON "+
                                    "(tbl_fakultas.col_id_fakultas = tbl_wadek_kemahasiswaan.col_id_fakultas) "+
                                    "INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_pt) "+
                                    "INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = tbl_pt.col_id_pt) "+
                                    "WHERE tbl_admin.col_nip = ?";
                            prepare = koneksi.prepareStatement(sql2);
                            prepare.setString(1, idUser);
                            ResultSet rs2 = prepare.executeQuery();
                            while(rs2.next()){
                                out.println("<li class=\"li-user\"><a href=\"WadekKemahasiswaan.jsp?nip="+rs2.getString("col_nip")+"&tipe-user=1\">Wadek Kemahasiswaan</a></li>");
                            }
                        %>
                    </ul>
                        
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
            fungsi();
        });
        
        /** DESKRIPSI*/
        var html = '';
        function fungsi(){
            $.ajax({
                url:"SERVLET",
                method:"POST",
                data:{},
                dataType:"json",
                success:function(data){
                   
                }
            });
        }
    </script>
</html>