/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adminclass;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kmsclass.Koneksi;

/**
 *
 * @author ASUS
 */
public class UpdateFakultas extends HttpServlet {

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

        String idPT = request.getParameter("id-pt");
        String idFakultas = request.getParameter("id-fakultas");
        String namaFakultas = request.getParameter("nama-fakultas");
        String alamat = request.getParameter("alamat");
        String noTelepon = request.getParameter("no-telepon");
        String email = request.getParameter("email");
        
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "UPDATE tbl_fakultas SET col_nama_fakultas = ?, col_alamat_fakultas = ?, col_no_telp_fakultas = ?, "+
                    "col_email_fakultas = ? WHERE col_id_fakultas = ?";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, namaFakultas);
            prepare.setString(2, alamat);
            prepare.setString(3, noTelepon);
            prepare.setString(4, email);
            prepare.setString(5, idFakultas);
            int i = prepare.executeUpdate();
            if(i > 0 ){
                out.println("<script> window.location = \'Admin/RecordFakultas.jsp?id-pt="+idPT+"&id-fakultas="+idFakultas+"\';</script>");
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
