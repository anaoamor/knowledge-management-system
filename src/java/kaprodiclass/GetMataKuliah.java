/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kaprodiclass;

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
import kmsclass.Koneksi;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetMataKuliah extends HttpServlet {

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

        String kodeMatkul = request.getParameter("id");
        
        JSONObject jo = new JSONObject();
        
        //MENDAPATKAN RECORD MATA KULIAH
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "SELECT col_nama_matkul, col_sks, col_deskripsi_matkul, col_prasyarat, "+
                    "col_standar_kompetensi, col_creator FROM tbl_matkul INNER JOIN tbl_klmpk_mata_kuliah "+
                    "ON (tbl_klmpk_mata_kuliah.col_id_klmpk_mata_kuliah = tbl_matkul.col_id_klmpk_mata_kuliah) "+
                    "INNER JOIN tbl_kurikulum ON (tbl_kurikulum.col_id_kurikulum = tbl_klmpk_mata_kuliah.col_id_kurikulum) "+
                    "WHERE col_kode_matkul = ?";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, kodeMatkul);
            ResultSet rs = prepare.executeQuery();
            while(rs.next()){
                jo.put("namaMatkul", rs.getString("col_nama_matkul"));
                jo.put("sks", rs.getInt("col_sks"));
                jo.put("deskripsi", rs.getString("col_deskripsi_matkul"));
                jo.put("prasyarat", rs.getString("col_prasyarat"));
                jo.put("standarKompetensi", rs.getString("col_standar_kompetensi"));
                jo.put("creator", rs.getString("col_creator"));
            }
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        out.println(jo.toJSONString());
        
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
