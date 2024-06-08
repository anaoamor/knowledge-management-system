<%-- 
    Document   : Kurikulum
    Created on : Sep 11, 2019, 11:03:35 AM
    Author     : ASUS
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kmsclass.Koneksi"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (session.getAttribute("idUser") == null) {
        out.println("<script type=\"text/javascript\">alert(\'Anda harus log in terlebih dahulu\'); window.location = \'../LoginRegistrasi.jsp?menu=LOG IN\';</script>");
    }
%>
<%! String idUser;%>
<%
    if (session.getAttribute("idUser") != null) {
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
            #button-create{
                position: relative;
                margin: 10px;
                margin-top: 30px;
                margin-left: 813px;
                margin-bottom: 50px;
                width: 95px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity:80);
            }
             #ul-kurikulum{
                list-style-type: none;
                margin-left: 114px;
                margin-right: 114px;
            }
            .li-kurikulum{
                border-color: transparent transparent transparent transparent;
                margin-bottom: 20px;
                height: 20px;
            }
            .li-kurikulum:hover{
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
                            <% try {
                                    Connection konek = Koneksi.getKoneksi();
                                    PreparedStatement statement = konek.prepareStatement("SELECT col_user_image, col_jenis_kelamin, col_nama_kaprodi FROM "
                                            + "tbl_user INNER JOIN tbl_kaprodi_si ON (tbl_kaprodi_si.col_nip = tbl_user.col_id_user) "
                                            + "WHERE col_nip = \'" + idUser + "\'");
                                    ResultSet rs = statement.executeQuery();

                                    while (rs.next()) {
                                        if (rs.getString("col_user_image") == null) {
                                            if (rs.getString("col_jenis_kelamin").equals("L")) {
                                                out.print("<img src=\"../apps-img/boy.png\">");
                                            } else {
                                                out.print("<img src=\"../apps-img/woman.png\">");
                                            }
                                        } else {
                                            out.print("<img src=\"../" + rs.getString("col_user_image") + "\">");
                                        }
                                        out.print(rs.getString("col_nama_kaprodi"));
                                    }
                                } catch (SQLException ex) {
                                    out.print(ex.getMessage());
                                }
                            %>
                        </a></li>
                    <li>
                        <a href="MateriKuliah.jsp">Materi Kuliah</a>
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
                    
                    <!--Panel Submenu Kurikulum-->
                    <div class="w3-row-padding">
                        
                       <!--Space Kosong-->
                       <div class="w3-col s8"></div>
                        
                        <!--Button Create Kurikulum-->
                        <div class="w3-col s2">
                            <input id="button-create" type="submit" value="Create"  class="w3-button w3-blue w3-round" onclick="window.location.href = 'CreateKurikulum.jsp';">
                        </div>
                        
                    </div>
                    
                    <!--Panel Daftar Kurikulum-->
                    <div id="panel-kurikulum">
                        <ul id="ul-kurikulum">
                            <% 
                                Connection koneksi = Koneksi.getKoneksi();
                                PreparedStatement prepare;
                                String sql = "SELECT col_id_kurikulum, col_tahun FROM tbl_kurikulum";
                                prepare = koneksi.prepareStatement(sql);
                                ResultSet rs = prepare.executeQuery();
                                while(rs.next()){
                                    DateFormat dateFormat = new SimpleDateFormat("yyyy");
                                    String stringTahun = dateFormat.format(rs.getDate("col_tahun"));
                                    out.println("<li class=\'li-kurikulum\'><a href=\'RecordKurikulum.jsp?id-kurikulum="+rs.getString("col_id_kurikulum")+"\'>"+stringTahun+"</a>"+
                                            "</li>");
                                }
                            %>
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
        var ID_USER = '<% out.print(idUser);%>';
    </script>
    <script type="text/javascript" src="../jquery.js"></script>
    <script type="text/javascript" src="notifikasi.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            
        });

    </script>
</html>