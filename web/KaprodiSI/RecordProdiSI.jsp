<%-- 
    Document   : RecordProdiSI
    Created on : Sep 13, 2019, 12:11:35 PM
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
<%! String idProdi; %>
<% idProdi = request.getParameter("id-prodi"); %>
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
            #label-prodi{
                position: relative;
                margin: 10px;
                margin-top: 10px;
                margin-left: 100px;
                width: 801px;
                height: 40px;
                font-size: 15pt;
            }
            #label-edit{
                position: relative;
                margin: 10px;
                margin-top: 10px;
                margin-left: 100px;
                width: 510px;
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
                height: 100px;
                overflow: hidden;
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5);
                resize: none;
            }
            #fakultas{
                position: relative;
                margin-left: 600px;
                margin: 10px;
                width: 495px;
                border: 1px solid;
                border-color: transparent transparent rgba(0, 0, 0, 0.5) transparent;
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
                        <a href="SistemInformasi.jsp" class="current">Sistem Informasi</a>
                    </li>
                    <li>
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    
                    <!--PANEL SUBHEADER DAN SUBMENU PRODI SI-->
                    <div id="panel-subheader">
                        <label id="label-prodi"></label>

                        <!--PANEL OPSI PENGEDITAN-->
                        <div id="submenu-prodi">
                            
                        </div>
                    </div>
                    
                    <!--DESKRIPSI PRODI SI-->
                    <form id="form-prodi" method="POST" action="../UpdateProdi?no=2&id-prodi=<% out.print(idProdi); %>" onsubmit="return validasi_input(this)">
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
                            <input id="no-telepon" name="no-telepon" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">E-Mail</label>
                            <input id="email" name="email" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                             <label class="label-form">Durasi Program (Tahun)</label>
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
                            <select id="kurikulum" name="kurikulum" class="select-form" ></select><br/>
                        </div>
                        <div class="div-form">
                            <label class="label-form">Fakultas</label>
                            <input id="fakultas" name="fakultas" type="text"><br/>
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
            load_prodi_si('<% out.print(idProdi); %>');
        });
        
        /** MEMUAT DESKRIPSI PRODI SI*/
        function load_prodi_si(id = ''){
            $.ajax({
                url:"../GetProdi",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                    console.log(id);
                    if(data.nipKaprodi == '<% out.print(idUser); %>'){
                        $('#submenu-prodi').html("<label id=\"label-edit\">Edit</label>"+
                             "<label class=\"switch\">"+
                             "<input id=\"check-edit\" type=\"checkbox\"/>"+
                             "<span class=\"slider round\"></span>"+
                             "</label>"+
                             "<input id=\"button-save\" type=\"submit\" value=\"SAVE\" form=\"form-prodi\" class=\"w3-button w3-round w3-blue button-pengeditan\" \>"+
                             "<input id=\"button-cancel\" type=\"submit\" value=\"CANCEL\" class=\"w3-button w3-round w3-blue button-pengeditan\" \>");
                    }
                   $('#button-save').attr("disabled", "disabled");
                    $('#button-cancel').attr("disabled", "disabled");
                   $('.input-form').attr("readonly", "readonly");
                   $('#textarea-form').attr("readonly", "readonly");
                    $('.select-form').attr("disabled", "disabled");
                    $('#fakultas').attr("readonly", "readonly");
                    
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
                        $('#durasi').val(data.durasiProgram);
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
                       $('#kurikulum').html("<option value=\'\'></option>");
                   }else{
                        $('#kurikulum').html("<option value=\'"+data.kurikulum+"\'>"+data.kurikulum+"</option>");
                    }
                    if(data.fakultas == null){
                       $('#fakultas').val("-");
                   }else{
                        $('#fakultas').val(data.fakultas);
                    }
                   
                   /**Jika checkedit on*/
                    $('#check-edit').click(function(){
                        if($(this).prop("checked") === true){
                            $('.input-form').removeAttr("readonly");
                            $('#kaprodi').focus();
                            $('#kurikulum').removeAttr("disabled");
                            load_all_kurikulum();
                            $('#button-save').removeAttr("disabled");
                            $('#button-cancel').removeAttr("disabled");
                        } else{
                            load_prodi_si('<% out.print(idProdi);%>');
                        }
                    });
                    
                    $("#button-cancel").click(function(){
                        $('#check-edit').removeAttr("checked")
                        load_prodi_si('<% out.print(idProdi); %>');
                    });
                }
            });
        }
        
        /** Mendapatkan semua daftar kurikulum**/
        var html_list_kurikulum = '';
        function load_all_kurikulum(){
            $.ajax({
                url:"../GetListKurikulum",
                method:"POST",
                data:{},
                dataType:"json",
                success:function(data){
                    if(data.listKurikulum.length){
                        html_list_kurikulum += "<option value=\"\"></option>";
                        data.listKurikulum.forEach(function(item){
                            html_list_kurikulum += "<option value=\'"+item.idKurikulum+"\'>"+item.tahunKurikulum+"</option>";
                        });
                    }
                    $('#kurikulum').html(html_list_kurikulum);
                }
            });
        }
        
        /** Memvalidasi input*/ 
        function validasi_input(form){
            if($('#kaprodi').val() == ""){
                alert("Kepala prodi  masih kosong!");
                $('#kaprodi').focus();
                return false;
            }else if($('#tahun').val() == ""){
                alert("Tahun berdiri  masih kosong!");
                $('#tahun').focus();
                return false;
            } else if($('#alamat').val() == ""){
                alert("Alamat  masih kosong!");
                $('#alamat').focus();
                return false;
            } else if($('#no-telepon').val() == ""){
                alert("No telepon  masih kosong!");
                $('#no-telepon').focus();
                return false;
            } else if($('#email').val() == ""){
                alert("E-Mail  masih kosong!");
                $('#email').focus();
                return false;
            } else if($('#durasi').val() == ""){
                alert("Durasi program masih kosong!");
                $('#durasi').focus();
                return false;
            } else if($('#jmlh-sks').val() == ""){
                alert("Jumlah SKS masih kosong!");
                $('#jmlh-sks').focus();
                return false;
            } else if($('#max-sem').val() == ""){
                alert("Semester maksimal masih kosong!");
                $('#max-sem').focus();
                return false;
            } else if($('#kurikulum').val() == ""){
                alert("Kurikulum masih kosong!");
                $('#kurikulum').focus();
                return false;
            } 
            
            var konfirmasi = window.confirm("Apakah profil program studi sudah benar?\n\n\n"+
                    "Kepala Prodi                      : "+$('#kaprodi').val()+"\n"+
                    "Tahun Berdiri                     : "+$('#tahun').val()+"\n"+
                    "Alamat                                 : "+$('#alamat').val()+"\n"+
                    "No Telepon                         : "+$('#no-telepon').val()+"\n"+
                    "E-Mail                                  : "+$('#email').val()+"\n"+
                    "Durasi Program (Tahun) : "+$('#durasi').val()+"\n"+
                    "Jumlah SKS                       : "+$('#jmlh-sks').val()+"\n"+
                    "Semester Maksimal         : "+$('#max-sem').val()+"\n"+
                    "Kurikulum                           : "+$('#kurikulum option:selected').text());
            if(konfirmasi){
                return true;
            }else{
                return false;
            }
            
        }
    </script>
</html>