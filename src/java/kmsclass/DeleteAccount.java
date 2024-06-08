/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kmsclass;

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
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class DeleteAccount extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        //DELETE USER ACCOUNT
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            
            //DELETE MESSAGE USER
            String sql1 = "DELETE FROM tbl_message WHERE col_pengirim = \'"+idUser+"\' OR "+
                    "col_penerima = \'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql1);
            int i = prepare.executeUpdate();
            
            //DELETE MATERI KULIAH YANG DIUPLOAD USER
            String sql2 = "DELETE FROM tbl_materi_kuliah WHERE col_nim = \'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql2);
            int j = prepare.executeUpdate();
            
            //DELETE REQUEST DAN RESPON MATERI KULIAH
            String sql3 = "SELECT col_id_req FROM tbl_req_materi_kuliah WHERE col_nim = \'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql3);
            ResultSet rs3 = prepare.executeQuery();
            while(rs3.next()){
                String sql4 = "DELETE FROM tbl_req_materi_kuliah WHERE col_id_req = \'"+rs3.getString("col_id_req")+"\'";
                prepare = koneksi.prepareStatement(sql4);
                int k = prepare.executeUpdate();
                
                String sql5 = "DELETE FROM tbl_respon_req_mk WHERE col_id_req = \'"+rs3.getString("col_id_req")+"\'";
                prepare = koneksi.prepareStatement(sql5);
                int m = prepare.executeUpdate();
            }
            
            //DELETE FEEDBACK DAN RESPONNYA
            String sql6 = "SELECT col_id_fb FROM tbl_fb WHERE col_nim = \'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql6);
            ResultSet rs6 = prepare.executeQuery();
            while(rs6.next()){
                String sql7 = "DELETE FROM tbl_fb WHERE col_id_fb = \'"+rs6.getString("col_id_fb")+"\'";
                prepare = koneksi.prepareStatement(sql7);
                int n = prepare.executeUpdate();
                
                String sql8 = "DELETE FROM tbl_respon_fb WHERE col_id_fb = \'"+rs6.getString("col_id_fb")+"\'";
                prepare = koneksi.prepareStatement(sql8);
                int o = prepare.executeUpdate();
            }
            
            //DELETE FORUM DISKUSI DAN YANG TERKAIT
            String sql7 = "SELECT col_id_fd FROM tbl_fd WHERE col_creator = \'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql7);
            ResultSet rs7 = prepare.executeQuery();
            while(rs7.next()){
                String sql9 = "DELETE FROM tbl_fd WHERE col_id_fd = \'"+rs7.getString("col_id_fd")+"\'";
                prepare = koneksi.prepareStatement(sql9);
                int p = prepare.executeUpdate();
                
                String sql10 = "DELETE FROM tbl_komentar WHERE col_id_fd = \'"+rs7.getString("col_id_fd")+"\'";
                prepare = koneksi.prepareStatement(sql10);
                int q = prepare.executeUpdate();
                
                String sql11 = "DELETE FROM tbl_peserta_fd WHERE col_id_fd = \'"+rs7.getString("col_id_fd")+"\'";
                prepare = koneksi.prepareStatement(sql11);
                int r = prepare.executeUpdate();
                
                String sql12 = "DELETE FROM tbl_read_komentar WHERE col_id_fd = \'"+rs7.getString("col_id_fd")+"\'";
                prepare = koneksi.prepareStatement(sql12);
                int s = prepare.executeUpdate();
                
            }
            
            //DELETE KOMENTAR USER PADA FORUM DISKUSI
            String sql13 = "SELECT col_id_komentar FROM tbl_komentar WHERE col_id_komentator = "+
                    "\'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql13);
            ResultSet rs13 = prepare.executeQuery();
            while(rs13.next()){
                String sql14 = "DELETE FROM tbl_komentar WHERE col_id_komentar = \'"+rs13.getString("col_id_komentar")+"\'";
                prepare = koneksi.prepareStatement(sql14);
                int t = prepare.executeUpdate();
                
                String sql15 = "DELETE FROM tbl_read_komentar WHERE col_id_komentar = \'"+rs13.getString("col_id_komentar")+"\'";
                prepare = koneksi.prepareStatement(sql15);
                int u = prepare.executeUpdate();
            }
            
            //DELETE NOTIFIKASI FORUM DISKUSI
            String sql16 = "DELETE FROM tbl_peserta_fd WHERE col_id_peserta = "+
                    "\'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql16);
            int w = prepare.executeUpdate();
            
            String sql17 = "DELETE FROM tbl_read_komentar WHERE col_id_peserta = "+
                    "\'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql17);
            int x = prepare.executeUpdate();
            
            String sql18 = "DELETE FROM tbl_mahasiswa WHERE col_nim = \'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql18);
            int y = prepare.executeUpdate();
            
            String sql19 = "DELETE FROM tbl_user WHERE col_id_user = \'"+idUser+"\'";
            prepare = koneksi.prepareStatement(sql19);
            int z = prepare.executeUpdate();
            
            out.println(x);
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

}
