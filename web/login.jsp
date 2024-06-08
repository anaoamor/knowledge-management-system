<%-- 
    Document   : login
    Created on : Jun 20, 2019, 4:24:35 AM
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
            h5{
                font-size: 15px;
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
              width: 100%;
              padding: 12px 20px;
              margin: 8px 0;
              display: inline-block;
              border: 1px solid #ccc;
              border-radius: 4px;
              box-sizing: border-box;
            }

            input[type=submit] {
              width: 100%;
              background-color: #4CAF50;
              color: white;
              padding: 14px 20px;
              margin: 8px 0;
              border: none;
              border-radius: 4px;
              cursor: pointer;
            }

            input[type=submit]:hover {
              background-color: #45a049;
            }
            
        </style>
        <title>SIGN IN</title>
    </head>
    
    <body>
       <div class="w3-row w3-white" >
            
            <div class="w3-container w3-white w3-threequarter">
                <h1>KMS Mahasiswa SI</h1>
            </div>
           
           <div class="w3-container w3-white w3-quarter w3-row-padding">
                <div class="w3-col s6 w3-padding-16">
                    <form>
                        <input type="submit" value="DAFTAR" class="w3-button w3-round w3-black w3-right ">
                    </form>
                </div>
                <div class="w3-col s6 w3-padding-16">
                    <form action="login.jsp">
                    <input type="submit" value="LOG IN" class="w3-button w3-round w3-black w3-right" >
                    </form>
                </div>
            </div>
        </div>

        <div class="pembungkus">
            <img src="book.jpg" alt="BOOK" style="width:device-width; height: 934px">
            <div class="w3-container w3-white w3-round-large layer-transparent">
                <h1 class="w3-center">SIGN IN</h1>
                
                <form>
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Username">

                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Password">
                    
                    <input type="submit" name="login" value="Log In">
                    <h5 class="w3-right"><u>Lupa Password</u></h5>
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
