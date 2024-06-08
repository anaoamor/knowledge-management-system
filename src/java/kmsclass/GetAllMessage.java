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
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.catalina.tribes.util.Arrays;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetAllMessage extends HttpServlet {

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
        JSONArray ja = getIDUserLain(idUser);
        
        JSONArray ja1 = new JSONArray();
        
        ja.forEach(item -> {
            try{
                Connection koneksi = Koneksi.getKoneksi();
                PreparedStatement prepare;
                
                String sql2 = "";
                String sql3 = "";
                int idLevel = getIDLevelUser(item.toString());
                
                Map m = new LinkedHashMap(5);
                switch(idLevel){
                    case 0:{//MAHASISWA
                        m.put("idResponden", item.toString());
                        m.put("idLevel", idLevel);
                        sql2 = "SELECT col_detail_message, col_tgl_message, col_waktu "+
                                "FROM tbl_message "+
                                "WHERE ((col_pengirim = ? AND col_penerima = ?) OR "+
                                "(col_pengirim = ? AND col_penerima = ?)) ORDER BY col_id_message DESC LIMIT 1";
                        prepare = koneksi.prepareStatement(sql2);
                        prepare.setString(1, item.toString());
                        prepare.setString(2, idUser);
                        prepare.setString(3, idUser);
                        prepare.setString(4, item.toString());
                        
                        ResultSet rs2 = prepare.executeQuery();
                        while(rs2.next()){
                            m.put("detailMessage", rs2.getString("col_detail_message"));
                            
                            //MENDAPATKAN WAKTU PESAN
                            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                            long millis = System.currentTimeMillis();
                            Date tglPesan = rs2.getDate("col_tgl_message");

                            long bedaHariMiliSeconds = Math.abs(millis - tglPesan.getTime());
                            int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeconds);
                            if(bedaHari < 1){
                                m.put("datetime", rs2.getTime("col_waktu").toString().substring(0, 5));
                            } else if(bedaHari < 2){
                                m.put("datetime", "Yesterday");
                            } else{
                                m.put("datetime", dateFormat.format(tglPesan));
                            }
                            
                        }
                        
                        sql3 = "SELECT col_nama_mhs FROM tbl_mahasiswa WHERE col_nim = ?";
                        prepare = koneksi.prepareStatement(sql3);
                        prepare.setString(1, item.toString());
                        ResultSet rs3 = prepare.executeQuery();
                        while(rs3.next()){
                            m.put("respondenMessage", rs3.getString("col_nama_mhs"));
                        }
                        
                        break;
                    } case 1:{//WADEK KEMAHASISWAAN
                        m.put("idResponden", item.toString());
                        m.put("idLevel", idLevel);
                        sql2 = "SELECT col_detail_message, col_tgl_message, col_waktu "+
                                "FROM tbl_message "+
                                "WHERE ((col_pengirim = ? AND col_penerima = ?) OR "+
                                "(col_pengirim = ? AND col_penerima = ?)) ORDER BY col_id_message DESC LIMIT 1";
                        prepare = koneksi.prepareStatement(sql2);
                        prepare.setString(1, item.toString());
                        prepare.setString(2, idUser);
                        prepare.setString(3, idUser);
                        prepare.setString(4, item.toString());
                        
                        ResultSet rs2 = prepare.executeQuery();
                        while(rs2.next()){
                            m.put("detailMessage", rs2.getString("col_detail_message"));
                            
                            //MENDAPATKAN WAKTU PESAN
                            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                            long millis = System.currentTimeMillis();
                            Date tglPesan = rs2.getDate("col_tgl_message");

                            long bedaHariMiliSeconds = Math.abs(millis - tglPesan.getTime());
                            int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeconds);
                            if(bedaHari < 1){
                                m.put("datetime", rs2.getTime("col_waktu").toString().substring(0, 5));
                            } else if(bedaHari < 2){
                                m.put("datetime", "Yesterday");
                            } else{
                                m.put("datetime", dateFormat.format(tglPesan));
                            }
                            
                        }
                        
                        sql3 = "SELECT col_nama_wadek FROM tbl_wadek_kemahasiswaan WHERE col_nip = ?";
                        prepare = koneksi.prepareStatement(sql3);
                        prepare.setString(1, item.toString());
                        ResultSet rs3 = prepare.executeQuery();
                        while(rs3.next()){
                            m.put("respondenMessage", rs3.getString("col_nama_wadek"));
                        }
                        
                        break;
                    } case 2:{//KAPRODI SI
                        m.put("idResponden", item.toString());
                        m.put("idLevel", idLevel);
                        sql2 = "SELECT col_detail_message, col_tgl_message, col_waktu "+
                                "FROM tbl_message "+
                                "WHERE ((col_pengirim = ? AND col_penerima = ?) OR "+
                                "(col_pengirim = ? AND col_penerima = ?)) ORDER BY col_id_message DESC LIMIT 1";
                        prepare = koneksi.prepareStatement(sql2);
                        prepare.setString(1, item.toString());
                        prepare.setString(2, idUser);
                        prepare.setString(3, idUser);
                        prepare.setString(4, item.toString());
                        
                        ResultSet rs2 = prepare.executeQuery();
                        while(rs2.next()){
                            m.put("detailMessage", rs2.getString("col_detail_message"));
                            
                            //MENDAPATKAN WAKTU PESAN
                            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                            long millis = System.currentTimeMillis();
                            Date tglPesan = rs2.getDate("col_tgl_message");

                            long bedaHariMiliSeconds = Math.abs(millis - tglPesan.getTime());
                            int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeconds);
                            if(bedaHari < 1){
                                m.put("datetime", rs2.getTime("col_waktu").toString().substring(0, 5));
                            } else if(bedaHari < 2){
                                m.put("datetime", "Yesterday");
                            } else{
                                m.put("datetime", dateFormat.format(tglPesan));
                            }
                            
                        }
                        
                        sql3 = "SELECT col_nama_kaprodi_si FROM tbl_kaprodi_si WHERE col_nip = ?";
                        prepare = koneksi.prepareStatement(sql3);
                        prepare.setString(1, item.toString());
                        ResultSet rs3 = prepare.executeQuery();
                        while(rs3.next()){
                            m.put("respondenMessage", rs3.getString("col_nama_kaprodi_si"));
                        }
                        
                        break;
                    } case 3:{//ADMIN
                        m.put("idLevel", idLevel);
                        m.put("idResponden", item.toString());
                        sql2 = "SELECT col_detail_message, col_tgl_message, col_waktu "+
                                "FROM tbl_message "+
                                "WHERE ((col_pengirim = ? AND col_penerima = ?) OR "+
                                "(col_pengirim = ? AND col_penerima = ?)) ORDER BY col_id_message DESC LIMIT 1";
                        prepare = koneksi.prepareStatement(sql2);
                        prepare.setString(1, item.toString());
                        prepare.setString(2, idUser);
                        prepare.setString(3, idUser);
                        prepare.setString(4, item.toString());
                        
                        ResultSet rs2 = prepare.executeQuery();
                        while(rs2.next()){
                            m.put("detailMessage", rs2.getString("col_detail_message"));
                            
                            //MENDAPATKAN WAKTU PESAN
                            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                            long millis = System.currentTimeMillis();
                            Date tglPesan = rs2.getDate("col_tgl_message");

                            long bedaHariMiliSeconds = Math.abs(millis - tglPesan.getTime());
                            int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeconds);
                            if(bedaHari < 1){
                                m.put("datetime", rs2.getTime("col_waktu").toString().substring(0, 5));
                            } else if(bedaHari < 2){
                                m.put("datetime", "Yesterday");
                            } else{
                                m.put("datetime", dateFormat.format(tglPesan));
                            }
                            
                        }
                        
                        sql3 = "SELECT col_nama_admin FROM tbl_admin WHERE col_nip = ?";
                        prepare = koneksi.prepareStatement(sql3);
                        prepare.setString(1, item.toString());
                        ResultSet rs3 = prepare.executeQuery();
                        while(rs3.next()){
                            m.put("respondenMessage", rs3.getString("col_nama_admin"));
                        }
                        
                        break;
                    } default:{
                        
                    }
                }
                
                ja1.add(m);
            }catch(SQLException ex){
                
            }
            
        });
        
        jo.put("daftarMessage", ja1);
        
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

    /**
     * Mendapatkan daftar ID User lain yang berkirim pesan dengan User
     * @param id
     * @return 
     */
    public JSONArray getIDUserLain(String id){
        JSONArray ja = new JSONArray();
        //MENDAPATKAN DAFTAR USER LAIN YANG BERKIRIM PESAN DENGAN USER INI
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            
            String sql1 = "SELECT col_penerima, col_pengirim FROM tbl_message "+
                    "WHERE col_penerima = ? OR col_pengirim = ? ORDER BY col_id_message DESC";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, id);
            prepare.setString(2, id);
            ResultSet rs1 = prepare.executeQuery();
            
            while(rs1.next()){
                String pane = rs1.getString("col_penerima");
                String peng = rs1.getString("col_pengirim");
                
                if (! ja.contains(pane) && ! pane.equals(id)) {
                    ja.add(pane);
                }
                if (!ja.contains(peng) && !peng.equals(id)) {
                    ja.add(peng);
                }
                
            }
            
        }catch(SQLException ex){
            
        }catch(NullPointerException ex){
            
        }
        
        return ja;
    }
    
    /**
     * Mendapatkan ID Level User Yang Berkirim Pesan
     */
    public static int getIDLevelUser(String idUserLain){
        int idLevelUserLain = 0;
        
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            
            String sql1 = "SELECT col_id_level FROM tbl_user "+
                    "WHERE col_id_user = ?";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idUserLain);
            ResultSet rs1 = prepare.executeQuery();
            while(rs1.next()){
                idLevelUserLain = rs1.getInt("col_id_level");
                
            }
        }catch(SQLException ex){
            
        }
        
        return idLevelUserLain;
    }
}
