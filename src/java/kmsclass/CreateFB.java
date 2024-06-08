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
public class CreateFB extends HttpServlet {

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

        String topikFB = request.getParameter("topik-fb");
        String deskripsi = request.getParameter("deskripsi");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        //INSERT FEEDBACK
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "INSERT INTO tbl_fb(col_topik_fb, col_detail_fb, col_tgl, "+
                    "col_waktu, col_status, col_nim, col_read_admin, col_timestamp) VALUES (?, ?, NOW(), NOW(), \'Menunggu\', "+
                    "?, 0, NOW())";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, topikFB);
            prepare.setString(2, deskripsi);
            prepare.setString(3, idUser);
            
            int i = prepare.executeUpdate();
            
            //MENDAPATKAN ID FEEDBACK TERAKHIR
            String sql2 = "SELECT col_id_fb FROM tbl_fb ORDER BY col_id_fb DESC LIMIT 1";
            prepare = koneksi.prepareStatement(sql2);
            ResultSet rs2 = prepare.executeQuery();
            while(rs2.next()){
                out.println("<script>window.location = \'RecordFB.jsp?id-fb="+rs2.getString("col_id_fb")+"\';</script>");
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
