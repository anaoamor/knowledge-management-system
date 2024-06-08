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
public class GetResponFB extends HttpServlet {

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

        String idFB = request.getParameter("id");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        //MENDAPATKAN SEMUA RESPON DARI FEEDBACK
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT col_detail_respon_fb, col_tgl, col_waktu, col_responden "+
                    "FROM tbl_respon_fb WHERE col_id_fb = ?";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idFB);
            ResultSet rs1 = prepare.executeQuery();
            while(rs1.next()){
                Map m = new LinkedHashMap(5);
                //MENDAPATKAN NAMA RESPONDEN
                String sql2 = "SELECT col_id_level FROM tbl_user WHERE col_id_user = ?";
                prepare = koneksi.prepareStatement(sql2);
                prepare.setString(1, rs1.getString("col_responden"));
                ResultSet rs2 = prepare.executeQuery();
                while(rs2.next()){
                    String idLevelResponden = rs2.getString("col_id_level");
                    //MENDAPATKAN NAMA KOMENTATOR
                    switch(idLevelResponden){
                        case "0":{
                            String sql3 = "SELECT col_nama_mhs FROM "+
                                "tbl_mahasiswa WHERE col_nim = ?";
                            prepare = koneksi.prepareStatement(sql3);
                            prepare.setString(1, rs1.getString("col_responden"));

                            ResultSet rs3 = prepare.executeQuery();
                            while(rs3.next()){
                                m.put("idResponden", rs1.getString("col_responden"));
                                m.put("namaResponden", rs3.getString("col_nama_mhs"));
                            }
                            break;
                        } case "3":{
                            String sql3 = "SELECT col_nama_admin FROM "+
                                "tbl_admin WHERE col_nip = ?";
                            prepare = koneksi.prepareStatement(sql3);
                            prepare.setString(1, rs1.getString("col_responden"));

                            ResultSet rs3 = prepare.executeQuery();
                            while(rs3.next()){
                                m.put("idResponden", rs1.getString("col_responden"));
                                m.put("namaResponden", rs3.getString("col_nama_admin"));
                            }
                            break;
                        } default:{
                            break;
                        }
                        
                    }
                }
                
                m.put("detailRespon", rs1.getString("col_detail_respon_fb"));
                DateFormat dateFormat = new SimpleDateFormat("dd-MM-YYYY");
                String dateString = dateFormat.format(rs1.getDate("col_tgl"));
                m.put("tglRespon", dateString);
                m.put("waktu", rs1.getTime("col_waktu").toString().substring(0, 5));
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
