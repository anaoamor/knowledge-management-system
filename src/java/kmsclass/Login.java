package kmsclass;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipeUser = request.getParameter("user");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        PrintWriter output = null;//not used
        User user = new User(tipeUser, username, password);
        HttpSession session;
        
        response.setContentType("text/html;charset=UTF-8");
        output = response.getWriter();//not used
        
        //Menentukan jenis service yang diberikan kepada user
        int jenisService = user.autentifikasi(tipeUser, username, password);
        String idUser = user.getIdUser();
        
        //Mahasiswa
        switch (jenisService) {
            case 0:
                session = request.getSession(true);
                session.setAttribute("idUser", idUser);
                session.setAttribute("tipeUser", jenisService);
                response.sendRedirect("HomeMahasiswa.jsp");
                break;
            case 2:
                session = request.getSession(true);
                session.setAttribute("idUser", idUser);
                session.setAttribute("tipeUser", jenisService);
                response.sendRedirect("KaprodiSI/Home.jsp");
                break;
            case 1:
                session = request.getSession(true);
                session.setAttribute("idUser", idUser);
                session.setAttribute("tipeUser", jenisService);
                response.sendRedirect("WadekKemahasiswaan/Home.jsp");
                break;
            case 3:
                session = request.getSession(true);
                session.setAttribute("idUser", idUser);
                session.setAttribute("tipeUser", jenisService);
                response.sendRedirect("Admin/Home.jsp");
                break;
            default:
                //page jsp baru, pop up user akun invalid dan kembali ke LoginRegipstrasi.js
                response.sendRedirect("PageUserPasswordInvalid.jsp");
                break;
        }
              
    }

     public void doPost(HttpServletRequest request, HttpServletResponse
             response) throws ServletException, IOException{
         doGet(request, response);
     }
}
