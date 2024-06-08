package kmsclass;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class CountNotifikasi extends HttpServlet {

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
        
        //Get parameter input
        String idUser = request.getParameter("id");
        String input = request.getParameter("view");
        int jumlahUnseen = 0;
        
        //Jika button notifikasi diklik
        if(!input.equals("")){
            try{
                Connection koneksi = Koneksi.getKoneksi();
                Statement statement = koneksi.createStatement();
                //UPDATE NOTIFIKASI RESPON REQUEST MATERI KULIAH
                int i = statement.executeUpdate("UPDATE tbl_respon_req_mk "
                        + "INNER JOIN tbl_req_materi_kuliah ON (tbl_req_materi_kuliah.col_id_req = "
                        + "tbl_respon_req_mk.col_id_req) SET col_status = 1 WHERE tbl_req_materi_kuliah."
                        + "col_nim = \'"+idUser+"\' AND tbl_respon_req_mk.col_nip IS NOT NULL AND tbl_respon_req_mk.col_status = 0");
                
                //UPDATE NOTIFIKASI MESSAGE
                int j = statement.executeUpdate("UPDATE tbl_message "
                        + "SET col_status = 1 WHERE col_penerima = \'"+idUser+"\' AND col_status = 0");
                
                //UPDATE NOTIFIKASI RESPON FEEDBACK
                int k = statement.executeUpdate("UPDATE tbl_respon_fb "
                        + "INNER JOIN tbl_fb ON tbl_fb.col_id_fb = "
                        + "tbl_respon_fb.col_id_fb SET tbl_respon_fb.col_status = 1 WHERE tbl_fb."
                        + "col_nim = \'"+idUser+"\' AND col_responden <> "+idUser+" AND tbl_respon_fb.col_status = 0");
                
                //UPDATE NOTIFIKASI FORUM DISKUSI
                int m = statement.executeUpdate("UPDATE tbl_read_komentar SET col_status = 1 "
                        + "WHERE col_id_peserta = \'"+idUser+"\' AND col_status = 0");
                
            }catch(SQLException ex){
                out.println(ex.getMessage());
            }
        }
        
        //MENDAPATKAN JUMLAH NOTIFIKASI BARU
        try{
            //RESPON REQUEST MATERI KULIAH BARU
            Connection koneksi = Koneksi.getKoneksi();
            Statement statement = koneksi.createStatement();
            ResultSet rs = statement.executeQuery("SELECT col_id_respon_req_mk FROM tbl_respon_req_mk "
                    + "INNER JOIN tbl_req_materi_kuliah ON (tbl_req_materi_kuliah.col_id_req = "
                    + "tbl_respon_req_mk.col_id_req) WHERE tbl_req_materi_kuliah.col_nim = \'"+idUser+"\' AND "
                    + "col_nip IS NOT NULL AND col_status = 0");
            while(rs.next()){
                jumlahUnseen++;
            }
            
            //NOTIFIKASI MESSAGE BARU
            rs = statement.executeQuery("SELECT col_id_message FROM tbl_message WHERE col_penerima "
                    + "= \'"+idUser+"\' AND col_status = 0");
            while(rs.next()){
                jumlahUnseen++;
            }
            
            //NOTIFIKASI RESPON FEEDBACK BARU
            rs = statement.executeQuery("SELECT col_id_respon_fb FROM tbl_respon_fb "
                    + "INNER JOIN tbl_fb ON tbl_fb.col_id_fb = "
                    + "tbl_respon_fb.col_id_fb WHERE tbl_fb.col_nim = \'"+idUser+"\' AND col_responden <> "+idUser+" AND "
                    + "tbl_respon_fb.col_status = 0");
            while(rs.next()){
                jumlahUnseen++;
            }
            
            //NOTIFIKASI Komentar Forum Diskusi Baru
            rs = statement.executeQuery("SELECT col_status FROM tbl_read_komentar "
                    + "WHERE col_id_peserta = \'"+idUser+"\' AND col_status = 0");
            while(rs.next()){
                jumlahUnseen++;
            }
            
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        JSONObject jo = new JSONObject();
        jo.put("unseen_notification", jumlahUnseen);
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
