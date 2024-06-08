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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class NotifikasiFD extends HttpServlet {

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String idUser = request.getParameter("id");
        String loadN = request.getParameter("n");
        
        int n;
        
        //URUTAN PENGAMBILAN NOTIFIKASI
        if(loadN.equals("")){
            n = 0;
        } else{
            n = Integer.parseInt(loadN) * 5;
        }
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        //MENDAPATKAN NOTIFIKASI
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT tbl_komentar.col_id_komentar, "
                    + "tbl_fd.col_topik_fd, tbl_komentar.col_detail_komentar, tbl_komentar.col_tgl, "
                    + "tbl_komentar.col_waktu, tbl_komentar.col_id_komentator, tbl_komentar.col_id_fd FROM tbl_komentar "
                    + "INNER JOIN tbl_fd ON(tbl_fd.col_id_fd = tbl_komentar.col_id_fd) INNER JOIN tbl_peserta_fd "
                    + "ON (tbl_peserta_fd.col_id_fd = tbl_fd.col_id_fd) WHERE tbl_peserta_fd.col_id_peserta = \'"+idUser+"\' "
                    + "AND tbl_komentar.col_id_komentator <> \'"+idUser+"\' ORDER BY tbl_komentar.col_id_komentar DESC LIMIT "+n+", 5";
            prepare = koneksi.prepareStatement(sql1);
            ResultSet rs1 = prepare.executeQuery();
            
            while(rs1.next()){
                Map m = new LinkedHashMap(5);
                m.put("idKomentar", rs1.getInt("col_id_komentar"));
                m.put("idFD", rs1.getString("col_id_fd"));
                m.put("topikFD", rs1.getString("col_topik_fd"));
                
                //MENDAPATKAN NAMA KOMENTATOR
                String sql2 = "SELECT col_id_level FROM tbl_user WHERE col_id_user = ?";
                prepare = koneksi.prepareStatement(sql2);
                prepare.setString(1, rs1.getString("col_id_komentator"));
                ResultSet rs2 = prepare.executeQuery();
                
                String namaKomentator = "";
                while(rs2.next()){
                    String jenisKomentator = rs2.getString("col_id_level");
                    
                    if(jenisKomentator.equals("0")){
                        namaKomentator = getNamaMahasiswa(rs1.getString("col_id_komentator"));
                    } else if(jenisKomentator.equals("2")){
                        namaKomentator = getNamaKaprodiSI(rs1.getString("col_id_komentator"));
                    } else if(jenisKomentator.equals("3")){
                        namaKomentator = getNamaAdmin(rs1.getString("col_id_komentator"));
                    }
                }
                
                m.put("komentator", namaKomentator);
                m.put("detailKomentar", rs1.getString("col_detail_komentar"));
                
                //MENDAPATKAN WAKTU POST KOMENTATOR
                DateFormat dateFormat = new SimpleDateFormat("HH:MM");
                long millis = System.currentTimeMillis();
                Date tglKomen = rs1.getDate("col_tgl");
                
                long bedaHariMiliSeconds = Math.abs(millis - tglKomen.getTime());
                int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeconds);
                if(bedaHari < 1){
                    m.put("datetime", rs1.getTime("col_waktu").toString());
                } else if(bedaHari < 2){
                    m.put("datetime", "Yesterday");
                } else{
                    m.put("datetime", tglKomen.toString());
                }
                
                ja.add(m);
            }
        }catch(SQLException ex){
            
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(NotifikasiFD.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(NotifikasiFD.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    //METODE MENDAPATKAN NAMA KOMENTATOR-Mahasiswa
    public String getNamaMahasiswa(String nim){
        String nama = " ";
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT col_nama_mhs FROM " +
                "tbl_mahasiswa WHERE col_nim = \'"+nim+"\'");
            ResultSet rs = statement.executeQuery();
            
            if(rs.next()){
                nama = rs.getString("col_nama_mhs");
            } 
        }catch(SQLException ex){
        }
        
        return nama;
    }
            
    //METODE MENDAPATKAN NAMA KOMENTATOR-KAPRODI SI
    public String getNamaKaprodiSI(String nip){
        String nama = " ";
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT col_nama_kaprodi FROM tbl_kaprodi_si WHERE col_nip "
                            + "= \'"+nip+"\'");
            ResultSet rs = statement.executeQuery();
            
            if(rs.next()){
                nama = rs.getString("col_nama_kaprodi");
            } 
        }catch(SQLException ex){
        }
        
        return nama;
    }
    
    //METODE MENDAPATKAN NAMA KOMENTATOR-ADMIN
    public String getNamaAdmin(String nip){
        String nama = " ";
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT col_nama_admin FROM tbl_admin WHERE col_nip = "
                            + "\'"+nip+"\'");
            ResultSet rs = statement.executeQuery();
            
            if(rs.next()){
                nama = rs.getString("col_nama_admin");
            } 
        }catch(SQLException ex){
        }
        
        return nama;
    }
}
