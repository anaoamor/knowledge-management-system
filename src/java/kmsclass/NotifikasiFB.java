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
import java.sql.Date;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;
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
public class NotifikasiFB extends HttpServlet {

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
        
        //MENDAPATKAN NOTIFIKASI
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare = koneksi.prepareStatement("SELECT col_id_respon_fb, col_topik_fb, "
                    + "col_detail_respon_fb, tbl_respon_fb.col_tgl, tbl_respon_fb.col_waktu, tbl_fb.col_id_fb FROM tbl_respon_fb "
                    + "INNER JOIN tbl_fb ON (tbl_fb.col_id_fb = tbl_respon_fb.col_id_fb) WHERE tbl_fb.col_nim = "
                    + "\'"+idUser+"\' AND tbl_respon_fb.col_responden <> \'"+idUser+"\' ORDER BY tbl_respon_fb.col_id_respon_fb DESC LIMIT "+n+", 5");
            ResultSet rs = prepare.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(5);
                m.put("idResponFB", rs.getString("col_id_respon_fb"));
                m.put("idFB", rs.getString("col_id_fb"));
                m.put("topikFB", rs.getString("col_topik_fb"));
                m.put("detailResponFB", rs.getString("col_detail_respon_fb"));
                
                //Mendapatkan tanggal respon dan waktu respon FB
                long millis = System.currentTimeMillis();
                Date tglRespon = rs.getDate("col_tgl");
                
                long bedaHariMilliSeconds = Math.abs(millis - tglRespon.getTime());
                int bedaHari = (int) TimeUnit.MILLISECONDS.toDays(bedaHariMilliSeconds);
                if(bedaHari < 1){
                    m.put("datetime", rs.getTime("col_waktu").toString());
                }else if(bedaHari < 2){
                    m.put("datetime", "Yesterday");
                }else{
                    m.put("datetime", rs.getDate("col_tgl").toString());
                }
                
                ja.add(m);
            }
            
        } catch(SQLException ex){
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
