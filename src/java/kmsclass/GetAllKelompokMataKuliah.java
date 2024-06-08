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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
public class GetAllKelompokMataKuliah extends HttpServlet {

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
        
        String idKurikulum = request.getParameter("id");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();

        //MENDAPATKAN SEMUA DESKRIPSI KURIKULUM DAN DAFTAR KELOMPOK MATA KULIAH
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            
            String sql3 = "SELECT col_tahun, col_jmlh_sks, col_jmlh_sem, col_creator FROM tbl_kurikulum "+
                    "WHERE col_id_kurikulum = ?";
            prepare = koneksi.prepareStatement(sql3);
            prepare.setString(1, idKurikulum);
            ResultSet rs3 = prepare.executeQuery();
            while(rs3.next()){
                DateFormat dateFormat = new SimpleDateFormat("YYYY");
                String tahunKurikulum = dateFormat.format(rs3.getDate("col_tahun"));
                jo.put("tahunKurikulum", tahunKurikulum);
                jo.put("jumlahSKS", rs3.getString("col_jmlh_sks"));
                jo.put("jumlahSemester", rs3.getString("col_jmlh_sem"));
                jo.put("creator", rs3.getString("col_creator"));
            }
            
            String sql1 = "SELECT col_id_klmpk_mata_kuliah, col_nama_klmpk_mata_kuliah FROM tbl_klmpk_mata_kuliah "+
                    "WHERE col_id_kurikulum = ?";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idKurikulum);
            ResultSet rs1 = prepare.executeQuery();
            while(rs1.next()){
                Map m = new LinkedHashMap(3);
                m.put("idKelompokMatkul", rs1.getString("col_id_klmpk_mata_kuliah"));
                m.put("namaKelompokMatkul", rs1.getString("col_nama_klmpk_mata_kuliah"));
                
                //MENDAPATKAN SEMUA MATA KULIAH
                JSONArray jaMatkul = new JSONArray();
                String sql2 = "SELECT col_kode_matkul, col_nama_matkul FROM tbl_matkul "+
                        "WHERE col_id_klmpk_mata_kuliah = ? ORDER BY col_nama_matkul ASC";
                prepare = koneksi.prepareStatement(sql2);
                prepare.setString(1, rs1.getString("col_id_klmpk_mata_kuliah"));
                ResultSet rs2 = prepare.executeQuery();
                while(rs2.next()){
                    Map m2 = new LinkedHashMap(2);
                    m2.put("kodeMatkul", rs2.getString("col_kode_matkul"));
                    m2.put("namaMatkul", rs2.getString("col_nama_matkul"));
                    jaMatkul.add(m2);
                }
                m.put("daftarMatkul", jaMatkul);
                ja.add(m);
            }
            
            jo.put("listKelompokMatkul", ja);
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
