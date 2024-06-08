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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetProdi extends HttpServlet {

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
        
        String idProdiSI = request.getParameter("id");
        
        JSONObject jo = new JSONObject();
        
        //MENDAPATKAN RECORD PRODI
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT col_tahun_berdiri, col_alamat_prodi, col_no_telp_prodi, "+
                    "col_email_prodi, col_durasi_program, col_jumlah_sks, tbl_prodi_si.col_batas_semester, tbl_prodi_si.col_nip, "+
                    "tbl_kaprodi_si.col_nama_kaprodi, tbl_kurikulum.col_tahun, "+
                    "tbl_fakultas.col_nama_fakultas, tbl_pt.col_nama_pt, tbl_admin.col_nip FROM tbl_prodi_si INNER JOIN tbl_kurikulum ON "+
                    "(tbl_kurikulum.col_id_kurikulum = tbl_prodi_si.col_id_kurikulum) INNER JOIN "+
                    "tbl_kaprodi_si ON (tbl_kaprodi_si.col_nip = tbl_prodi_si.col_nip) INNER JOIN "+
                    "tbl_fakultas ON (tbl_fakultas.col_id_fakultas = tbl_prodi_si.col_id_fakultas) INNER JOIN tbl_pt "+
                    "ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_pt) INNER JOIN tbl_admin ON  "+
                    "(tbl_admin.col_id_pt = tbl_pt.col_id_pt) "+
                    "WHERE col_id_prodi_si = ?";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idProdiSI);
            ResultSet rs1 = prepare.executeQuery();
            while(rs1.next()){
                jo.put("kaprodiSI", rs1.getString("col_nama_kaprodi"));
                DateFormat dateFormat = new SimpleDateFormat("YYYY");
                
                if(rs1.getDate("col_tahun_berdiri") != null){
                    String tahunBerdiri = dateFormat.format(rs1.getDate("col_tahun_berdiri"));
                    jo.put("tahunBerdiri", tahunBerdiri);
                }else
                    jo.put("tahunBerdiri", null);
                
                jo.put("alamat", rs1.getString("col_alamat_prodi"));
                jo.put("noTelepon", rs1.getString("col_no_telp_prodi"));
                jo.put("emailProdi", rs1.getString("col_email_prodi"));
                jo.put("durasiProgram", rs1.getString("col_durasi_program"));
                jo.put("jumlahSKS", rs1.getString("col_jumlah_sks"));
                jo.put("semMaksimal", rs1.getString("col_batas_semester"));
                jo.put("nipKaprodi", rs1.getString("tbl_prodi_si.col_nip"));
                String kurikulum = dateFormat.format(rs1.getDate("col_tahun"));
                jo.put("kurikulum", kurikulum);
                jo.put("fakultas", rs1.getString("col_nama_fakultas"));
                jo.put("pt", rs1.getString("col_nama_pt"));
                jo.put("nipAdmin", rs1.getString("tbl_admin.col_nip"));
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
