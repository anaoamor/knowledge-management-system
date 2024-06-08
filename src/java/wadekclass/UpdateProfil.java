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
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kmsclass.Koneksi;

/**
 *
 * @author ASUS
 */
public class UpdateProfil extends HttpServlet {
    
        String formatTglLahir;
        
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
        
        String idUser = request.getParameter("id");
        String tipeUser = request.getParameter("tipe");
        String nip = request.getParameter("nip");
        String nama = request.getParameter("nama");
        String tglLahir = getFormatTglLahir(request.getParameter("tgl_lahir"));
        String jenisKelamin = request.getParameter("jenis_kelamin");
        String noHp = request.getParameter("no_hp");
        String alamat = request.getParameter("alamat");
        String status = request.getParameter("status");
        String jabatan = request.getParameter("jabatan");
        String golongan = request.getParameter("golongan");
        String email = request.getParameter("email");
        
        //UPDATE RECORD WADEK KEMAHASISWAAN
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "UPDATE tbl_wadek_kemahasiswaan SET col_nip = ?, "+
                    "col_nama_wadek = ?, col_tgl_lahir = ?, col_jenis_kelamin = ?, "+
                    "col_no_hp = ?, col_alamat = ?, col_status = ?, col_jabatan = ?, "+
                    "col_golongan = ?, col_email = ? WHERE col_nip = ?";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, nip);
            prepare.setString(2, nama);
            prepare.setString(3, tglLahir);
            prepare.setString(4, jenisKelamin);
            prepare.setString(5, noHp);
            prepare.setString(6, alamat);
            prepare.setString(7, status);
            prepare.setString(8, jabatan);
            prepare.setString(9, golongan);
            prepare.setString(10, email);
            prepare.setString(11, idUser);
            
            int i = prepare.executeUpdate();
            if(i > 0){
                HttpSession session = request.getSession();
                session.setAttribute("idUser", nip);
            }
            
            out.println("<script>window.location = \'WadekKemahasiswaan/User.jsp\';</script>");
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

    /**
     * Mengembalikan format tanggal untuk MySQL
     */
    public String getFormatTglLahir(String tglLahir){
        formatTglLahir = tglLahir.substring(6, 10)+String.valueOf(tglLahir.charAt(5))+tglLahir.substring(3,5)+
                String.valueOf(tglLahir.charAt(2))+tglLahir.substring(0,2);
        
        return formatTglLahir;
    }
}
