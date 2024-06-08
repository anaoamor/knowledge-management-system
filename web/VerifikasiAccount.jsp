<%-- 
    Document   : VerifikasiAccount
    Created on : Sep 5, 2019, 5:08:12 PM
    Author     : ASUS
--%>

<%! String nim; %>
<% nim = request.getParameter("nim"); %>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="w3.css">
        <style type="text/css">
            .pembungkus{
                position: relative;
            }
            h2{
                margin-bottom: 30px;
            }
            h4{
                margin-left: 176px;
            }
            .layer-transparent{
                opacity: 0.9;
                filter: alpha(opacity=90);/* For IE8 and earlier*/
                position: fixed;
                left: 300px;
                right: 300px;
                top: 150px;
                
            }
            /* From w3shcools*/
            input[type=text], 
            input[type=password]{
              width: 50%;
              padding: 12px 20px;
              margin: 8px 0;
              margin-left: 176px;
              margin-right: 176px;
              display: inline-block;
              border: 1px solid #ccc;
              border-radius: 4px;
              box-sizing: border-box;
            }

            input[type=submit] {
              width: 30%;
              background-color: #4CAF50;
              color: white;
              padding: 14px 20px;
              margin: 8px 0;
              margin-left: 250px;
              margin-right: 250px;
              margin-top: 50px;
              margin-bottom: 20px;
              border: none;
              border-radius: 4px;
              cursor: pointer;
            }
            #link-kirim-ulang-kode{
                font-size: 10pt;
                margin-left: 420px;
            }
            #link-kirim-ulang-kode:hover{
                color: gray;
            }
            input[type=submit]:hover {
              background-color: #45a049;
            }
        </style>
        
        <title>KMS Mahasiswa SI</title>
    </head>
    
    <body>
        <!-- Script Untuk validasi input-->
        <script type="text/javascript">
            function validation(form){
                if (form.kode.value == ""){
                    alert("Kode konfirmasi masih kosong!");
                    form.kode.focus();
                    return (false);
                } 
                
                return true;
            }
            
        </script>
       
        <div class="w3-row w3-white" >
            
            <div class="w3-container w3-white w3-threequarter">
                <h1>KMS Mahasiswa SI</h1>
            </div>
           
        </div>

        <div class="pembungkus">
            <img src="book.jpg" alt="BOOK" style="width:device-width; height: 934px">
            <div class="w3-container w3-white w3-round-large layer-transparent">
                <h2 class="w3-center">REGISTRASI</h2>
                
                <form action="VerifikasiKode?nim=<% out.print(nim); %>" method="post" onsubmit="return validation(this)">
                    <!-- TEXTFIELD KODE KONFIRMASI -->

                    <h4 for="kode">Silahkan masukkan kode konfirmasi:</h4>
                    <input type="text" id="kode" name="kode">
                    <a href="KirimUlangKode.jsp?nim=<% out.print(nim); %>" id="link-kirim-ulang-kode"><u>Kirim Ulang Kode</u></a>
                    
                    <input type="submit" name="submit" value="Submit">
                </form>
                
            </div>
        </div>
        
        <div class="w3-container w3-white w3-center w3-bottom">
            <footer >
                <h6>© 2019 AMO. All rights reserved</h6>
            </footer>
        </div>
        
    </body>
</html>
