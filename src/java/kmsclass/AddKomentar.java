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
public class AddKomentar extends HttpServlet {

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
        
        String idFD = request.getParameter("id-fd");
        String komentarFD = request.getParameter("komentar");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            //INSERT KOMENTAR
            String sql1 = "INSERT INTO tbl_komentar(col_detail_komentar, col_tgl, col_waktu, "+
                    "col_id_fd, col_id_komentator) VALUES(?, NOW(), NOW(), ?, ?)";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, komentarFD);
            prepare.setString(2, idFD);
            prepare.setString(3, idUser);
            int i = prepare.executeUpdate();
            
            //MENDAPATKAN ID KOMENTAR TERAKHIR
            String sql2 = "SELECT col_id_komentar FROM tbl_komentar ORDER BY col_id_komentar DESC LIMIT 1";
            prepare = koneksi.prepareStatement(sql2);
            ResultSet rs2 = prepare.executeQuery();
            String idKomentar = "";
            
            while(rs2.next()){
                idKomentar = rs2.getString("col_id_komentar");
            }
            
            //MENDAPATKAN SEMUA DAFTAR ID PESERTA FORUM DISKUSI
            String sql3 = "SELECT col_id_peserta FROM tbl_peserta_fd WHERE col_id_fd = ?";
            prepare = koneksi.prepareStatement(sql3);
            prepare.setString(1, idFD);
            ResultSet rs3 = prepare.executeQuery();
            int j = 0;
            
            while(rs3.next()){
                if(!rs3.getString("col_id_peserta").equals(idUser)){
                    String sql4 = "INSERT INTO tbl_read_komentar VALUES (?, ?, 0, ?)";
                    prepare = koneksi.prepareStatement(sql4);
                    prepare.setString(1, idKomentar);
                    prepare.setString(2, rs3.getString("col_id_peserta"));
                    prepare.setString(3, idFD);
                    int m = prepare.executeUpdate();
                }else{
                    j++;
                }
            }
            
            if(j == 0){
                String sql4 = "INSERT INTO tbl_peserta_fd VALUES (?, ?)";
                prepare = koneksi.prepareStatement(sql4);
                prepare.setString(1, idFD);
                prepare.setString(2, idUser);
                
                int k = prepare.executeUpdate();
            }
            
            //MENDAPATKAN ID LEVEL USER
            int idLevelUser = 0;
            String sql5 = "SELECT col_id_level FROM tbl_user WHERE col_id_user = ?";
            prepare = koneksi.prepareStatement(sql5);
            prepare.setString(1, idUser);
            ResultSet rs5 = prepare.executeQuery();
            while(rs5.next()){
                idLevelUser = rs5.getInt("col_id_level");
            }

            String nextPage = "";
            switch(idLevelUser){
                case 0:{
                    nextPage = "RecordFD.jsp";
                    break;
                } case 2:{
                    nextPage = "KaprodiSI/RecordFD.jsp";
                    break;
                } default:{
                    nextPage = "Admin/RecordFD.jsp";
                }
            }
            out.println("<script>window.location = \'"+nextPage+"?id-fd="+idFD+"\';</script>");
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
