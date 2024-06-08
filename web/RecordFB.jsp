<%-- 
    Document   : RecordFB
    Created on : Aug 26, 2019, 4:11:57 PM
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
<%! String idFB;%>
<% idFB = request.getParameter("id-fb");%>
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
                min-height: 2000px;
            }
            #panel-subheader{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            #label-fb{
                position: relative;
                margin: 10px;
                margin-top: 10px;
                margin-left: 100px;
                width: 161px;
                height: 40px;
                font-size: 15pt;
            }
            #label-edit{
                position: relative;
                margin: 10px;
                margin-top: 10px;
                margin-left: 50px;
                width: 95px;
                height: 40px;
            }
            /*The switch - the box around the slider */
            .switch{
                position: relative;
                display: inline-block;
                width: 50px;
                height: 24px;
            }
            /* Hide default HTML checkbox*/
            .switch input{
                opacity: 0;
                width: 0;
                height: 0;
            }
            /*The slider*/
            .slider{
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                -webkit-transition: .4s;
            }
            .slider:before{
                position: absolute;
                content: "";
                height: 20px;
                width: 20px;
                left: 2px;
                bottom: 2px;
                background-color: white;
                -webkit-transition: .4s;
            }
            input:checked + .slider{
                background-color: #2196F3;
            }
            input:focus + .slider{
                box-shadow: 0 0 1px #2196F3;
            }
            input:checked + .slider:before{
                -webkit-transform: translateX(26px);
                -ms-transform: translateX(26px);
                transform: translateX(26px);
            }
            /* Rounded sliders*/
            .slider.round{
                border-radius: 34px;
            }
            .slider.round:before{
                border-radius: 50%;
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
            #div-border{
                position: relative;
                margin-top: 30px;
                margin-left: 70px;
                margin-right: 77px;
                border-top: 3px double;
            }
            .div-respon-admin{
                position: relative;
                margin-left: 100px;
                margin-top: 20px;
                padding: 10px;
                width: 495px;
                border: 2px solid;
                border-color: transparent; /*#ccc;*/
                background-color: #e7e7e7;
            }
            .div-respon-user{
                position: relative;
                margin-left: 409px;
                margin-top: 20px;
                padding: 10px;
                width: 495px;
                border: 2px solid;
                border-color: transparent;
                background-color: #ccc;
            }
            .div-responden{
                position: relative;
                margin-left: 10px;
                margin-right: 10px;
                border-bottom: 3px double;
            }
            .label-responden{
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
            #textarea-respon{
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
            #button-respon{
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
                        <a href="Feedback.jsp" class="current">Feedback</a>
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
                    <!--PANEL SUBHEADER DAN SUBMENU FEEDBACK-->
                    <div id="panel-subheader">
                        <label id="label-fb">Feedback</label>

                        <!--PANEL OPSI PENGEDITAN-->
                        <div id="submenu-fb">

                        </div>
                    </div>
                    
                    <!--DESKRIPSI FEEDBACK-->
                    <form id="form-fb" method="POST" action="UpdateFB?id-fb=<% out.print(idFB); %>" onsubmit="return validasi_input(this)">
                        
                        <div class="div-form">
                             <label class="label-form">Topik</label>
                             <input id="topik" name="topik" class="input-form" type="text"><br/>
                        </div>
                        
                        <div class="div-form">
                            <label class="label-form">Detail</label>
                            <textarea id="detail" name="detail" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Tanggal</label>
                            <input id="tgl-fb" name="tgl-fb" class="input-form" type="text"><br/>
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
                    
                    <!--PANEL SEMUA RESPON-->
                    <div id="panel-list-respon">
                        <!--RESPON ADMIN-->
                        <div class="div-respon-admin">
                            <div class="div-responden">
                                <h4 class="label-responden">Admin :</h4>
                            </div>
                            <p class="content-respon">Komentar..</p>
                            <h6 class="waktu">DD:MM:YYYY, hh:mm</h6>
                        </div>
                        
                        
                        <!--RESPON USER-->
                        <div class="div-respon-user">
                            <div class="div-responden">
                                <h4 class="label-responden">Me :</h4>
                            </div>
                            <p class="content-respon">Komentar..</p>
                            <h6 class="waktu">DD:MM:YYYY, hh:mm</h6>
                        </div>
                        
                    </div>
                    
                    <!--PANEL ADD RESPON-->
                    <div>
                        <form id="form-add-respon" method="POST" action="AddResponFB?id-fb=<% out.print(idFB); %>" onsubmit="return validasi_add_respon(this)">
                            
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
        var ID_USER = <% out.println(idUser); %>
    </script>
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="notifikasi.js"></script>
    <script type="text/javascript">
        
        $(document).ready(function(){
            load_fb('<% out.print(idFB); %>');
            load_all_respon('<% out.print(idFB); %>');
        });
        
        /** Memuat Deskripsi Forum Diskusi*/
        function load_fb(id = ''){
            $.ajax({
                url:"GetFB",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   if(data.status == "Progress" || data.status == "Menunggu"){
                        $('#submenu-fb').html("<label id=\"label-edit\">Edit</label>"+
                         "<label class=\"switch\">"+
                         "<input id=\"check-edit\" type=\"checkbox\"/>"+
                         "<span class=\"slider round\"></span>"+
                         "</label>"+
                         "<input id=\"button-save\" type=\"submit\" value=\"SAVE\" form=\"form-fb\" class=\"w3-button w3-round w3-blue button-pengeditan\" \>"+
                         "<input id=\"button-close\" type=\"submit\" value=\"CLOSE\" class=\"w3-button w3-round w3-blue button-pengeditan\" \>"+
                         "<input id=\"button-delete\" type=\"submit\" value=\"DELETE\" class=\"w3-button w3-round w3-blue button-pengeditan\" \>");

                        $('#form-add-respon').html("<textarea id=\"textarea-respon\" name=\"respon\" placeholder=\"Komentar..\"></textarea>"+
                        "<input id=\"button-respon\" type=\"submit\" value=\"COMMENT\" form=\"form-add-respon\" class=\"w3-button w3-round w3-blue\">");

                        $('#textarea-respon').focus();
                    }
                    
                    $('#button-save').attr("disabled", "disabled");
                    $('#button-close').attr("disabled", "disabled");
                    $('#button-delete').attr("disabled", "disabled");
                    $('.input-form').attr("readonly", "readonly");
                    $('.textarea-form').attr("readonly", "readonly");
                    
                    $('#topik').val(data.topikFB);
                    $('#detail').val(data.detail);
                    $('#tgl-fb').val(data.tglFB);
                    $('#waktu').val(data.waktu);
                    $('#status').val(data.status);
                    
                    /**Jika checkedit on*/
                    $('#check-edit').click(function(){
                        if($(this).prop("checked") === true){
                            $('#topik').removeAttr("readonly");
                            $('#topik').focus();
                            $('#detail').removeAttr("readonly");
                            $('#button-save').removeAttr("disabled");
                            $('#button-close').removeAttr("disabled");
                            $('#button-delete').removeAttr("disabled");
                        } else{
                            load_fb('<% out.print(idFB);%>');
                        }
                    });
                    
                    $('#button-close').click(function(){
                        var konfirmasi = window.confirm("Apakah feedback ini telah selesai"+
                                " dan kamu ingin menutupnya?");
                        if(konfirmasi){
                            close_fb('<% out.print(idFB); %>');
                        }
                    });
                    
                    $('#button-delete').click(function(){
                        var konfirmasi = window.confirm("Hapus feedback ini?");
                        if(konfirmasi){
                            delete_fb('<% out.print(idFB);%>');
                        }
                    });
                }
            });
        }
        
        /** Memvalidasi Input*/
        function validasi_input(form){
            if($('#topik').val() == ""){
                alert("Topik masih kosong!");
                $('#topik').focus();
                return false;
            }
            else if($('#detail').val() == ""){
                alert("Detail feedback masih kosong!");
                $('#detail').focus();
                return false;
            } 
            
            return true;
        }
        
        /** Menutup Feedback*/
        function close_fb(id = ''){
            $.ajax({
                url:"CloseFB",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   alert('Feedback sudah ditutup!');
                   window.location = 'RecordFB.jsp?id-fb=<% out.print(idFB); %>';
                }
            });
        }
        
        /** Delete Feedback */
        function delete_fb(id = ''){
        console.log(id);
            $.ajax({
                url:"DeleteFB",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   alert('Feedback berhasil dihapus!');
                   window.location = 'Feedback.jsp';
                }
            });
        }
        
        /** Memuat Semua Komentar Dari Forum Diskusi*/
        var html_all_respon = "";
        function load_all_respon(id = ''){
            console.log(id);
            $.ajax({
                url:"GetResponFB",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   if(data.listRespon.length){
                       data.listRespon.forEach(function(item){
                           if(item.idResponden != '<% out.print(idUser); %>'){
                               html_all_respon += "<div class=\"div-respon-admin\">"+
                                    "<div class=\"div-responden\">"+
                                        "<h4 class=\"label-responden\">"+item.namaResponden+"</h4>"+
                                    "</div>"+
                                    "<p class=\"content-respon\">"+item.detailRespon+"</p>"+
                                    "<h6 class=\"waktu\">"+item.tglRespon+", "+item.waktu+"</h6>"+
                                    "</div>";
                            }else{
                                html_all_respon += "<div class=\"div-respon-user\">"+
                                    "<div class=\"div-komentator\">"+
                                        "<h4 class=\"label-nama-komentator\">Me</h4>"+
                                    "</div>"+
                                    "<p class=\"content-komentar\">"+item.detailRespon+"</p>"+
                                    "<h6 class=\"waktu\">"+item.tglRespon+", "+item.waktu+"</h6>"+
                                    "</div>";
                            }
                       });
                   }
                   
                   $('#panel-list-respon').html(html_all_respon);
                }
            });
        }
        
        /** Memvalidasi Input Add Respon Feedback */ 
        function validasi_add_respon(form){
            if($('#textarea-respon').val() == ""){
                alert("Komentar masih kosong!");
                $('#textarea-respon').focus();
                return false;
            } 
            
            return true;
        }
    </script>
</html>