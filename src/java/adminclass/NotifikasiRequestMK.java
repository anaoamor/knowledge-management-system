/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adminclass;

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
public class NotifikasiRequestMK extends HttpServlet {

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
        
        //MENDAPATKAN NOTIFIKASI REQUEST MATERI KULIAH
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT col_id_req, col_topik_req, col_deskripsi_req, "+
                    "col_tgl_req, col_waktu_req FROM tbl_req_materi_kuliah INNER JOIN tbl_mahasiswa ON "+
                    "(tbl_mahasiswa.col_nim = tbl_req_materi_kuliah.col_nim) INNER JOIN "+
                    "tbl_prodi_si ON (tbl_prodi_si.col_id_prodi_si = tbl_mahasiswa.col_id_prodi_si) "+
                    "INNER JOIN tbl_fakultas ON (tbl_fakultas.col_id_fakultas = "+
                    "tbl_prodi_si.col_id_fakultas) INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = "+
                    "tbl_fakultas.col_id_pt) INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = "+
                    "tbl_pt.col_id_pt) WHERE tbl_admin.col_nip = ? ORDER BY col_timestamp DESC LIMIT "+n+", 5";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idUser);
            ResultSet rs1 = prepare.executeQuery();
            while(rs1.next()){
                Map m = new LinkedHashMap(5);
                m.put("idRequestMateriKuliah", rs1.getString("col_id_req"));
                m.put("topikRequest", rs1.getString("col_topik_req"));
                
                //MENDAPATKAN RESPON TERBARU MAHASISWA TERHADAP REQUEST
                String sql2 = "SELECT col_detail_res_req_mk, col_tgl_respon_req_mk, "+
                        "col_waktu_respon_req FROM tbl_respon_req_mk WHERE col_id_req = ? AND col_nip IS NULL ORDER BY col_id_respon_req_mk "+
                        "DESC LIMIT 1";
                prepare = koneksi.prepareStatement(sql2);
                prepare.setString(1, rs1.getString("col_id_req"));
                ResultSet rs2 = prepare.executeQuery();
                if(rs2.next()){
                    m.put("deskripsi", rs2.getString("col_detail_res_req_mk"));
                    
                    //Membandingkan tanggal respon dan waktu respon request
                    long millis = System.currentTimeMillis();
                    Date tglRespon = rs2.getDate("col_tgl_respon_req_mk");

                    long bedaHariMiliSeceonds = Math.abs(millis - tglRespon.getTime());
                    int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeceonds);
                    if(bedaHari < 1){
                        m.put("datetime", rs2.getTime("col_waktu_respon_req").toString().substring(0, 5));
                    } else if(bedaHari < 2){
                        m.put("datetime", "Yesterday");
                    }else{
                        DateFormat timeFormat = new SimpleDateFormat("dd-MM-yyyy");
                        String stringTgl = timeFormat.format(rs2.getDate("col_tgl_respon_req_mk"));
                        m.put("datetime", stringTgl);
                    }
                }else{
                    m.put("deskripsi", rs1.getString("col_deskripsi_req"));
                    
                    //Membandingkan tanggal dan waktu request
                    long millis = System.currentTimeMillis();
                    Date tglRequest = rs1.getDate("col_tgl_req");

                    long bedaHariMiliSeceonds = Math.abs(millis - tglRequest.getTime());
                    int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeceonds);
                    if(bedaHari < 1){
                        m.put("datetime", rs1.getTime("col_waktu_req").toString().substring(0, 5));
                    } else if(bedaHari < 2){
                        m.put("datetime", "Yesterday");
                    }else{
                        DateFormat timeFormat = new SimpleDateFormat("dd-MM-yyyy");
                        String stringTgl = timeFormat.format(rs1.getDate("col_tgl_req"));
                        m.put("datetime", stringTgl);
                    }
                    
                }
                ja.add(m);
            }
            
            //MEMBANDINGKAN WAKTU NOTIFIKASI RESPON MAHASISWA DENGAN REQUEST
        
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
