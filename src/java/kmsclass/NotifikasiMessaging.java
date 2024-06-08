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
import java.sql.Statement;
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
public class NotifikasiMessaging extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
        
        
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
        
        //Mendapatkan pesan
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT col_id_message, "
                    + "col_detail_message, col_tgl_message, col_waktu, col_pengirim, col_jenis_pengirim FROM "
                    + "tbl_message WHERE col_penerima = \'"+idUser+"\' ORDER BY col_id_message DESC "
                            + "LIMIT "+n+", 5");
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(6);
                m.put("idMessage", rs.getString("col_id_message"));
                m.put("idPengirim", rs.getString("col_pengirim"));
                m.put("idLevelPengirim", rs.getString("col_jenis_pengirim"));
                
                //MENDAPATKAN NAMA PENGIRIM
                int tipePengirim = rs.getInt("col_jenis_pengirim");
                String namaPengirim = "";
                
                switch (tipePengirim) {
                    case 0:
                        namaPengirim = getNamaMahasiswa(rs.getString("col_pengirim"));
                        break;
                    case 1:
                        namaPengirim = getNamaWadek(rs.getString("col_pengirim"));
                        break;
                    case 2:
                        namaPengirim = getNamaKaprodiSI(rs.getString("col_pengirim"));
                        break;
                    default:
                        namaPengirim = getNamaAdmin(rs.getString("col_pengirim"));
                        break;
                }
                
                m.put("pengirim", namaPengirim);
                m.put("detailMessage", rs.getString("col_detail_message"));
                
                //MENDAPATKAN WAKTU PENGIRIMAN
                DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                long millis = System.currentTimeMillis();
                Date tglMessage = rs.getDate("col_tgl_message");
                
                long bedaHariMiliSeceonds = Math.abs(millis - tglMessage.getTime());
                int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeceonds);
                if(bedaHari < 1){
                    m.put("datetime", rs.getTime("col_waktu").toString().substring(0, 5));
                } else if(bedaHari < 1 ){
                    m.put("datetime", "Yesterday");
                }else{
                    String stringTanggal = dateFormat.format(rs.getDate("col_tgl_message"));
                    m.put("datetime", stringTanggal);
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
            Logger.getLogger(NotifikasiMessaging.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(NotifikasiMessaging.class.getName()).log(Level.SEVERE, null, ex);
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

    //METODE MENDAPATKAN NAMA PENGIRIM-MAHASISWA
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
    
    //METODE MENDAPATKAN NAMA PENGIRIM-WADEK KEMAHASISWAAN
    public String getNamaWadek(String nip){
        String nama = " ";
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT col_nama_wadek FROM " +
                "tbl_wadek_kemahasiswaan WHERE col_nip = \'"+nip+"\'");
            ResultSet rs = statement.executeQuery();
            
            if(rs.next()){
                nama = rs.getString("col_nama_wadek");
            } 
        }catch(SQLException ex){
        }
        
        return nama;
    }
    
    //METODE MENDAPATKAN NAMA PENGIRIM-KAPRODI SI
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
    
    //METODE MENDAPATKAN NAMA PENGIRIM-ADMIN
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
