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
public class AddResponRequest extends HttpServlet {

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
            
        String idRequest = request.getParameter("id-request");
        String respon = request.getParameter("komentar");
        
        //INSERT RESPON TERHADAP REQUEST MATERI KULIAH
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "INSERT INTO tbl_respon_req_mk (col_detail_res_req_mk, col_tgl_respon_req_mk, "
                    + "col_waktu_respon_req, col_id_req, col_status) VALUES (\'"+respon+"\', now(), now(), "+idRequest+", 0)";
            prepare = koneksi.prepareStatement(sql1);
            
            int i = prepare.executeUpdate();
            
            //UPDATE TIMESTAMP REQUEST MATERI KULIAH
            String sql2 = "UPDATE tbl_req_materi_kuliah SET col_timestamp = NOW() "+
                    "WHERE col_id_req = ?";
            prepare = koneksi.prepareStatement(sql2);
            prepare.setString(1, idRequest);
            int j = prepare.executeUpdate();
            
            if(j > 0){
                out.println("<script>window.location = \'RecordRequest.jsp?id-req="+idRequest+"\';</script>");
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
