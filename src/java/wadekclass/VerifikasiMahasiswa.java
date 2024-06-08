/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wadekclass;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kmsclass.Koneksi;
import kmsclass.SendEmail;

/**
 *
 * @author ASUS
 */
public class VerifikasiMahasiswa extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        
        String nim = request.getParameter("nim");
        String email = request.getParameter("email");

        //UPDATE KODE VERIFIKASI TABLE MAHASISWA
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String kode = generateKodeVerifikasi();
            String sql = "UPDATE tbl_mahasiswa SET col_kode_verifikasi = ? "+
                    "WHERE col_nim = ?";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, kode);
            prepare.setString(2, nim);
            int i = prepare.executeUpdate();
            if(i > 0){
                //Send Kode Verifikasi Ke Email Mahasiswa
                SendEmail.sendKodeVerifikasi(nim, email, kode);
            }
            out.println("<script>alert(\'Kode verifikasi telah dikirimkan!\'); location.href = \'WadekKemahasiswaan/RegistrasiMahasiswa.jsp\';</script>");
        }catch(SQLException ex){
            out.println(ex.getMessage());
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

    public String generateKodeVerifikasi(){
        String numericString = "1234567890";
        int count = 4;
        StringBuilder builder = new StringBuilder();
        
        while(count-- != 0){
            int character = (int) (Math.random() * numericString.length());
            builder.append(numericString.charAt(character));
        }
        
        return builder.toString();
    }
}
