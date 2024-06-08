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
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
public class DeleteFD extends HttpServlet {

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
        
        String idFD = request.getParameter("id");
        
        //DELETE FORUM DISKUSI
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            
            String sql1 = "DELETE FROM tbl_fd WHERE col_id_fd = \'"+idFD+"\'";
            prepare = koneksi.prepareStatement(sql1);
            int i = prepare.executeUpdate(sql1);
            
            String sql2 = "DELETE FROM tbl_komentar WHERE col_id_fd = \'"+idFD+"\'";
            prepare = koneksi.prepareStatement(sql2);
            int j = prepare.executeUpdate(sql2);
            
            String sql3 = "DELETE FROM tbl_peserta_fd WHERE col_id_fd = \'"+idFD+"\'";
            prepare = koneksi.prepareStatement(sql3);
            int k = prepare.executeUpdate(sql3);
            
            String sql4 = "DELETE FROM tbl_read_komentar WHERE col_id_fd = \'"+idFD+"\'";
            prepare = koneksi.prepareStatement(sql4);
            int m = prepare.executeUpdate(sql4);
            
            out.println(m);
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
