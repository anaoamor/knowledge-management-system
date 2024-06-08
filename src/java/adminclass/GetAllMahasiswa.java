/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adminclass;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kmsclass.Koneksi;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetAllMahasiswa extends HttpServlet {

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
        
        String tahunAngkatan = request.getParameter("tahun");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        //MENDAPATKAN MAHASISWA ANGKATAN
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "SELECT col_nim, col_nama_mhs, col_angkatan, tbl_mahasiswa.col_status "+
                    "FROM tbl_mahasiswa INNER JOIN tbl_prodi_si ON (tbl_prodi_si.col_id_prodi_si = "+
                    "tbl_mahasiswa.col_id_prodi_si) INNER JOIN tbl_fakultas ON (tbl_fakultas.col_id_fakultas = "+
                    "tbl_prodi_si.col_id_fakultas) INNER JOIN tbl_pt ON "+
                    "(tbl_pt.col_id_pt = tbl_pt.col_id_pt) INNER JOIN tbl_admin ON "+
                    "(tbl_admin.col_id_pt = tbl_pt.col_id_pt) WHERE tbl_admin.col_nip = ? AND "+
                    "col_angkatan = ? AND tbl_mahasiswa.col_nip IS NOT NULL";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, idUser);
            prepare.setString(2, tahunAngkatan);
            ResultSet rs = prepare.executeQuery();
            while(rs.next()){
                Map m = new LinkedHashMap(4);
                m.put("nim", rs.getString("col_nim"));
                m.put("namaMahasiswa", rs.getString("col_nama_mhs"));
                m.put("angkatan", rs.getString("col_angkatan"));
                if(rs.getString("col_status").equals("0")){
                    m.put("status", "Non Aktif");
                }else
                    m.put("status", "Aktif");
                ja.add(m);
            }
            
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        jo.put("listMahasiswa", ja);
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
