<%-- 
    Document   : RegistrasiError
    Created on : Jul 1, 2019, 11:44:59 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KMS Mahasiswa SI</title>
        
        <!-- style untuk pop up -->
        <style>
            body {font-family: Arial, Helvetica, sans-serif;}
            * {box-sizing: border-box;}
            
            /* The popup form */
            .form-popup {
                position: fixed;
                top: 100px;
                right: 500px;
                left: 500px;
                border: 3px solid #f1f1f1;
                z-index: 9;
            }
            
            /* Add styles to the form container */
            .form-container {
                max-width: 300px;
                padding: 10px;
                background-color: white;
            }
            
            /* Set a style for the submit/login button */
            .form-container .btn{
                background-color: #4CAF50;
                color: white;
                padding: 16px 20px;
                border: none;
                cursor: pointer;
                margin-bottom: 10px;
                opacity: 0.8;
            }
            
            /* Add some hover effects to buttons */
            .form-container .btn:hover{
                opacity: 1;
            }
            
        </style>
        
    </head>
    
    <body>
        
        <div class="form-popup" id="myForm" align="center">
            <form action="LoginRegistrasi.jsp" class="form-container" method="post" >
                <h3>Maaf, terjadi kesalahan. Silahkan registrasi ulang!</h3>
                <input type="submit" class="btn" name="menu" value="DAFTAR" >
            </form>
        </div>
        
    </body>
</html>
