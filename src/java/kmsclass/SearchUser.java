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
public class SearchUser extends HttpServlet {

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
            
        String userSearch = request.getParameter("query_search");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        Connection koneksi = Koneksi.getKoneksi();
        
        //PENCARIAN PADA TABEL MAHASISWA
        try{
            String sql1 = "";
            if(!userSearch.equals("")){
                sql1 = "SELECT col_nim, col_nama_mhs FROM tbl_mahasiswa WHERE col_nama_mhs LIKE \'%"+userSearch+"%\' AND col_nip IS NOT NULL";
            }else{
                sql1 = "SELECT col_nim, col_nama_mhs FROM tbl_mahasiswa WHERE col_nip IS NOT NULL";
            }
            PreparedStatement statement = koneksi.prepareStatement(sql1);
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(3);
                m.put("id", rs.getString("col_nim"));
                m.put("nama", rs.getString("col_nama_mhs"));
                m.put("tipe", "mahasiswa");
                ja.add(m);
            }
            
        }catch(SQLException ex){
            
        }
        
        //PENCARIAN PADA TABEL WADEK KEMAHASISWAAN
        try{
            String sql1 = "";
            if(!userSearch.equals("")){
                sql1 = "SELECT col_nip, col_nama_wadek FROM tbl_wadek_kemahasiswaan WHERE col_nama_wadek LIKE \'%"+userSearch+"%\'";
            }else{
                sql1 = "SELECT col_nip, col_nama_wadek FROM tbl_wadek_kemahasiswaan";
            }
            PreparedStatement statement = koneksi.prepareStatement(sql1);
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(3);
                m.put("id", rs.getString("col_nip"));
                m.put("nama", rs.getString("col_nama_wadek"));
                m.put("tipe", "wadek");
                ja.add(m);
            }
            
        }catch(SQLException ex){
            
        }
        
        //PENCARIAN PADA TABEL KAPRODI SI
        try{
            String sql1 = "";
            if(!userSearch.equals("")){
                sql1 = "SELECT col_nip, col_nama_kaprodi FROM tbl_kaprodi_si WHERE col_nama_kaprodi LIKE \'%"+userSearch+"%\'";
            }else{
                sql1 = "SELECT col_nip, col_nama_kaprodi FROM tbl_kaprodi_si";
            }
            PreparedStatement statement = koneksi.prepareStatement(sql1);
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(3);
                m.put("id", rs.getString("col_nip"));
                m.put("nama", rs.getString("col_nama_kaprodi"));
                m.put("tipe", "kaprodiSi");
                ja.add(m);
            }
            
        }catch(SQLException ex){
            
        }
        
        //PENCARIAN PADA TABEL ADMIN
        try{
            String sql1 = "";
            if(!userSearch.equals("")){
                sql1 = "SELECT col_nip, col_nama_admin FROM tbl_admin WHERE col_nama_admin LIKE \'%"+userSearch+"%\'";
            }else{
                sql1 = "SELECT col_nip, col_nama_admin FROM tbl_admin";
            }
            PreparedStatement statement = koneksi.prepareStatement(sql1);
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                Map m = new LinkedHashMap(3);
                m.put("id", rs.getString("col_nip"));
                m.put("nama", rs.getString("col_nama_admin"));
                m.put("tipe", "admin");
                ja.add(m);
            }
            
        }catch(SQLException ex){
            
        }    
           
            
        jo.put("resultQuery", ja);
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
