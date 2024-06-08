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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class SendMessage extends HttpServlet {

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
        int idLevelUser = (int) session.getAttribute("tipeUser");
        String idResponden = request.getParameter("id-responden");
        String idLevelResponden = request.getParameter("id-level");
        String message = request.getParameter("message");
        
        //INSERT MESSAGE
        try{
            Connection koneksi = Koneksi.getKoneksi();
            String sql = "INSERT INTO tbl_message(col_detail_message, col_tgl_message, col_waktu, "+
                    "col_pengirim, col_penerima, col_status, col_jenis_pengirim, col_jenis_penerima) "+
                    "VALUES (?, NOW(), NOW(), ?, ?, 0, ?, ?)";
            PreparedStatement prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, message);
            prepare.setString(2, idUser);
            prepare.setString(3, idResponden);
            prepare.setInt(4, idLevelUser);
            prepare.setString(5, idLevelResponden);
            int i = prepare.executeUpdate();
            
            String nextPage = "";
            switch(idLevelUser){
                case 0:{
                    nextPage = "RecordMessage.jsp";
                    break;
                } case 1:{
                    nextPage = "WadekKemahasiswaan/RecordMessage.jsp";
                    break;
                } case 2:{
                    nextPage = "KaprodiSI/RecordMessage.jsp";
                    break;
                } default:{
                    nextPage = "Admin/RecordMessage.jsp";
                    break;
                }
            }
            out.println("<script>window.location = \'"+nextPage+"?id-responden="+idResponden+"&id-level="+idLevelResponden+"';</script>");
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
