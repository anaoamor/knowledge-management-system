/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kmsclass;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
public class Notification extends HttpServlet {

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
        String idRequest = request.getParameter("permintaan");
        String jenisRequest = request.getParameter("tabel");
        
        JSONArray ja =  getRequestMateriKuliahNotification(idUser, 0);
        
        //NOTIFIKASI PERTAMA BUKA PAGE NOTIFIKASI
        if(idRequest.equals("0")){
            
        }else{
            
        }
       
        JSONObject jo = new JSONObject();
        jo.put("jenisNotifikasi", "request materi kuliah");
        jo.put("listNotifikasi", ja);
        
        out.println(jo.toJSONString());
        out.println(idUser);
         
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
            Logger.getLogger(Notification.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Notification.class.getName()).log(Level.SEVERE, null, ex);
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

    //NOTIFIKASI REQUEST MATERI KULIAH
    public JSONArray getRequestMateriKuliahNotification(String idUser, int idRequest) throws ParseException{
        int offset = idRequest * 5;
        JSONArray ja = new JSONArray();
        
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT tbl_req_materi_kuliah.col_id_req, "
                    + "col_topik_req, col_detail_res_req_mk, col_tgl_respon_req_mk, col_waktu_respon_req "
                    + "FROM tbl_respon_req_mk INNER JOIN tbl_req_materi_kuliah ON (tbl_req_materi_kuliah.col_id_req "
                    + "= tbl_respon_req_mk.col_id_req) WHERE tbl_req_materi_kuliah.col_id_req = \'"+idUser+"\' "
                            + "ORDER BY tbl_respon_req_mk.col_id_respon_req_mk DESC LIMIT "+offset+",5");
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(4);
                m.put("idRequestMateriKuliah", rs.getString("col_id_req"));
                m.put("topikRequest", rs.getString("col_topik_req"));
                m.put("detailResponRequestMK", rs.getString("col_detail_res_req_mk"));
                
                //Membandingkan tanggal respon dan waktu respon request
                DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
                Date today = new Date();
                Date tglRespon = (Date) dateFormat.parse(rs.getString("col_tgl_respon_req_mk"));
                
                long bedaHariMiliSeceonds = Math.abs(today.getTime() - tglRespon.getTime());
                int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeceonds);
                if(bedaHari > 1){
                    m.put("datetime", rs.getString("col_tgl_respon_req_mk"));
                } else if(bedaHari == 1){
                    m.put("datetime", rs.getString("Yesterday"));
                }else{
                    DateFormat timeFormat = new SimpleDateFormat("hh:mm");
                    m.put("datetime", (Date) timeFormat.parse(rs.getString("col_waktu_respon_req")));
                }
                
                ja.add(m);
            }
        }catch(SQLException ex){
            
        }
        
        return ja;
    }
    
    //NOTIFIKASI MESSAGING
    
    
    //NOTIFIKASI FORUM DISKUSI
    
    //NOTIFIKASI FEEDBACK
}
