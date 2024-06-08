<%-- 
    Document   : RecordKurikulum
    Created on : Sep 11, 2019, 3:01:39 PM
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
<%! String idKurikulum;%>
<% idKurikulum = request.getParameter("id-kurikulum");%>
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
                min-height: 3500px;
            }
            #label-edit{
                position: relative;
                margin: 10px;
                margin-top: 10px;
                margin-left: 100px;
                width: 387px;
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
            #form-kurikulum{
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
            #button-add{
                position: relative;
                margin: 10px;
                margin-top: 10px;
                margin-left: 588px;
                margin-bottom: 20px;
                width: 300px;
                text-align: center;
                opacity: 0.8;
                filter: alpha(opacity:80);
            }
            #ul-klmpk-mata-kuliah {
                list-style-type: none;
                margin-left: 103px;
                margin-right: 103px;
            }
            #tipe-klmpk {
                border: 2px solid;
            }
            .load-mata-kuliah{
               text-decoration: none; 
               font-size: 11pt;
               font-weight: bold;
            }
            .ul-mata-kuliah{
                list-style-type: none;
                margin-left: 20px;
                margin-right: 20px;
            }
            #tipe-mata-kuliah {
                border: 1px solid;
                border-color: rgba(0, 0, 0, 0.5) transparent transparent transparent;
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
                    
                    <!--PANEL EDIT DAN DELETE JIKA KURIKULUM DIBUAT USER-->
                    <div id="submenu-kurikulum">
                        
                    </div>
                    
                    <!--DESKRIPSI KURIKULUM-->
                    <% out.print("<form id=\"form-kurikulum\" method=\"POST\" action=\"../UpdateKurikulum?id-kurikulum="+idKurikulum+"\" onsubmit=\"return validasi_input(this)\">"); %>
                        <div class="div-form">
                             <label class="label-form">Tahun</label>
                             <input id="tahun-kurikulum" name="tahun-kurikulum" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                             <label class="label-form">Jumlah SKS</label>
                             <input id="jmlh-sks" name="jmlh-sks" class="input-form" type="text"><br/>
                        </div>
                        <div class="div-form">
                             <label class="label-form">Jumlah Semester</label>
                             <input id="jmlh-semester" name="jmlh-semester" class="input-form" type="text"><br/>
                        </div>
                    <% out.print("</form>"); %>
                    
                    <!--BUTTON ADD KELOMPOK MATA KULIAH-->
                    <div class="w3-row-padding">
                        
                       <!--Space Kosong-->
                       <div class="w3-col s8"></div>
                        
                        <!--Button Add Kelompok Mata Kuliah-->
                        <div class="w3-col s2">
                            <% out.print("<input id=\"button-add\" type=\"submit\" value=\"Tambah Kelompok Mata Kuliah\"  class=\"w3-button w3-blue w3-round\" onclick=\"window.location.href = \'CreateKelompokMataKuliah.jsp?id-kurikulum="+idKurikulum+"\'\">"); %>
                        </div>
                        
                    </div>
                    
                    <!--DAFTAR KELOMPOK MATA KULIAH-->
                    <ul id="ul-klmpk-mata-kuliah">
                        <li id="tipe-klmpk">
                            <a class="load-mata-kuliah">Mata Kuliah Universitas</a>
                            <ul class="ul-mata-kuliah">
                                <li id="tipe-mata-kuliah">
                                <a href='RecordMataKuliah.jsp'>Mata Kuliah</a></li>
                                <li id="tipe-mata-kuliah">
                                <a href='RecordMataKuliah.jsp'>Mata Kuliah</a></li>
                            </ul>
                        </li>
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
            load_klmpk_mata_kuliah('<% out.print(idKurikulum); %>');
        });
        
        /** Memuat Daftar Kelompok Mata Kuliah*/
        var html_klmpk_mata_kuliah = '';
        function load_klmpk_mata_kuliah(id = ''){
            $.ajax({
                url:"../GetAllKelompokMataKuliah",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                    var id_kurikulum = '<% out.print(idKurikulum); %>';
                    if(data.creator == <% out.print(idUser); %>){
                        $('#submenu-kurikulum').html("<label id=\"label-edit\">Edit</label>"+
                                    "<label class=\"switch\">"+
                                    "<input id=\"check-edit\" type=\"checkbox\">"+
                                    "<span class=\"slider round\"></span>"+
                                    "</label>"+
                                    "<input id=\"button-save\" type=\"submit\" value=\"SAVE\" form=\"form-kurikulum\" class=\"w3-button w3-round w3-blue button-pengeditan\">"+
                                    "<input id=\"button-cancel\" type=\"submit\" value=\"CANCEL\" class=\"w3-button w3-round w3-blue button-pengeditan\">"+
                                    "<input id=\"button-delete\" type=\"submit\" value=\"DELETE\" class=\"w3-button w3-round w3-blue button-pengeditan\"><br/>");
                    }
                    
                    $('.input-form').attr("readonly", "readonly");
                    $('#button-save').attr("disabled", "disabled");
                    $('#button-cancel').attr("disabled", "disabled");
                    $('#button-delete').attr("disabled", "disabled");
                    
                    $('#tahun-kurikulum').val(data.tahunKurikulum);
                    $('#jmlh-sks').val(data.jumlahSKS);
                    $('#jmlh-semester').val(data.jumlahSemester);
                    
                   if(data.listKelompokMatkul.length){
                       data.listKelompokMatkul.forEach(function(item){
                           
                            var html_mata_kuliah = "";
                            if(item.daftarMatkul.length){
                                item.daftarMatkul.forEach(function(item){
                                    html_mata_kuliah += "<li id=\"tipe-mata-kuliah\">"+
                                            "<a href=\'RecordMataKuliahKurikulum.jsp?no=0&id-kurikulum="+id_kurikulum+"&id-matkul="+item.kodeMatkul+"\'>"+item.namaMatkul+"</a></li>";
                                });
                                
                            }else{
                                html_mata_kuliah = "<li id=\"tipe-mata-kuliah\">"+
                                            "<a>Mata kuliah kosong</a></li>";
                            }
                           html_klmpk_mata_kuliah += "<li id=\"tipe-klmpk\">"+
                            "<a id=\'"+item.idKelompokMatkul+"\' href=\'RecordKelompokMataKuliah.jsp?id-kurikulum="+id_kurikulum+"&id-kelompok="+item.idKelompokMatkul+"\' class=\"load-mata-kuliah\">"+item.namaKelompokMatkul+"</a>"+
                            "<ul class=\'ul-mata-kuliah\' id=\"ul-mata-kuliah\" >"+html_mata_kuliah+"</ul>"+
                        "</li>";
                
                       });
                   } else{
                       html_klmpk_mata_kuliah += "<li id=\"tipe-klmpk\">"+
                            "<a class=\"load-mata-kuliah\">Kelompok Mata Kuliah Kosong</a>"+
                            "</li>";
                   }
                   $('#ul-klmpk-mata-kuliah').html(html_klmpk_mata_kuliah);
                   
                   /**Jika checkedit on*/
                    $('#check-edit').click(function(){
                        if($(this).prop("checked") === true){
                            $('.input-form').removeAttr("readonly");
                            $('#button-save').removeAttr("disabled");
                            $('#button-cancel').removeAttr("disabled");
                            $('#button-delete').removeAttr("disabled");

                        } else{
                            load_klmpk_mata_kuliah('<% out.print(idKurikulum); %>');
                        }
                    });
                    

                    $("#button-cancel").click(function(){
                        $('#check-edit').removeAttr("checked")
                        load_klmpk_mata_kuliah('<% out.print(idKurikulum); %>');
                    });

                    $('#button-delete').click(function(){
                        var konfirmasi = window.confirm("Hapus kurikulum ini?");
                        if(konfirmasi){
                            delete_kurikulum('<% out.print(idKurikulum); %>');
                        } else{

                        }
                    });

                }
            });
        }
        
        function delete_kurikulum(id = ''){
            $.ajax({
                url:"../DeleteKurikulum",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                    alert('Kurikulum berhasil dihapus!');
                    window.location = 'Kurikulum.jsp';
                }
            });
        }
        
        /** Memvalidasi input*/ 
        function validasi_input(form){
            if($('#tahun-kurikulum').val() == ""){
                alert("Tahun kurikulum  masih kosong!");
                $('#tahun-kurikulum').focus();
                return false;
            } else if($('#jmlh-sks').val() == ""){
                alert("Jumlah SKS  masih kosong!");
                $('#jmlh-sks').focus();
                return false;
            } else if($('#jmlh-semester').val() == ""){
                alert("Jumlah semester masih kosong!");
                $('#jmlh-semester').focus();
                return false;
            }
            
            var konfirmasi = window.confirm("Apakah data kurikulum sudah benar?\n\n\n"+
                    "Kurikulum Tahun         : "+$('#tahun-kurikulum').val()+"\n"+
                    "Jumlah SKS                 : "+$('#jmlh-sks').val()+"\n"+
                    "Jumlah Semester       : "+$('#jmlh-semester').val());
            if(konfirmasi){
                return true;
            }else{
                return false;
            }
            
        }  
    </script>
</html>