<%-- 
    Document   : RecordMahasiswa
    Created on : Sep 1, 2019, 11:45:10 AM
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
<%! String nim; %>
<%! String tahunAngkatan; %>
<% nim = request.getParameter("nim"); %>
<% tahunAngkatan = request.getParameter("tahun-angkatan"); %>

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
            #img-pane{
                position: absolute;
                right: 0px;
                margin-top:50px;
                margin-right: 505px;
                align-content: center;
                width: 8%;
                height: 18%;
                background-color: #ffffff;
                border:5px inset blue;
            }
            #img-pane img{
                width: 96px;
                height: 104px;
            }
            #panel-content{
                margin-top: 200px;
            }
            #button-delete{
                position: relative;
                margin: 10px;
                margin-top: 45px;
                margin-left: 805px;
                margin-bottom: 50px;
                width: 105px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity: 80);
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
            .div-ok{
                display: flex;
                flex-flow: column wrap;
                align-items: center;
                margin-top: 50px;
            }
            .button-form{
                position: relative;
                margin: 10px;
                width: 105px;
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
                            PreparedStatement statement = konek.prepareStatement("SELECT col_user_image, col_jenis_kelamin, col_nama_wadek FROM "
                                    + "tbl_user INNER JOIN tbl_wadek_kemahasiswaan ON (tbl_wadek_kemahasiswaan.col_nip = tbl_user.col_id_user) "
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
                                out.print(rs.getString("col_nama_wadek"));
                            }
                        }catch(SQLException ex){
                            out.print(ex.getMessage());
                        }
                        %>
                    </a></li>
                    <li>
                        <a href="Mahasiswa.jsp" class="current">Mahasiswa</a>
                    </li>
                    <li>
                        <a href="Messaging.jsp">Messaging</a>
                    </li>
                    <li>
                        <a href="SistemInformasi.jsp">Sistem Informasi</a>
                    </li>
                    <li>
                        <a href="Setelan.jsp">Setelan</a>
                    </li>
                </ul>
                    
                <!--PANEL IMAGE-->
                <div id="img-pane">
                    <img id="img-profil">
                </div>
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    <!--BUTTON DELETE AKUN USER-->
                    <input id="button-delete" type="submit" value="DELETE" name="delete-mahasiswa" form="form-mahasiswa" class="w3-button w3-blue w3-round">
                        
                    <!--FORM PROFIL MAHASISWA-->
                    <form id="form-mahasiswa" method="POST" action="../DeleteMahasiswa?no=1" onsubmit="return validasi_input(this)">
                        <div>
                            <label class="label-form">NIM</label>
                            <input id="nim" class="input-form"  name="nim" type="text" ><br/>
                        </div>
                        <div>
                            <label class="label-form">Nama</label>
                            <input id="nama" class="input-form" name="nama" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Tanggal Lahir</label>
                            <input id="tgl_lahir" class="input-form" name="tgl_lahir" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Jenis Kelamin</label>
                            <input id="jenis_kelamin" class="input-form" name="jenis_kelamin" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Agama</label>
                           <input id="agama" class="input-form" name="agama" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">No Handphone</label>
                            <input id="no_hp" class="input-form"name="no_hp" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Alamat</label>
                            <input id="alamat" class="input-form"name="alamat" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Perguruan Tinggi</label>
                            <input id="pt" class="input-form" name="pt" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Angkatan</label>
                            <input id="angkatan" class="input-form"name="angkatan" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">Status</label>
                            <input id="status" class="input-form" name="status" type="text"><br/>
                        </div>
                        <div>
                            <label class="label-form">E-Mail</label>
                            <input id="email" class="input-form" name="email" type="text"><br/>
                        </div>
                        
                    </form>
                    
                    <!--BUTTON OK-->
                    <div class="div-ok">
                        <input id="button-ok" type="submit" value="OK" class="w3-button w3-round w3-blue button-form" onclick="window.location = 'MahasiswaAngkatan.jsp?tahun-angkatan=<% out.print(tahunAngkatan); %>'">
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
            load_profil_mahasiswa('<% out.print(nim); %>', '0');
            
        });
        
        /** Memuat Profil Mahasiswa*/
        function load_profil_mahasiswa(id = '', tipe = ''){
           $('.input-form').attr("readonly", "readonly");
            
            $.ajax({
                url:"../GetProfil",
                method:"POST",
                data:{id: id, tipe: tipe},
                dataType:"json",
                success:function(data){
                    $('#nim').val(data.nim); 
                    $('#nama').val(data.namaMahasiswa);
                    $('#tgl_lahir').val(data.tglLahir);
                    if(data.jenisKelamin == "L"){
                        $('#jenis_kelamin').val("Laki-Laki");
                    }else{
                        $('#jenis_kelamin').val("Perempuan");
                    }
                    $('#agama').val(data.agama);
                    $('#no_hp').val(data.noHp);
                    $('#alamat').val(data.alamat);
                    $('#pt').val(data.pt);
                    $('#angkatan').val(data.angkatan);
                    if(data.status == "0"){
                        $('#status').val("Non-Aktif");
                    }else if(data.status == 1){
                        $('#status').val("Aktif");
                    }
                    $('#email').val(data.email);
                    if(data.userImage == null){
                        if(data.jenisKelamin == "L"){
                            $('#img-profil').attr('src', '../apps-img/boy.png');
                        }else{
                            if(data.agama == "Islam"){
                              $('#img-profil').attr('src', '../apps-img/woman.png');
                            }else{
                                $('#img-profil').attr('src', '../apps-img/girl.png');
                            }
                        }
                    }else{
                      $('#img-profil').attr('src', '../'+data.userImage);
                    }
                }
            });
        }
        
        function validasi_input(form){
            var konfirmasi = window.confirm('Hapus akun mahasiswa ini?');
            if(konfirmasi){
                return true;
            }
            
            return false;
        }
    </script>
</html>