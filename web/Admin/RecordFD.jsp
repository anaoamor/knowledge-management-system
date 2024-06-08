<%-- 
    Document   : RecordFD
    Created on : Sep 18, 2019, 2:20:16 PM
    Author     : MORIZA
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
<%! String idFD;%>
<% idFD = request.getParameter("id-fd");%>
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
            #container{
                min-height: 2000px;
            }
            #panel-subheader{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            #label-fd{
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
            .select-form{
                position: relative;
                margin-left: 600px;
                margin: 10px;
                width: 495px;
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5);
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
            .div-komentar-anggota{
                position: relative;
                margin-left: 100px;
                margin-top: 20px;
                padding: 10px;
                width: 495px;
                border: 2px solid;
                border-color: transparent; /*#ccc;*/
                background-color: #e7e7e7;
            }
            .div-komentar-user{
                position: relative;
                margin-left: 409px;
                margin-top: 20px;
                padding: 10px;
                width: 495px;
                border: 2px solid;
                border-color: transparent;
                background-color: #ccc;
            }
            .div-komentator{
                position: relative;
                margin-left: 10px;
                margin-right: 10px;
                border-bottom: 3px double;
            }
            .label-nama-komentator{
                font-weight: bold;
            }
            .content-komentar{
                margin-left: 10px;
                margin-right: 10px;
            }
            .waktu{
                font-size: 7pt;
                margin-left: 375px;
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
                        <a href="MateriKuliah.jsp">Materi Kuliah</a>
                    </li>
                    <li>
                        <a href="Messaging.jsp">Messaging</a>
                    </li>
                    <li>
                        <a href="ForumDiskusi.jsp" class="current">Forum Diskusi</a>
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
                    
                    <!--PANEL SUBHEADER DAN SUBMENU FORUM DISKUSI-->
                    <div id="panel-subheader">
                        <label id="label-fd">Forum Diskusi</label>

                        <!--PANEL OPSI PENGEDITAN-->
                        <div id="submenu-fd">
                            <label id="label-edit">Edit</label>
                             <label class="switch">
                             <input id="check-edit" type="checkbox"/>
                             <span class="slider round"></span>
                             </label>
                             <input id="button-save" type="submit" value="SAVE" form="form-fd" class="w3-button w3-round w3-blue button-pengeditan" \>
                             <input id="button-close" type="submit" value="CLOSE" class="w3-button w3-round w3-blue button-pengeditan" \>
                             <input id="button-delete" type="submit" value="DELETE" class="w3-button w3-round w3-blue button-pengeditan" \>
                        </div>
                    </div>
                    
                    <!--DESKRIPSI FORUM DISKUSI-->
                    <form id="form-fd" method="POST" action="../UpdateFD?id-fd=<% out.print(idFD); %>" onsubmit="return validasi_input(this)">
                        
                        <div class="div-form">
                             <label class="label-form">Topik</label>
                             <input id="topik" name="topik" class="input-form" type="text"><br/>
                         </div>
                        
                        <div class="div-form">
                             <label class="label-form">Subbidang</label>
                             <select id="subbidang" class="select-form" name="subbidang" type="text">
                            </select><br/>
                         </div>
                        
                        <div class="div-form">
                            <label class="label-form">Deskripsi</label>
                            <textarea id="deskripsi" name="deskripsi" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Tanggal</label>
                            <input id="tgl-fd" name="tgl-fd" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Waktu</label>
                            <input id="waktu" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Status</label>
                            <input id="status" name="status" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Oleh</label>
                            <input id="fd-by" name="fd-by" class="input-form" type="text"><br/>
                        </div>
                    </form>
                    
                    <div id="div-border"></div>
                    
                    <!--PANEL SEMUA KOMENTAR-->
                    <div id="panel-list-komentar">
                        <!--KOMENTAR ANGGOTA LAIN-->
                        <div class="div-komentar-anggota">
                            <div class="div-komentator">
                                <h4 class="label-nama-komentator">Anggota :</h4>
                            </div>
                            <p class="content-komentar">Komentar..</p>
                            <h6 class="waktu">DD:MM:YYYY, hh:mm</h6>
                        </div>
                        
                        
                        <!--KOMENTAR USER-->
                        <div class="div-komentar-user">
                            <div class="div-komentator">
                                <h4 class="label-nama-komentator">Me :</h4>
                            </div>
                            <p class="content-komentar">Komentar..</p>
                            <h6 class="waktu">DD:MM:YYYY, hh:mm</h6>
                        </div>
                        
                    </div>
                    
                    <!--PANEL ADD KOMENTAR-->
                    <div>
                        <form id="form-add-komentar" method="POST" action="../AddKomentar?id-fd=<% out.print(idFD); %>" onsubmit="return validasi_add_komentar(this)">
                            
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
            load_fd('<% out.print(idFD); %>');
            load_all_komen('<% out.print(idFD); %>');
        });
        
        /** Memuat Deskripsi Forum Diskusi*/
        function load_fd(id = ''){
            $.ajax({
                url:"../GetFD",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   if(data.status == "Progress"){
                        $('#form-add-komentar').html("<textarea id=\"textarea-komentar\" name=\"komentar\" placeholder=\"Komentar..\"></textarea>"+
                        "<input id=\"button-komentar\" type=\"submit\" value=\"COMMENT\" form=\"form-add-komentar\" class=\"w3-button w3-round w3-blue\">");

                        $('#textarea-komentar').focus();
                    }
                    
                    $('#button-save').attr("disabled", "disabled");
                    $('#button-close').attr("disabled", "disabled");
                    $('#button-delete').attr("disabled", "disabled");
                    $('.input-form').attr("readonly", "readonly");
                    $('.select-form').attr("disabled", "disabled");
                    $('.textarea-form').attr("readonly", "readonly");
                    
                    $('#topik').val(data.topikFD);
                    $('#subbidang').html("<option value=\'"+data.subbidang+"\'>"+data.subbidang+"</option>");
                    $('#deskripsi').val(data.deskripsi);
                    $('#tgl-fd').val(data.tglFD);
                    $('#waktu').val(data.waktu);
                    $('#status').val(data.status);
                    $('#fd-by').val(data.namaCreator);
                    
                    /**Jika checkedit on*/
                    $('#check-edit').click(function(){
                        if($(this).prop("checked") === true){
                            $('#topik').removeAttr("readonly");
                            $('#topik').focus();
                            $('#subbidang').removeAttr("disabled");
                            load_all_subbidang();
                            $('#deskripsi').removeAttr("readonly");
                            $('#button-save').removeAttr("disabled");
                            $('#button-close').removeAttr("disabled");
                            $('#button-delete').removeAttr("disabled");
                        } else{
                            load_fd('<% out.print(idFD);%>');
                        }
                    });
                    
                    $('#button-close').click(function(){
                        var konfirmasi = window.confirm("Apakah pembahasan pada diskusi ini telah selesai "+
                                " dan anda ingin menutup diskusi?");
                        if(konfirmasi){
                            close_fd('<% out.print(idFD); %>');
                        }
                    });
                    
                    $('#button-delete').click(function(){
                        var konfirmasi = window.confirm("Hapus forum ini?");
                        if(konfirmasi){
                            delete_fd('<% out.print(idFD);%>');
                        }
                    });
                }
            });
        }
        
        /**Mendapatkan Semua Daftar Subbidang Diskusi*/
        var html_list_subbidang = '';
        function load_all_subbidang(){
            $.ajax({
                url:"../GetListSubbidang",
                method:"POST",
                data:{},
                dataType:"json",
                success:function(data){
                    if(data.listSubbidang.length){
                        html_list_subbidang += "<option values\"\"></option>";
                        data.listSubbidang.forEach(function(item){
                            html_list_subbidang += "<option values=\'"+item.subbidang+"\'>"+item.subbidang+"</option>";
                        });
                    }
                    $('#subbidang').html(html_list_subbidang);
                }
            });
        }
        
        /** Memvalidasi Input*/
        function validasi_input(form){
            if($('#topik').val() == ""){
                alert("Topik diskusi masih kosong!");
                $('#topik').focus();
                return false;
            }
            else if($('#deskripsi').val() == ""){
                alert("Deskripsi diskusi masih kosong!");
                $('#deskripsi').focus();
                return false;
            } else if($('#subbidang').val() == ""){
                alert("Subbidang diskusi masih kosong!");
                $('#subbidang').focus();
                return false;
            }
            
            return true;
        }
        
       /** Menutup Forum Diskusi*/
        function close_fd(id = ''){
            $.ajax({
                url:"../CloseFD",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   alert('Forum diskusi sudah ditutup!');
                   window.location = 'RecordFD.jsp?id-fd=<% out.print(idFD); %>';
                }
            });
        } 
        
        /** Delete Forum Diskusi */
        function delete_fd(id = ''){
            $.ajax({
                url:"../DeleteFD",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   alert('Forum diskusi berhasil dihapus!');
                   window.location = 'ForumDiskusi.jsp';
                }
            });
        }
        
        /** Memuat Semua Komentar Dari Forum Diskusi*/
        var html_all_komen = "";
        function load_all_komen(id = ''){
            console.log(id);
            $.ajax({
                url:"../GetKomentarFD",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                   if(data.listKomentar.length){
                       data.listKomentar.forEach(function(item){
                           if(item.idKomentator != '<% out.print(idUser); %>'){
                               html_all_komen += "<div class=\"div-komentar-anggota\">"+
                                    "<div class=\"div-komentator\">"+
                                        "<h4 class=\"label-nama-komentator\">"+item.namaKomentator+"</h4>"+
                                    "</div>"+
                                    "<p class=\"content-komentar\">"+item.detailKomentar+"</p>"+
                                    "<h6 class=\"waktu\">"+item.tglKomentar+", "+item.waktu+"</h6>"+
                                    "</div>";
                            }else{
                                html_all_komen += "<div class=\"div-komentar-user\">"+
                                    "<div class=\"div-komentator\">"+
                                        "<h4 class=\"label-nama-komentator\">Me</h4>"+
                                    "</div>"+
                                    "<p class=\"content-komentar\">"+item.detailKomentar+"</p>"+
                                    "<h6 class=\"waktu\">"+item.tglKomentar+", "+item.waktu+"</h6>"+
                                    "</div>";
                            }
                       });
                   }
                   
                   $('#panel-list-komentar').html(html_all_komen);
                }
            });
        }
        
        /** Memvalidasi Input Add Komentar */ 
        function validasi_add_komentar(form){
            if($('#textarea-komentar').val() == ""){
                alert("Komentar masih kosong!");
                $('#textarea-komentar').focus();
                return false;
            } 
            
            return true;
        }
        
    </script>
</html>