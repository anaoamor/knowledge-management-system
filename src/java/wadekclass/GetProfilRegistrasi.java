/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wadekclass;

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
import kmsclass.Koneksi;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetProfilRegistrasi extends HttpServlet {

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
        String tipeUser = request.getParameter("tipe");
        JSONObject jo = new JSONObject();
        
        //MENDAPATKAN RECORD MAHASISWA REGISTRASI
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "SELECT col_nim, "
                        + "col_nama_mhs, col_tgl_lahir, col_jenis_kelamin, col_agama, col_no_hp, "
                        + "col_alamat, col_nama_pt, col_angkatan, col_status, col_email FROM "
                        + "tbl_mahasiswa  INNER JOIN tbl_prodi_si ON (tbl_prodi_si.col_id_prodi_si = "
                        + "tbl_mahasiswa.col_id_prodi_si) INNER JOIN tbl_fakultas ON (tbl_fakultas.col_id_fakultas = tbl_prodi_si.col_id_prodi_si) "
                        + "INNER JOIN tbl_pt ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_pt) WHERE col_nim = ?";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, idUser);
            ResultSet rs = prepare.executeQuery();
            while(rs.next()){
                jo.put("nim", rs.getString("col_nim"));
                    jo.put("namaMahasiswa", rs.getString("col_nama_mhs"));
                    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String dateString = dateFormat.format(rs.getDate("col_tgl_lahir"));
                    jo.put("tglLahir", dateString);
                    jo.put("jenisKelamin", rs.getString("col_jenis_kelamin"));
                    jo.put("agama", rs.getString("col_agama"));
                    jo.put("noHp", rs.getString("col_no_hp"));
                    jo.put("alamat", rs.getString("col_alamat"));
                    jo.put("pt", rs.getString("col_nama_pt"));
                    jo.put("angkatan", rs.getInt("col_angkatan"));
                    jo.put("status", rs.getInt("col_status"));
                    jo.put("email", rs.getString("col_email"));
                    
                    out.println(jo.toJSONString());
            }
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
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
