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
public class UpdateFD extends HttpServlet {

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
        String topikFD = request.getParameter("topik");
        String subbidangFD = request.getParameter("subbidang");
        String deskripsiFD = request.getParameter("deskripsi");
        
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        //UPDATE RECORD FORUM DISKUSI
        try{
            Connection koneksi =Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "UPDATE tbl_fd SET col_topik_fd = ?, col_subbidang_diskusi = ?, "+
                    "col_deskripsi_fd = ? WHERE col_id_fd = ?";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, topikFD);
            prepare.setString(2, subbidangFD);
            prepare.setString(3, deskripsiFD);
            prepare.setString(4, idFD);
            
            int i = prepare.executeUpdate();
            
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
            out.println("<script>alert(\'Forum diskusi berhasil diupdate!\'); window.location = \'"+nextPage+"?id-fd="+idFD+"\';</script>");
            
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
