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
public class GetResponRequestMateriKuliah extends HttpServlet {

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
        
        String idRequest = request.getParameter("id");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        //MENDAPATKAN DAFTAR RESPON
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT col_detail_res_req_mk, col_tgl_respon_req_mk, "+
                    "col_waktu_respon_req, tbl_respon_req_mk.col_nip, col_nama_mhs FROM tbl_respon_req_mk INNER JOIN "+
                    "tbl_req_materi_kuliah ON (tbl_req_materi_kuliah.col_id_req = tbl_respon_req_mk.col_id_req) "+
                    "INNER JOIN tbl_mahasiswa ON (tbl_mahasiswa.col_nim = tbl_req_materi_kuliah.col_nim) "+
                    "WHERE tbl_req_materi_kuliah.col_id_req = ?");
            statement.setString(1, idRequest);
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(4);
                m.put("mahasiswaReq", rs.getString("col_nama_mhs"));
                m.put("detailRespon", rs.getString("col_detail_res_req_mk"));
                DateFormat dateFormat = new SimpleDateFormat("dd-MM-YYYY");
                String dateString = dateFormat.format(rs.getDate("col_tgl_respon_req_mk"));
                m.put("tglRespon", dateString);
                m.put("waktu", rs.getTime("col_waktu_respon_req").toString());
                m.put("nip", rs.getString("col_nip"));
                ja.add(m);
            }
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        jo.put("listRespon", ja);
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
