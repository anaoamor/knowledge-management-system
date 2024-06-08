/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kaprodiclass;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kmsclass.Koneksi;

/**
 *
 * @author ASUS
 */
public class UpdateProdi extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        String noPageBefore = request.getParameter("no");

        String idProdi = request.getParameter("id-prodi");
        String kaprodi = request.getParameter("kaprodi");
        String tahun = request.getParameter("tahun");
        String alamat = request.getParameter("alamat");
        String noTelepon = request.getParameter("no-telepon");
        String email = request.getParameter("email");
        String durasi = request.getParameter("durasi");
        String jumlahSKS = request.getParameter("jmlh-sks");
        String maksSem = request.getParameter("max-sem");
        String idKurikulum = request.getParameter("kurikulum");
        
        //UPDATE tbl_prodi
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "UPDATE tbl_prodi_si INNER JOIN tbl_kaprodi_si ON (tbl_kaprodi_si.col_nip = "+
                    "tbl_prodi_si.col_nip) SET col_tahun_berdiri = ?, col_alamat_prodi = ?, col_no_telp_prodi = ?, "+
                    "col_email_prodi = ?, col_durasi_program = ?, col_jumlah_sks = ?, col_batas_semester = ?, "+
                    "tbl_kaprodi_si.col_nama_kaprodi = ?, col_id_kurikulum = ? "+
                    "WHERE col_id_prodi_si = ?";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, tahun);
            prepare.setString(2, alamat);
            prepare.setString(3, noTelepon);
            prepare.setString(4, email);
            prepare.setString(5, durasi);
            prepare.setString(6, jumlahSKS);
            prepare.setString(7, maksSem);
            prepare.setString(8, kaprodi);
            prepare.setString(9, idKurikulum);
            prepare.setString(10, idProdi);
            
            int i = prepare.executeUpdate();
            
            if(i > 0){
                if(noPageBefore.equals("2"))
                    out.println("<script>window.location = \'KaprodiSI/RecordProdiSI.jsp?id-prodi="+idProdi+"\';</script>");
                else if(noPageBefore.equals("3"))
                    out.println("<script>window.location = \'Admin/RecordProdiSI.jsp?id-prodi="+idProdi+"\';</script>");
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
