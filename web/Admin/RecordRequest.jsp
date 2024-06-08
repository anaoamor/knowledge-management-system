<%-- 
    Document   : RecordRequest
    Created on : Sep 17, 2019, 1:29:21 PM
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
<%! String idRequest;%>
<% idRequest = request.getParameter("id-req");%>
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
            #container{
                min-height: 2000px;
            }
            #nav-samping{
                height: 500px;
            }
            
            #panel-subheader{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            #label-request{
                position: relative;
                margin: 10px;
                margin-top: 10px;
                margin-left: 100px;
                width: 467px;
                height: 40px;
                font-size: 15pt;
            }
            .button-pengeditan{
                position: relative;
                margin: 10px;
                margin-top: 45px;
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
            #div-border{
                position: relative;
                margin-top: 30px;
                margin-left: 70px;
                margin-right: 77px;
                border-top: 3px double;
            }
            .div-respon-user{
                position: relative;
                margin-left: 100px;
                margin-top: 20px;
                padding: 10px;
                width: 495px;
                border: 2px solid;
                border-color: transparent; /*#ccc;*/
                background-color: #e7e7e7;
            }
            .div-admin{
                position: relative;
                margin-left: 10px;
                margin-right: 10px;
                border-bottom: 3px double;
            }
            .label-admin{
                font-weight: bold;
            }
            .content-respon{
                margin-left: 10px;
                margin-right: 10px;
            }
            .waktu{
                font-size: 7pt;
                margin-left: 375px;
            }
            .div-respon-admin{
                position: relative;
                margin-left: 409px;
                margin-top: 20px;
                padding: 10px;
                width: 495px;
                border: 2px solid;
                border-color: transparent;
                background-color: #ccc;
            }
            .div-komentar{
                
            }
            #textarea-komentar{
                position: relative;
                margin-left: 100px;
                margin-top: 80px;
                margin-right: 20px;
                padding: 10px;
                width: 675px;
                border: 1px solid;
                border-color: #0066cc; 
                background-color: #f0f5f5;
                resize: none;
            }
            #button-komentar{
                position: relative;
                margin-top: -70px;
                
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
                        <label id="label-request">Request</label>

                        <!--PANEL LABEL, OPSI PENGEDITAN-->
                        <div id="submenu-request">
                            <input id="button-close" type="submit" value="CLOSE" class="w3-button w3-round w3-blue button-pengeditan" \>
                            <input id="button-delete" type="submit" value="DELETE" class="w3-button w3-round w3-blue button-pengeditan" \>
                        </div>
                    </div>
                    
                    <!--DESKRIPSI REQUEST MATERI KULIAH-->
                    <form id="form-request" method="POST" action="#" onsubmit="return validasi_input(this)">
                        
                        <div class="div-form">
                             <label class="label-form">ID</label>
                             <input id="id-request" name="id-request" class="input-form" type="text"><br/>
                         </div>
                        
                         <div class="div-form">
                             <label class="label-form">Topik</label>
                             <input id="topik" name="topik" class="input-form" type="text"><br/>
                         </div>
                         
                        <div class="div-form">
                            <label class="label-form">Deskripsi</label>
                            <textarea id="deskripsi" name="deskripsi" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Tanggal</label>
                            <input id="tgl-req" name="tgl-req" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Waktu</label>
                            <input id="waktu" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Status</label>
                            <input id="status" name="status" class="input-form" type="text"><br/>
                        </div>
                    </form>
                    
                    <div id="div-border"></div>
                    
                    <!--PANEL RESPON-->
                    <div id="panel-respon">
                        <!--RESPON ADMIN-->
                        
                        <!--RESPON USER-->
                        
                    </div>
                    
                    <!--PANEL KOMENTAR-->
                    <div>
                        <form id="form-komentar" method="POST" action="../AddResponRequestAdmin?id-request=<% out.print(idRequest); %>" onsubmit="return validasi_respon(this)">
                            
                        </form>
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
            
            /** Memuat deskripsi Request Materi Kuliah*/
            function load_req_materi_kuliah(id = ''){
                $.ajax({
                    url:"../GetRequestMateriKuliah",
                    method:"POST",
                    data:{id: id},
                    dataType:"json", 
                    success:function(data){
                        
                        if(data.status == "Menunggu" || data.status == "Progress"){
                            $('#form-komentar').html("<textarea id=\"textarea-komentar\" name=\"komentar\" placeholder=\"Komentar..\"></textarea>"+
                            "<input id=\"button-komentar\" type=\"submit\" value=\"COMMENT\" form=\"form-komentar\" class=\"w3-button w3-round w3-blue\">");
                            
                            $('#textarea-komentar').focus();
                        }else{
                            $('#button-close').attr("disabled", "disabled");
                        }
                        $('.input-form').attr("readonly", "readonly");
                        $('.textarea-form').attr("readonly", "readonly");
                        
                        $('#id-request').val(data.idReq);
                        $('#topik').val(data.topik);
                        $('#deskripsi').val(data.deskripsi);
                        $('#tgl-req').val(data.tglReq);
                        $('#waktu').val(data.waktu);
                        $('#status').val(data.status);
                        
                        $("#button-close").click(function(){
                            var konfirmasi = window.confirm("Apakah permintaan materi telah selesai dan "+
                                    "tutup permintaan?");
                        if(konfirmasi){
                            close_request('<% out.print(idRequest); %>');
                        }
                        });
                        
                        $("#button-delete").click(function(){
                            var konfirmasi = window.confirm("Hapus request materi kuliah?");
                            if(konfirmasi){
                                delete_request_materi_kuliah('<% out.print(idRequest);%>');
                            }
                        });
                    }
                });
            }
            
            /**Memuat Semua Respon Dari Request Materi Kuliah*/
            var html_all_respon = "";
            function load_respon_req_materi_kuliah(id = ''){
                $.ajax({
                    url:"../GetResponRequestMateriKuliah",
                    method:"POST",
                    data:{id: id},
                    dataType:"json", 
                    success:function(data){
                        if(data.listRespon.length){
                            data.listRespon.forEach(function(item){
                                if(item.nip !== null){
                                    html_all_respon += "<div class=\"div-respon-admin\">"+
                                        "<div class=\"div-admin\">"+
                                            "<h4 class=\"label-admin\">Admin :</h4>"+
                                        "</div>"+
                                        "<p class=\"content-respon\">"+item.detailRespon+"</p>"+
                                        "<h6 class=\"waktu\">"+item.tglRespon+", "+item.waktu+"</h6>"+
                                    "</div>";
                                }else{
                                    html_all_respon += "<div class=\"div-respon-user\">"+
                                        "<div class=\"div-admin\">"+
                                            "<h4 class=\"label-admin\">"+item.mahasiswaReq+" :</h4>"+
                                        "</div>"+
                                        "<p class=\"content-respon\">"+item.detailRespon+"</p>"+
                                        "<h6 class=\"waktu\">"+item.tglRespon+", "+item.waktu+"</h6>"+
                                        "</div>";
                                }
                            });
                        }
                        $('#panel-respon').html(html_all_respon);
                    }
                });
            }
            
            /*Menghapus Request*/
            function delete_request_materi_kuliah(id = ''){
                $.ajax({
                    url:"../DeleteRequestMateriKuliah",
                    method:"POST",
                    data:{id: id},
                    dataType:"json",
                    success:function(data){
                        alert('Request berhasil dihapus!');
                        window.location = 'Request.jsp';
                    }
                });
            }
            
            
            load_req_materi_kuliah('<% out.print(idRequest); %>');
            load_respon_req_materi_kuliah('<% out.print(idRequest); %>');
        });
        
        /** Memvalidasi Input Respon */ 
        function validasi_respon(form){
            if($('#textarea-komentar').val() == ""){
                alert("Komentar masih kosong!");
                $('#textarea-komentar').focus();
                return false;
            } 
            
            return true;
        }
        
        /** Menutup Request Materi*/
        function close_request(id = ''){
            $.ajax({
                url:"../CloseRequest",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   window.location = 'RecordRequest.jsp?id-req=<% out.print(idRequest); %>';
                }
            });
        }
        
    </script>
</html>