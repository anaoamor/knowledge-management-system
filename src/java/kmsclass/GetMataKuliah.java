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
        
        String kodeMatkul = request.getParameter("kode");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        JSONObject jo = new JSONObject();
        
        //MENDAPATKAN DESKRIPSI MATA KULIAH
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            
            String sql = "SELECT col_nama_klmpk_mata_kuliah, tbl_matkul.col_kode_matkul, "+
            "col_nama_matkul, col_sks, col_deskripsi_matkul, col_prasyarat, col_standar_kompetensi, col_id_kurikulum "+
            "FROM tbl_klmpk_mata_kuliah INNER JOIN tbl_matkul ON (tbl_matkul.col_id_klmpk_mata_kuliah = "+
            "tbl_klmpk_mata_kuliah.col_id_klmpk_mata_kuliah) WHERE tbl_matkul.col_kode_matkul = ?";
            
            String idKurikulum = "";
            
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, kodeMatkul);
            ResultSet rs = prepare.executeQuery();
            
            while (rs.next()){
                jo.put("namaMatkul", rs.getString("col_nama_matkul"));
                jo.put("kodeMatkul", rs.getString("col_kode_matkul"));
                jo.put("namaKlmpkMatkul", rs.getString("col_nama_klmpk_mata_kuliah"));
                jo.put("sks", rs.getInt("col_sks"));
                jo.put("deskripsi", rs.getString("col_deskripsi_matkul"));
                jo.put("prasyarat", rs.getString("col_prasyarat"));
                jo.put("standarKompetensi", rs.getString("col_standar_kompetensi"));
                idKurikulum = rs.getString("col_id_kurikulum");
            }
            
            //MENDAPATKAN ID LEVEL USER
            int idLevelUser = 0;
            String sql2 = "SELECT col_id_level FROM tbl_user WHERE col_id_user = ?";
            prepare = koneksi.prepareStatement(sql2);
            prepare.setString(1, idUser);
            ResultSet rs2 = prepare.executeQuery();
            while(rs2.next()){
                idLevelUser = rs2.getInt("col_id_level");
            }
            
            //MENGUJI ID KURIKULUM MATA KULIAH DENGAN ID KURIKULUM PRODI USER
            String sql1 = "";
            if(idLevelUser == 0){
            sql1 = "SELECT col_id_kurikulum FROM tbl_prodi_si INNER JOIN "+
                    "tbl_mahasiswa ON (tbl_mahasiswa.col_id_prodi_si = tbl_prodi_si.col_id_prodi_si) "+
                    "WHERE col_nim = ?";
            }else if(idLevelUser == 3){
               sql1 = "SELECT col_id_kurikulum FROM tbl_prodi_si INNER JOIN "+
                    "tbl_fakultas ON (tbl_fakultas.col_id_fakultas = tbl_prodi_si.col_id_fakultas) "+
                       "INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_fakultas) "+
                       "INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = tbl_pt.col_id_pt) "+
                    "WHERE tbl_admin.col_nip = ?";
            }else if(idLevelUser == 2){
               sql1 = "SELECT col_id_kurikulum FROM tbl_prodi_si INNER JOIN "+
                    "tbl_kaprodi_si ON (tbl_kaprodi_si.col_nip = tbl_prodi_si.col_nip) "+
                    "WHERE tbl_kaprodi_si.col_nip = ?";
            }
            
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idUser);
            ResultSet rs1 = prepare.executeQuery();
            while(rs1.next()){
                if(idKurikulum.equals(rs1.getString("col_id_kurikulum"))){
                    jo.put("matkulProdiUser", "yes");
                }else
                    jo.put("matkulProdiUser", "no");
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
