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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;
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
public class NotifikasiMateriBaru extends HttpServlet {

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

        String idUser = request.getParameter("id");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        //MENDAPATKAN NOTIFIKASI
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT col_id_materi_kuliah, col_nama, col_deskripsi, col_tgl_upload, "+
                    "col_nama_matkul FROM tbl_materi_kuliah INNER JOIN tbl_matkul ON (tbl_matkul.col_kode_matkul = "+
                    "tbl_materi_kuliah.col_kode_matkul) INNER JOIN tbl_klmpk_mata_kuliah ON "+
                    "(tbl_klmpk_mata_kuliah.col_id_klmpk_mata_kuliah = tbl_matkul.col_id_klmpk_mata_kuliah) "+
                    "INNER JOIN tbl_kurikulum ON (tbl_kurikulum.col_id_kurikulum = tbl_klmpk_mata_kuliah.col_id_kurikulum) "+
                    "INNER JOIN tbl_prodi_si ON (tbl_prodi_si.col_id_kurikulum = tbl_kurikulum.col_id_kurikulum) "+
                    "INNER JOIN tbl_kaprodi_si ON (tbl_kaprodi_si.col_nip = tbl_prodi_si.col_nip) WHERE "+
                    "tbl_kaprodi_si.col_nip = \'"+idUser+"\' AND tbl_materi_kuliah.col_nip IS NULL "+
                    "ORDER BY col_id_materi_kuliah DESC";
            prepare = koneksi.prepareStatement(sql1);
            ResultSet rs1 = prepare.executeQuery();
            
            while(rs1.next()){
                Map m = new LinkedHashMap(5);
                m.put("namaMatkul", rs1.getString("col_nama_matkul"));
                m.put("idMateriKuliah", rs1.getString("col_id_materi_kuliah"));
                m.put("namaMateri", rs1.getString("col_nama"));
                m.put("deskripsi", rs1.getString("col_deskripsi"));
                //MENDAPATKAN WAKTU UPLOAD MATERI KULIAH
                DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                String stringTgl = dateFormat.format(rs1.getDate("col_tgl_upload"));
                m.put("tglUpload", stringTgl);
                
                ja.add(m);
            }
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        jo.put("notifikasi", ja);
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
