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
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetMessage extends HttpServlet {

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
            
        String idResponden = request.getParameter("id_responden");
        char idLevel = request.getParameter("id_level").charAt(0);
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        //MENDAPATKAN DAFTAR MESSAGE USER DENGAN RESPONDEN
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            
            //MENDAPATKAN NAMA RESPONDEN DAN IMAGENYA
            switch(idLevel){
                    case '0':{//MAHASISWA
                        String sql1 = "SELECT col_nama_mhs, col_user_image FROM "+
                                "tbl_mahasiswa INNER JOIN tbl_user ON (tbl_user.col_id_user = "+
                                "tbl_mahasiswa.col_nim) WHERE col_nim = ?";
                        prepare = koneksi.prepareStatement(sql1);
                        prepare.setString(1, idResponden);
                        
                        ResultSet rs1 = prepare.executeQuery();
                        while(rs1.next()){
                            jo.put("namaResponden", rs1.getString("col_nama_mhs"));
                            jo.put("userImage", rs1.getString("col_user_image"));
                        }
                        break;
                    } case '1':{//WADEK KEMAHASISWAAN
                        String sql1 = "SELECT col_nama_wadek, col_user_image FROM "+
                                "tbl_wadek_kemahasiswaan INNER JOIN tbl_user ON (tbl_user.col_id_user = "+
                                "tbl_wadek_kemahasiswaan.col_nip) WHERE col_nip = ?";
                        prepare = koneksi.prepareStatement(sql1);
                        prepare.setString(1, idResponden);
                        
                        ResultSet rs1 = prepare.executeQuery();
                        while(rs1.next()){
                            jo.put("namaResponden", rs1.getString("col_nama_wadek"));
                            jo.put("userImage", rs1.getString("col_user_image"));
                        }
                        break;
                    } case '2':{//KAPRODI SI
                        String sql1 = "SELECT col_nama_kaprodi, col_user_image FROM "+
                                "tbl_kaprodi_si INNER JOIN tbl_user ON (tbl_user.col_id_user = "+
                                "tbl_kaprodi_si.col_nip) WHERE col_nip = ?";
                        prepare = koneksi.prepareStatement(sql1);
                        prepare.setString(1, idResponden);
                        
                        ResultSet rs1 = prepare.executeQuery();
                        while(rs1.next()){
                            jo.put("namaResponden", rs1.getString("col_nama_kaprodi"));
                            jo.put("userImage", rs1.getString("col_user_image"));
                        }
                        break;
                    } case '3':{//ADMIN
                        String sql1 = "SELECT col_nama_admin, col_user_image FROM "+
                                "tbl_admin INNER JOIN tbl_user ON (tbl_user.col_id_user = "+
                                "tbl_admin.col_nip) WHERE col_nip = ?";
                        prepare = koneksi.prepareStatement(sql1);
                        prepare.setString(1, idResponden);
                        
                        ResultSet rs1 = prepare.executeQuery();
                        while(rs1.next()){
                            jo.put("namaResponden", rs1.getString("col_nama_admin"));
                            jo.put("userImage", rs1.getString("col_user_image"));
                        }
                        break;
                    } default:{
                        break;
                    }
            }
            
            //MENDAPATKAN SEMUA MESSAGE DENGAN RESPONDEN
            String sql2 = "SELECT col_detail_message, col_tgl_message, col_waktu, col_pengirim "+
                    "FROM tbl_message WHERE ((col_pengirim = ? AND col_penerima = ?) OR "+
                    "(col_pengirim = ? AND col_penerima = ?))";
           
            prepare = koneksi.prepareStatement(sql2);
            prepare.setString(1, idResponden);
            prepare.setString(2, idUser);
            prepare.setString(3, idUser);
            prepare.setString(4, idResponden);
            ResultSet rs2 = prepare.executeQuery();
            while(rs2.next()){
                Map m = new LinkedHashMap(4);
                m.put("detailMessage", rs2.getString("col_detail_message"));
                DateFormat dateFormat = new SimpleDateFormat("dd-MM-YYYY");
                String dateString = dateFormat.format(rs2.getDate("col_tgl_message"));
                m.put("tglMessage", dateString);
                m.put("waktu", rs2.getTime("col_waktu").toString().substring(0, 5));
                m.put("pengirim", rs2.getString("col_pengirim"));
                ja.add(m);
            }
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        jo.put("listMessage", ja);
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
