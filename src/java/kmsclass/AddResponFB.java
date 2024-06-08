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
public class AddResponFB extends HttpServlet {

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

        String idFB = request.getParameter("id-fb");
        String responFB = request.getParameter("respon");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        //INSERT RESPON FEEDBACK
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "INSERT INTO tbl_respon_fb (col_detail_respon_fb, col_tgl, "+
                    "col_waktu, col_id_fb, col_responden, col_status) VALUES (?, NOW(), NOW(), ?, ?, 0)";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, responFB);
            prepare.setString(2, idFB);
            prepare.setString(3, idUser);
            int i = prepare.executeUpdate();
            
            //UPDATE tbl_fb.col_timestampt
            String sql2 = "Update tbl_fb SET col_timestamp = NOW() WHERE col_id_fb = ?";
            prepare = koneksi.prepareStatement(sql2);
            prepare.setString(1, idFB);
            int j = prepare.executeUpdate();
            
            if(j > 0){
                out.println("<script>window.location = \'RecordFB.jsp?id-fb="+idFB+"\';</script>");
            }
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
