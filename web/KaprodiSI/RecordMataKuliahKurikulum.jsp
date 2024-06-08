<%-- 
    Document   : RecordMataKuliahKurikulum
    Created on : Sep 12, 2019, 7:24:15 AM
    Author     : ASUS
--%>

<!--STRING NO = 0, 1 ==> UNTUK MEMNGGIL HALAMAN SEBELUMNYA--> 

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
<%! String noPage; %>
<%! String idKurikulum; %>
<%! String idKelompok; %>
<%! String kodeMatkul; %>
<% noPage = request.getParameter("no"); %>
<% idKurikulum = request.getParameter("id-kurikulum"); %>
<% idKelompok = request.getParameter("id-kelompok"); %>
<% kodeMatkul = request.getParameter("id-matkul"); %>
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
            #panel-subheader{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            #label-matkul{
                position: relative;
                margin: 10px;
                margin-top: 10px;
                margin-left: 100px;
                width: 298px;
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
            #div-textarea{
                display: flex;
                flex-flow: row wrap;
                align-items: center;
            }
            .label-textarea{
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
                height: 150px;
                overflow: hidden;
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5)rgba(0, 0, 0, 0.5);
                resize: none;
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
                        <a href="Kurikulum.jsp" class="current">Kurikulum</a>
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
                    
                    <!--PANEL SUBHEADER DAN SUBMENU MATA KULIAH-->
                    <div id="panel-subheader">
                        <label id="label-matkul">Mata Kuliah</label><br/>
                        
                        <!--PANEL OPSI PENGEDITAN-->
                        <div id="submenu-matkul">
                              
                        </div>
                    </div>
                    
                    <!--DESKRIPSI MATA KULIAH-->
                    <% out.print("<form id=\"form-matkul\" method=\"POST\" action=\"../UpdateMataKuliah?no="+noPage+"&id-kurikulum="+idKurikulum+"&id-kelompok="+idKelompok+"&id-matkul="+kodeMatkul+"\" onsubmit=\"return validasi_input(this)\">"); %>
                        <div id="div-textarea">
                            <label class="label-form">Kode Mata Kuliah</label>
                            <input id="kode_matkul" name="kode_matkul" class="input-form" type="text"><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-form">Nama</label>
                            <input id="nama_matkul" name="nama_matkul" class="input-form" type="text"><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-form">SKS</label>
                            <input id="sks" name="sks" class="input-form" type="text"><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-textarea">Deskripsi</label>
                            <textarea id="deskripsi" name="deskripsi" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-textarea">Prasyarat</label>
                            <textarea id="prasyarat" name="prasyarat" class="textarea-form" type="text"></textarea><br/>
                        </div>
                        <div id="div-textarea">
                            <label class="label-textarea">Standar Kompetensi</label>
                            <textarea id="standar-kompetensi" name="standar-kompetensi" class="textarea-form" type="text"></textarea><br/>
                        </div>
                    <% out.print("</form>"); %>
                    
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
        
        var no_page = '<% out.print(noPage); %>';
        var id_kurikulum = '<% out.print(idKurikulum); %>';
        var id_kelompok = '<% out.print(idKelompok); %>'; 
        $(document).ready(function(){
            load_matkul('<% out.print(kodeMatkul); %>');
        });
        
        /** Memuat Daftar Mata Kuliah*/
        function load_matkul(id = ''){
            var html_mata_kuliah = '';
            $.ajax({
                url:"../GetMataKuliahKaprodi",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                    if(data.creator == <% out.print(idUser); %>){
                        $('#submenu-matkul').html("<label class=\"switch\">"+
                                "<input id=\"check-edit\" type=\"checkbox\">"+
                                "<span class=\"slider round\"></span>"+
                                "</label>"+
                                "<input id=\"button-save\" type=\"submit\" value=\"SAVE\" form=\"form-matkul\" class=\"w3-button w3-round w3-blue button-pengeditan\">"+
                                "<input id=\"button-cancel\" type=\"submit\" value=\"CANCEL\" class=\"w3-button w3-round w3-blue button-pengeditan\">"+
                                "<input id=\"button-delete\" type=\"submit\" value=\"DELETE\" class=\"w3-button w3-round w3-blue button-pengeditan\"><br/>");
                    }
                    
                    $('.input-form').attr("readonly", "readonly");
                    $('.textarea-form').attr("readonly", "readonly");
                    $('#button-save').attr("disabled", "disabled");
                    $('#button-cancel').attr("disabled", "disabled");
                    $('#button-delete').attr("disabled", "disabled");
                    
                    $('#kode_matkul').val(id);
                    $('#nama_matkul').val(data.namaMatkul);
                    $('#sks').val(data.sks);
                    $('#deskripsi').val(data.deskripsi);
                    $('#prasyarat').val(data.prasyarat);
                    $('#standar-kompetensi').val(data.standarKompetensi);
                   
                   /**Jika checkedit on*/
                    $('#check-edit').click(function(){
                        if($(this).prop("checked") === true){
                            $('.input-form').removeAttr("readonly");
                            $('.textarea-form').removeAttr("readonly");
                            $('#button-save').removeAttr("disabled");
                            $('#button-cancel').removeAttr("disabled");
                            $('#button-delete').removeAttr("disabled");

                        } else{
                            load_matkul('<% out.print(kodeMatkul); %>');
                        }
                    });
                    

                    $("#button-cancel").click(function(){
                        $('#check-edit').removeAttr("checked")
                        load_matkul('<% out.print(kodeMatkul); %>');
                    });

                    $('#button-delete').click(function(){
                        var konfirmasi = window.confirm("Hapus mata kuliah ini?");
                        if(konfirmasi){
                            delete_matkul('<% out.print(kodeMatkul); %>');
                        } else{

                        }
                    });

                }
            });
        }
        
        function delete_matkul(id = ''){
            $.ajax({
                url:"../DeleteMataKuliah",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                    alert('Mata kuliah berhasil dihapus!');
                    if(no_page == "0"){
                        window.location = 'RecordKurikulum.jsp?id-kurikulum='+id_kurikulum;
                    }else{
                        window.location = 'RecordKelompokMataKuliah.jsp?id-kurikulum='+id_kurikulum+'&id-kelompok='+id_kelompok;
                    }
                    
                }
            });
        }
        
        /** Memvalidasi input*/ 
        function validasi_input(form){
            if($('#kode_matkul').val() == ""){
                alert("Kode mata kuliah  masih kosong!");
                $('#kode_matkul').focus();
                return false;
            }else if($('#nama_matkul').val() == ""){
                alert("Nama mata kuliah  masih kosong!");
                $('#nama_matkul').focus();
                return false;
            } else if($('#sks').val() == ""){
                alert("Jumlah SKS  masih kosong!");
                $('#sks').focus();
                return false;
            } else if($('#deskripsi').val() == ""){
                alert("Deskripsi  masih kosong!");
                $('#deskripsi').focus();
                return false;
            } else if($('#prasyarat').val() == ""){
                alert("Prasyarat mata kuliah  masih kosong!");
                $('#prasyarat').focus();
                return false;
            } else if($('#standar-kompetensi').val() == ""){
                alert("Standar kompetensi masih kosong!");
                $('#standar-kompetensi').focus();
                return false;
            } 
            
            var konfirmasi = window.confirm("Apakah data mata kuliah sudah benar?\n\n\n"+
                    "Kode                              : "+$('#kode_matkul').val()+"\n"+
                    "Nama                            : "+$('#nama_matkul').val()+"\n"+
                    "Jumlah SKS                 : "+$('#sks').val()+"\n"+
                    "Deskripsi                      : \n\t"+$('#deskripsi').val()+"\n\n"+
                    "Prasyarat                      : \n\t"+$('#prasyarat').val()+"\n\n"+
                    "Standar Kompetensi  : \n\t"+$('#standar-kompetensi').val());
            if(konfirmasi){
                return true;
            }else{
                return false;
            }
            
        }
    </script>
</html>