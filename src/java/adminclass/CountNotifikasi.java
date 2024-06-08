/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adminclass;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kmsclass.Koneksi;
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
        
        String idUser = request.getParameter("id");
        String input = request.getParameter("view");

        //Jika button notifikasi diklik
        int jumlahUnseen = 0;
        if(!input.equals("")){
            try{
                Connection koneksi = Koneksi.getKoneksi(); 
                Statement statement = koneksi.createStatement();
                //UPDATE NOTIFIKASI RESPON MAHASISWA TERHADAP REQUEST MATERI KULIAH
                int i = statement.executeUpdate("UPDATE tbl_respon_req_mk INNER JOIN tbl_req_materi_kuliah "+
                        "ON (tbl_req_materi_kuliah.col_id_req = tbl_respon_req_mk.col_id_req) "+
                        "INNER JOIN tbl_mahasiswa ON (tbl_mahasiswa.col_nim = tbl_req_materi_kuliah.col_nim) "+
                        "INNER JOIN tbl_prodi_si ON (tbl_prodi_si.col_id_prodi_si = "+
                        "tbl_mahasiswa.col_id_prodi_si) INNER JOIN tbl_fakultas ON "+
                        "(tbl_fakultas.col_id_fakultas = tbl_prodi_si.col_id_fakultas) "+
                        "INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_pt) "+
                        "INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = tbl_pt.col_id_pt) "+
                        "SET tbl_respon_req_mk.col_status = 1 "+
                        "WHERE tbl_admin.col_nip = \'"+idUser+"\' AND tbl_respon_req_mk.col_nip IS NULL");
                
                //UPDATE NOTIFIKASI REQUEST MATERI KULIAH
                int i2 = statement.executeUpdate("UPDATE tbl_req_materi_kuliah "+
                        "INNER JOIN tbl_mahasiswa ON (tbl_mahasiswa.col_nim = tbl_req_materi_kuliah.col_nim) "+
                        "INNER JOIN tbl_prodi_si ON (tbl_prodi_si.col_id_prodi_si = "+
                        "tbl_mahasiswa.col_id_prodi_si) INNER JOIN tbl_fakultas ON "+
                        "(tbl_fakultas.col_id_fakultas = tbl_prodi_si.col_id_fakultas) "+
                        "INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_pt) "+
                        "INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = tbl_pt.col_id_pt) "+
                        "SET tbl_req_materi_kuliah.col_read_admin = 1 "+
                        "WHERE tbl_admin.col_nip = \'"+idUser+"\' AND tbl_req_materi_kuliah.col_read_admin = 0");
                
                
                //UPDATE NOTIFIKASI MESSAGE
                int j = statement.executeUpdate("UPDATE tbl_message "
                        + "SET col_status = 1 WHERE col_penerima = \'"+idUser+"\' AND col_status = 0");
                
                //UPDATE NOTIFIKASI FORUM DISKUSI
                int k = statement.executeUpdate("UPDATE tbl_read_komentar SET col_status = 1 "
                        + "WHERE col_id_peserta = \'"+idUser+"\' AND col_status = 0");
                
                //UPDATE NOTIFIKASI RESPON FEEDBACK
                int m = statement.executeUpdate("UPDATE tbl_respon_fb INNER JOIN tbl_fb ON "+
                        "(tbl_fb.col_id_fb = tbl_respon_fb.col_id_fb) INNER JOIN tbl_mahasiswa "+
                        "ON (tbl_mahasiswa.col_nim = tbl_fb.col_nim) INNER JOIN tbl_prodi_si "+
                        "ON (tbl_prodi_si.col_id_prodi_si = tbl_mahasiswa.col_id_prodi_si) "+
                        "INNER JOIN tbl_fakultas ON (tbl_fakultas.col_id_fakultas = "+
                        "tbl_prodi_si.col_id_fakultas) INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = "+
                        "tbl_fakultas.col_id_pt) INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = "+
                        "tbl_pt.col_id_pt)SET tbl_respon_fb.col_status = 1 "+
                        "WHERE tbl_admin.col_nip = \'"+idUser+"\' AND "+
                        "col_responden != \'"+idUser+"\'");
                
                //UPDATE NOTIFIKASI FEEDBACK
                int m2 = statement.executeUpdate("UPDATE tbl_fb "+
                        "INNER JOIN tbl_mahasiswa "+
                        "ON (tbl_mahasiswa.col_nim = tbl_fb.col_nim) INNER JOIN tbl_prodi_si "+
                        "ON (tbl_prodi_si.col_id_prodi_si = tbl_mahasiswa.col_id_prodi_si) "+
                        "INNER JOIN tbl_fakultas ON (tbl_fakultas.col_id_fakultas = "+
                        "tbl_prodi_si.col_id_fakultas) INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = "+
                        "tbl_fakultas.col_id_pt) INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = "+
                        "tbl_pt.col_id_pt)SET tbl_fb.col_read_admin = 1 "+
                        "WHERE tbl_admin.col_nip = \'"+idUser+"\' AND "+
                        "col_read_admin = 0");
                
            }catch(SQLException ex){
                out.println(ex.getMessage());
            }
        }
        
        //Mendapatkan Jumlah Notifikasi Baru
        try{
            //NOTIFIKASI REQUEST MATERI KULIAH
            Connection koneksi = Koneksi.getKoneksi();
            Statement statement = koneksi.createStatement();
            ResultSet rs = statement.executeQuery("SELECT col_id_req FROM tbl_req_materi_kuliah "+
                    "INNER JOIN tbl_mahasiswa ON (tbl_mahasiswa.col_nim = tbl_req_materi_kuliah.col_nim) "+
                    "INNER JOIN tbl_prodi_si ON (tbl_prodi_si.col_id_prodi_si = "+
                    "tbl_mahasiswa.col_id_prodi_si) INNER JOIN tbl_fakultas ON "+
                    "(tbl_fakultas.col_id_fakultas = tbl_prodi_si.col_id_fakultas) "+
                    "INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_pt) "+
                    "INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = tbl_pt.col_id_pt) "+
                    "WHERE tbl_admin.col_nip = \'"+idUser+"\' AND tbl_req_materi_kuliah.col_read_admin = 0");
            
            while(rs.next()){
                jumlahUnseen++;
            }
            
            //NOTIFIKASI RESPON REQUEST MATERI KULIAH
            rs = statement.executeQuery("SELECT col_id_respon_req_mk FROM tbl_respon_req_mk INNER JOIN tbl_req_materi_kuliah "+
                    "ON (tbl_req_materi_kuliah.col_id_req = tbl_respon_req_mk.col_id_req) "+
                    "INNER JOIN tbl_mahasiswa ON (tbl_mahasiswa.col_nim = tbl_req_materi_kuliah.col_nim) "+
                    "INNER JOIN tbl_prodi_si ON (tbl_prodi_si.col_id_prodi_si = "+
                    "tbl_mahasiswa.col_id_prodi_si) INNER JOIN tbl_fakultas ON "+
                    "(tbl_fakultas.col_id_fakultas = tbl_prodi_si.col_id_fakultas) "+
                    "INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_pt) "+
                    "INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = tbl_pt.col_id_pt) "+
                    "WHERE tbl_admin.col_nip = \'"+idUser+"\' AND tbl_respon_req_mk.col_status = 0 "+
                    "AND tbl_respon_req_mk.col_nip IS NULL");
            
            while(rs.next()){
                jumlahUnseen++;
            }
            
            //NOTIFIKASI MESSAGE BARU
            rs = statement.executeQuery("SELECT col_id_message FROM tbl_message WHERE col_penerima "
                    + "= \'"+idUser+"\' AND col_status = 0");
            while(rs.next()){
                jumlahUnseen++;
            }
            
            //NOTIFIKASI Komentar Forum Diskusi Baru
            rs = statement.executeQuery("SELECT col_status FROM tbl_read_komentar "
                    + "WHERE col_id_peserta = \'"+idUser+"\' AND col_status = 0");
            while(rs.next()){
                jumlahUnseen++;
            }
            
            //NOTIFIKASI FEEDBACK
            rs = statement.executeQuery("SELECT col_id_fb FROM tbl_fb INNER JOIN tbl_mahasiswa "+
                        "ON (tbl_mahasiswa.col_nim = tbl_fb.col_nim) INNER JOIN tbl_prodi_si "+
                        "ON (tbl_prodi_si.col_id_prodi_si = tbl_mahasiswa.col_id_prodi_si) "+
                        "INNER JOIN tbl_fakultas ON (tbl_fakultas.col_id_fakultas = "+
                        "tbl_prodi_si.col_id_fakultas) INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = "+
                        "tbl_fakultas.col_id_pt) INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = "+
                        "tbl_pt.col_id_pt) WHERE tbl_admin.col_nip = \'"+idUser+"\' AND "+
                        "col_read_admin = 0");
            while(rs.next()){
                jumlahUnseen++;
            }
            
            //NOTIFIKASI RESPON FEEDBACK
             rs = statement.executeQuery("SELECT col_id_respon_fb FROM tbl_respon_fb INNER JOIN tbl_fb "+
                    "ON (tbl_fb.col_id_fb = tbl_respon_fb.col_id_fb) INNER JOIN tbl_mahasiswa "+
                    "ON (tbl_mahasiswa.col_nim = tbl_fb.col_nim) INNER JOIN tbl_prodi_si "+
                    "ON (tbl_prodi_si.col_id_prodi_si = tbl_mahasiswa.col_id_prodi_si) "+
                    "INNER JOIN tbl_fakultas ON (tbl_fakultas.col_id_fakultas = "+
                    "tbl_prodi_si.col_id_fakultas) INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = "+
                    "tbl_fakultas.col_id_pt) INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = "+
                    "tbl_pt.col_id_pt) WHERE tbl_admin.col_nip = \'"+idUser+"\' AND "+
                    "tbl_respon_fb.col_status = 0 AND col_responden != \'"+idUser+"\'");
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
