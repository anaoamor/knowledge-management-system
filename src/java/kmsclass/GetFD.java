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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetFD extends HttpServlet {

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
           
        String idFD = request.getParameter("id");
        
        JSONObject jo = new JSONObject();
        
        //MENDAPATKAN DESKRIPSI FORUM DISKUSI
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT col_topik_fd, col_subbidang_diskusi, col_deskripsi_fd, "+
                    "col_tgl, col_waktu, col_status, col_creator FROM tbl_fd WHERE col_id_fd = ?";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idFD);
            ResultSet rs1 = prepare.executeQuery();
            
            while(rs1.next()){
                jo.put("topikFD", rs1.getString("col_topik_fd"));
                jo.put("subbidang", rs1.getString("col_subbidang_diskusi"));
                jo.put("deskripsi", rs1.getString("col_deskripsi_fd"));
                DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                String dateString = dateFormat.format(rs1.getDate("col_tgl"));
                jo.put("tglFD", dateString);
                jo.put("waktu", rs1.getTime("col_waktu").toString().substring(0, 5));
                jo.put("status", rs1.getString("col_status"));
                jo.put("idCreator", rs1.getString("col_creator"));
                
                //MENDAPATKAN NAMA CREATOR FORUM DISKUSI
                String sql2 = "SELECT col_id_level FROM tbl_user WHERE col_id_user = ?";
                prepare = koneksi.prepareStatement(sql2);
                prepare.setString(1, rs1.getString("col_creator"));
                ResultSet rs2 = prepare.executeQuery();
                while(rs2.next()){
                    String idLevel = rs2.getString("col_id_level");
                    
                    switch (idLevel) {
                        case "0":{
                            String sql3 = "SELECT col_nama_mhs FROM tbl_mahasiswa WHERE col_nim = \'"+rs1.getString("col_creator")+"\'";
                            prepare = koneksi.prepareStatement(sql3);
                            ResultSet rs3 = prepare.executeQuery();
                            while(rs3.next()){
                                jo.put("namaCreator", rs3.getString("col_nama_mhs"));
                            }
                            break;
                        }
                        case "2":{
                            String sql3 = "SELECT col_nama_kaprodi FROM tbl_kaprodi_si WHERE col_nip = \'"+rs1.getString("col_creator")+"\'";
                            prepare = koneksi.prepareStatement(sql3);
                            ResultSet rs3 = prepare.executeQuery();
                            while(rs3.next()){
                                jo.put("namaCreator", rs3.getString("col_nama_kaprodi"));
                            }
                            break;
                        }
                        default:{
                            String sql3 = "SELECT col_nama_admin FROM tbl_admin WHERE col_nip = \'"+rs1.getString("col_creator")+"\'";
                            prepare = koneksi.prepareStatement(sql3);
                            ResultSet rs3 = prepare.executeQuery();
                            while(rs3.next()){
                                jo.put("namaCreator", rs3.getString("col_nama_admin"));
                            }
                            break;
                        }
                    }
                    
                }
            }
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
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
