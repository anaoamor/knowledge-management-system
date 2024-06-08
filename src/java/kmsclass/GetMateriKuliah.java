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
public class GetMateriKuliah extends HttpServlet {

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
            
        String idMateri = request.getParameter("kode");
        
        JSONObject jo = new JSONObject();
        
        //MENDAPATKAN DESKRIPSI MATERI KULIAH
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("SELECT "+
                    "col_nama, col_deskripsi, col_jumlah_download, col_upload_by, col_tgl_upload, "+
                    "col_file, col_author_file, col_nim FROM tbl_materi_kuliah WHERE col_id_materi_kuliah = ?");
            statement.setString(1, idMateri);
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                jo.put("namaMateri", rs.getString("col_nama"));
                jo.put("deskripsi", rs.getString("col_deskripsi"));
                jo.put("jumlahDownload", rs.getInt("col_jumlah_download"));
                jo.put("uploadBy", rs.getString("col_upload_by"));
                DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                String dateString = dateFormat.format(rs.getDate("col_tgl_upload"));
                jo.put("tglUpload", dateString);
                jo.put("file", rs.getString("col_file"));
                jo.put("authorFile", rs.getString("col_author_file"));
                jo.put("nim", rs.getString("col_nim"));
                
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
