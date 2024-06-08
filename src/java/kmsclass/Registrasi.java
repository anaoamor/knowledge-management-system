package kmsclass;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
public class Registrasi extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter(); //Not used
        
        String noBeforePage = request.getParameter("no");
        
        String nim = request.getParameter("nim");
        String namaMahasiswa = request.getParameter("nama");
        String tglLahir = request.getParameter("tgl_lahir");
        String jenisKelamin = request.getParameter("jenis_kelamin");
        String noHp = request.getParameter("no_hp");
        String alamat = request.getParameter("alamat");
        String angkatan = request.getParameter("angkatan");
        String status = request.getParameter("status");
        String agama = request.getParameter("agama");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String perguruanTinggi = request.getParameter("perguruan_tinggi");
        
        Mahasiswa mahasiswa = new Mahasiswa(nim, namaMahasiswa, tglLahir, jenisKelamin, noHp, alamat, angkatan,
        status, agama, email, username, password, perguruanTinggi);
        
        int registrasi = mahasiswa.registrasi(nim, namaMahasiswa, tglLahir, jenisKelamin, noHp, alamat, angkatan, status, agama, email, username, password, perguruanTinggi);
        
        if(registrasi > 0){
            if(noBeforePage.equals("0"))
                response.sendRedirect("MenungguKode.jsp");
            else
                response.sendRedirect("Admin/RegistrasiMahasiswa.jsp");
        } else{
            response.sendRedirect("RegistrasiError.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
