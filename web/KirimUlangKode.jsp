<%-- 
    Document   : KirimUlangKode
    Created on : Sep 6, 2019, 12:05:20 PM
    Author     : ASUS
--%>

<%! String nim; %>
<% nim = request.getParameter("nim"); %>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
                if (form.email.value == ""){
                    alert("E-mail masih kosong!");
                    form.email.focus();
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
                <h2 class="w3-center">Konfirmasi E-Mail</h2>
                
                <form action="UpdateEmailRegistrasi?nim=<% out.print(nim); %>" method="post" onsubmit="return validation(this)">
                    <!-- TEXTFIELD KODE KONFIRMASI -->

                    <h4 for="kode">Silahkan periksa ulang e-mail kamu!</h4>
                    <input type="text" id="email" name="email">
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
    
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            load_email('<% out.print(nim); %>');
        });
        
        function load_email(id = ''){
            $.ajax({
                url:"GetEmailMahasiswa",
                method:"POST",
                data:{id: id},
                dataType:"json",
                success:function(data){
                  $('#email').val(data.email);
                }
            });
        }
    </script>
</html>
