<%-- 
    Document   : RecordRegistrasi
    Created on : Sep 5, 2019, 2:21:03 PM
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
<% nim = request.getParameter("nim"); %>
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
            #label-registrasi{
                 position: relative;
                margin-top: 30px;
                margin-left: 100px;
                margin-bottom: 30px;
                font-size: 20pt;
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
            .div-opsi-verifikasi{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
                margin-top: 50px;
                padding-left: 230px;
                padding-right: 230px;
            }.button-form{
                position: relative;
                margin: 10px;
                width: 95px;
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
                
                <!--PANEL CONTENT-->
                <div id="panel-content">
                    
                    <!--LABEL REGISTRASI MAHASISWA-->
                    <label id="label-registrasi">Registrasi</label>
                    
                    <!--FORM PROFIL MAHASISWA REGISTRASI-->
                    <form id="form-mahasiswa" method="POST" action="../VerifikasiMahasiswa">
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
                    
                    <!--PANEL OPSI VERIFIKASI-->
                    <div class="div-opsi-verifikasi">
                        <div class="div-button">
                            <input id="button-verify" type="submit" value="VERIFY" form="form-mahasiswa" class="w3-button w3-round w3-blue button-form">
                        </div>
                        <div class="div-button">
                            <input id="button-reject" type="submit" value="REJECT" class="w3-button w3-round w3-blue button-form">
                        </div>
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
            
            $('#button-reject').click(function(item){
                delete_mahasiswa_registrasi('<% out.print(nim); %>');
            });
            
        });
        
        /** Memuat Profil Mahasiswa*/
        function load_profil_mahasiswa(id = '', tipe = ''){
           $('.input-form').attr("readonly", "readonly");
            
            $.ajax({
                url:"../GetProfilRegistrasi",
                method:"POST",
                data:{id: id, tipe: tipe},
                dataType:"json",
                success:function(data){
                    console.log(data.nim);
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
                }
            });
        }
        
        /** Menghapus Data Mahasiswa Yang Direject Registrasi*/
        function delete_mahasiswa_registrasi(id = ''){
          
            $.ajax({
                url:"../DeleteMahasiswaRegistrasi",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                    window.location = 'RegistrasiMahasiswa.jsp';
                }
            });
        }
    </script>
</html>