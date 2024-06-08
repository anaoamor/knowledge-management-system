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
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kmsclass.Koneksi;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetKelompokMataKuliah extends HttpServlet {

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
        
        String idKelompok = request.getParameter("id");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        //MENDAPATKAN DESKRIPSI KELOMPOK MATA KULIAH DAN DAFTAR MATA KULIAH
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT col_nama_klmpk_mata_kuliah, tbl_klmpk_mata_kuliah.col_jmlh_sks, col_creator FROM tbl_klmpk_mata_kuliah "+
                    "INNER JOIN tbl_kurikulum ON (tbl_kurikulum.col_id_kurikulum = tbl_klmpk_mata_kuliah.col_id_kurikulum) "+
                    "WHERE col_id_klmpk_mata_kuliah = ?";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idKelompok);
            ResultSet rs1 = prepare.executeQuery();
            while(rs1.next()){
                jo.put("creator", rs1.getString("col_creator"));
                jo.put("namaKelompok", rs1.getString("col_nama_klmpk_mata_kuliah"));
                jo.put("jumlahSKS", rs1.getInt("col_jmlh_sks"));
                
                String sql2 = "SELECT col_kode_matkul, col_nama_matkul FROM tbl_matkul "+
                        "WHERE col_id_klmpk_mata_kuliah = ?";
                prepare = koneksi.prepareStatement(sql2);
                prepare.setString(1, idKelompok);
                ResultSet rs2 = prepare.executeQuery();
                while(rs2.next()){
                    Map n = new LinkedHashMap(2);
                    n.put("kodeMatkul", rs2.getString("col_kode_matkul"));
                    n.put("namaMatkul", rs2.getString("col_nama_matkul"));
                    ja.add(n);
                }
                jo.put("listMatkul", ja);
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
