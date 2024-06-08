<%-- 
    Document   : CheckEmailForgotPassword
    Created on : Jul 4, 2019, 4:31:47 AM
    Author     : ASUS
--%>

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
            p{
                position:absolute;
                left: 40px;
                top: 150px;
                opacity: 0.7;
                filter: alpha(opacity=70);/* For IE8 and earlier*/
            }
            h6{
                font-size:10px;
            }
            h2{
                margin-bottom:40px;
            }
            .layer-transparent{
                opacity: 0.9;
                filter: alpha(opacity=90);/* For IE8 and earlier*/
                position: fixed;
                left: 300px;
                right: 300px;
                top: 150px;
            }
            

            input[type=submit] {
              width: 20%;
              background-color: #4CAF50;
              color: white;
              padding: 14px 20px;
              margin: 8px 0;
              margin-top: 30px;
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
       <div class="w3-row w3-white" >
            
            <div class="w3-container w3-white w3-threequarter">
                <h1>KMS Mahasiswa SI</h1>
            </div>
           
        </div>

        <div class="pembungkus">
            <img src="book.jpg" alt="BOOK" style="width:device-width; height: 934px">
            <div class="w3-container w3-white w3-round-large layer-transparent">
                <h2 class="w3-center">Check Your E-Mail</h2>
                
                <h4>Kami telah mereset password account kamu.</h4>
                <h4>Silahkan cek e-mail untuk password yang baru!</h4>
                
                <form action="index.html" class="w3-center">
                    <div class="group">
                        <input type="submit" class="button" value="OK">
                    </div>
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
