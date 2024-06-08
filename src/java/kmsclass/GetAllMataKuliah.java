/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kmsclass;

import com.mysql.jdbc.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetAllMataKuliah extends HttpServlet {

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
        
        String idKurikulum = request.getParameter("id_kurikulum");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        //Mendapatkan Semua Mata Kuliah yang dimuat kurikulum
        try{
            Connection koneksi = (Connection) Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT col_kode_matkul, col_nama_matkul "+
                "FROM tbl_matkul INNER JOIN tbl_klmpk_mata_kuliah ON(tbl_klmpk_mata_kuliah.col_id_klmpk_mata_kuliah "+
                "= tbl_matkul.col_id_klmpk_mata_kuliah) INNER JOIN tbl_kurikulum ON (tbl_kurikulum.col_id_kurikulum "+
                "= tbl_klmpk_mata_kuliah.col_id_kurikulum) WHERE tbl_kurikulum.col_id_kurikulum = ? ORDER BY col_nama_matkul ASC ");
            statement.setString(1, idKurikulum);
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(2);
                m.put("kodeMatkul", rs.getString("col_kode_matkul"));
                m.put("namaMatkul", rs.getString("col_nama_matkul"));
                
                ja.add(m);
            }
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        jo.put("listMatkul", ja);
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
