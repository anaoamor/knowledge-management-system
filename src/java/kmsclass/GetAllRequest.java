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
import java.util.LinkedHashMap;
import java.util.Map;
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
public class GetAllRequest extends HttpServlet {

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
        
        String nim = request.getParameter("id");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        //MENDAPATKAN SEMUA REQUEST
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT col_id_req, col_topik_req, col_tgl_req, col_waktu_req, "
            + "col_status_req FROM tbl_req_materi_kuliah WHERE col_nim = ? ORDER BY col_id_req DESC");
            
            statement.setString(1, nim);
            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                Map m = new LinkedHashMap(5);
                m.put("idReq", rs.getString("col_id_req"));
                m.put("topik", rs.getString("col_topik_req"));
                DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                String dateString = dateFormat.format(rs.getDate("col_tgl_req"));
                m.put("tgl", dateString);
                m.put("time", rs.getTime("col_waktu_req").toString());
                m.put("status", rs.getString("col_status_req"));
                ja.add(m);
            }
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        jo.put("daftarRequest", ja);
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
