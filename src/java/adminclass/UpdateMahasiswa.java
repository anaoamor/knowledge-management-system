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
import java.sql.SQLException;
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
public class UpdateMahasiswa extends HttpServlet {
    String formatTglLahir;

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
        
        //GET REQUEST PARAMETERS
        String tahunAngkatan = request.getParameter("tahun-angkatan");
        String nim = request.getParameter("nim");
        String namaMahasiswa = request.getParameter("nama");
        String tglLahir = getFormatTglLahir(request.getParameter("tgl_lahir"));
        String jenisKelamin = request.getParameter("jenis_kelamin");
        String noHp = request.getParameter("no_hp");
        String alamat = request.getParameter("alamat");
        String angkatan = request.getParameter("angkatan");
        String status = request.getParameter("status");
        String agama = request.getParameter("agama");
        String email = request.getParameter("email");
        
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement statement = koneksi.prepareStatement("UPDATE tbl_mahasiswa INNER JOIN tbl_user ON "
            + "(tbl_user.col_id_user = tbl_mahasiswa.col_nim) SET col_nim = ?, col_nama_mhs = ?, col_tgl_lahir = ?, "
            + "col_jenis_kelamin = ?, col_no_hp = ?, col_alamat = ?, col_angkatan = ?, col_status = ?, col_agama = ?, "
            + "col_email = ?, col_id_user = ? WHERE col_nim = ?");
            statement.setString(1, nim);
            statement.setString(2, namaMahasiswa);
            statement.setString(3, tglLahir);
            statement.setString(4, jenisKelamin);
            statement.setString(5, noHp);
            statement.setString(6, alamat);
            statement.setString(7, angkatan);
            statement.setString(8, status);
            statement.setString(9, agama);
            statement.setString(10, email);
            statement.setString(11, nim);
            statement.setString(12, nim);

            int i = statement.executeUpdate();
            
            if(i > 0){
                out.println("<script type=\"text/javascript\">window.location = \'Admin/RecordMahasiswa.jsp?tahun-angkatan="+tahunAngkatan+"&nim="+nim+"\';</script>");
            }
        }catch(SQLException ex){
            out.println("<html><head></head><body>"+ex.getMessage()+"</body></html>");

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

    /**
     * Mengembalikan format tanggal untuk MySQL
     */
    public String getFormatTglLahir(String tglLahir){
        formatTglLahir = tglLahir.substring(6, 10)+String.valueOf(tglLahir.charAt(5))+tglLahir.substring(3,5)+
                String.valueOf(tglLahir.charAt(2))+tglLahir.substring(0,2);
        
        return formatTglLahir;
    }
}
