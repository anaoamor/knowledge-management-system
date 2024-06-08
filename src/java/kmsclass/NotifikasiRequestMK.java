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
        
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare = koneksi.prepareStatement("SELECT tbl_req_materi_kuliah.col_id_req, "
                    + "col_topik_req, col_detail_res_req_mk, col_tgl_respon_req_mk, col_waktu_respon_req "
                    + "FROM tbl_respon_req_mk INNER JOIN tbl_req_materi_kuliah ON (tbl_req_materi_kuliah.col_id_req "
                    + "= tbl_respon_req_mk.col_id_req) WHERE tbl_req_materi_kuliah.col_nim = \'"+idUser+"\' "
                    + "AND col_nip IS NOT NULL "
                    + "ORDER BY tbl_respon_req_mk.col_id_respon_req_mk DESC LIMIT "+n+",5");
            ResultSet rs = prepare.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(4);
                m.put("idRequestMateriKuliah", rs.getString("col_id_req"));
                m.put("topikRequest", rs.getString("col_topik_req"));
                m.put("detailResponRequestMK", rs.getString("col_detail_res_req_mk"));
                
                //Membandingkan tanggal respon dan waktu respon request
                DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
                long millis = System.currentTimeMillis();
                Date tglRespon = rs.getDate("col_tgl_respon_req_mk");
                
                long bedaHariMiliSeceonds = Math.abs(millis - tglRespon.getTime());
                int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMiliSeceonds);
                if(bedaHari < 1){
                    m.put("datetime", rs.getTime("col_waktu_respon_req").toString());
                } else if(bedaHari < 2){
                    m.put("datetime", "Yesterday");
                }else{
                    DateFormat timeFormat = new SimpleDateFormat("hh:mm");
                    m.put("datetime", rs.getDate("col_tgl_respon_req_mk").toString());
                }
                
                ja.add(m);
            }
        }catch(SQLException ex){
            ex.getMessage();
        }
            /* TODO output your page here. You may use following sample code. */
        
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
            Logger.getLogger(NotifikasiRequestMK.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(NotifikasiRequestMK.class.getName()).log(Level.SEVERE, null, ex);
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

}
