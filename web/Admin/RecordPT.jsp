<%-- 
    Document   : RecordPT
    Created on : Sep 16, 2019, 6:21:05 PM
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
<%! String idPT; %>
<% idPT = request.getParameter("id-pt"); %>
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
            #label-edit{
                position: relative;
                margin: 10px;
                margin-top: 10px;
                margin-left: 100px;
                width: 515px;
                height: 40px;
                font-size: 15pt;
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
            #form-pt{
                margin-bottom: 20px;
                margin-top: 30px;
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
            .label-fakultas{
                position: relative;
                margin: 10px;
                margin-top: 50px;
                margin-left: 100px;
                width: 500px;
            }
            .div-fakultas{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
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
                        <a href="PerguruanTinggi.jsp" class="current">Perguruan Tinggi</a>
                    </li>
                    <li>
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    
                    <!--PANEL EDIT DAN DELETE JIKA PT ADMIN-->
                    <div id="submenu-pt">
                        
                    </div>
                    
                    <!--DESKRIPSI PT-->
                    <form id="form-pt" method="POST" action="../UpdatePT?id-pt=<% out.print(idPT); %>" onsubmit="return validasi_input(this)">
                        <div class="div-form">
                             <label class="label-form">Nama</label>
                             <input id="nama-pt" name="nama-pt" class="input-form" type="text"><br/>
                         </div>
                        
                         <div class="div-form">
                             <label class="label-form">Alamat</label>
                             <input id="alamat" name="alamat" class="input-form" type="text"><br/>
                         </div>
                         
                        <div class="div-form">
                            <label class="label-form">No Telepon</label>
                            <input id="no-telepon" name="no-telepon" type="text" class="input-form"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">E-Mail</label>
                            <input id="email" name="email" class="input-form" type="text"><br/>
                        </div>
                    </form>
                    
                    <!--PANEL FAKULTAS YANG MENAUNGI PRODI SI-->
                    <label class="label-fakultas">Fakultas yang menaungi Program Studi Sistem Informasi</label>
                    <div class="div-fakultas">
                        <div id="div-button"></div>
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
            load_pt('<% out.print(idPT); %>');
        });
        
        /** Memuat Daftar Kelompok Mata Kuliah*/
        function load_pt(id = ''){
            $.ajax({
                url:"../GetPT",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                    if(data.adminPT == "YES"){
                        $('#submenu-pt').html("<label id=\"label-edit\">Edit</label>"+
                                    "<label class=\"switch\">"+
                                    "<input id=\"check-edit\" type=\"checkbox\">"+
                                    "<span class=\"slider round\"></span>"+
                                    "</label>"+
                                    "<input id=\"button-save\" type=\"submit\" value=\"SAVE\" form=\"form-pt\" class=\"w3-button w3-round w3-blue button-pengeditan\">"+
                                    "<input id=\"button-cancel\" type=\"submit\" value=\"CANCEL\" class=\"w3-button w3-round w3-blue button-pengeditan\"><br/>");
                    }
                    
                    $('.input-form').attr("readonly", "readonly");
                    $('#button-save').attr("disabled", "disabled");
                    $('#button-cancel').attr("disabled", "disabled");
                    $('#button-delete').attr("disabled", "disabled");
                    
                    $('#nama-pt').val(data.namaPT);
                    $('#alamat').val(data.alamat);
                    $('#no-telepon').val(data.noTelp);
                    $('#email').val(data.email);
                    $('#div-button').html("<button id=\"button-fakultas\" class=\"w3-button w3-round w3-blue\" onclick=\"window.location = \'RecordFakultas.jsp?id-pt="+id+"&id-fakultas="+data.idFakultas+"\'\">"+data.namaFakultas+"</button>");
                   
                   /**Jika checkedit on*/
                    $('#check-edit').click(function(){
                        if($(this).prop("checked") === true){
                            $('.input-form').removeAttr("readonly");
                            $('#button-save').removeAttr("disabled");
                            $('#button-cancel').removeAttr("disabled");

                        } else{
                            load_pt('<% out.print(idPT); %>');
                        }
                    });
                    

                    $("#button-cancel").click(function(){
                        $('#check-edit').removeAttr("checked")
                        load_pt('<% out.print(idPT); %>');
                    });


                }
            });
        }
        
        /** Memvalidasi input*/ 
        function validasi_input(form){
            if($('#nama-pt').val() == ""){
                alert("Nama perguruan tinggi masih kosong!");
                $('#nama-pt').focus();
                return false;
            } else if($('#alamat').val() == ""){
                alert("Alamat  masih kosong!");
                $('#alamat').focus();
                return false;
            } else if($('#no-telepon').val() == ""){
                alert("No telepon masih kosong!");
                $('#no-telepon').focus();
                return false;
            } else if($('#email').val() == ""){
                alert("E-Mail masih kosong!");
                $('#email').focus();
                return false;
            }
            
            var konfirmasi = window.confirm("Apakah data perguruan tinggi sudah benar?\n\n\n"+
                    "Perguruan Tinggi   : "+$('#nama-pt').val()+"\n"+
                    "Alamat                      : "+$('#alamat').val()+"\n"+
                    "No Telepon              : "+$('#no-telepon').val()+"\n"+
                    "E-Mail                        : "+$('#email').val());
            if(konfirmasi){
                return true;
            }else{
                return false;
            }
            
        }
    </script>
</html>