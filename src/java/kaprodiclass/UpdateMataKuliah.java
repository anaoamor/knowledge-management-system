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
import kmsclass.Koneksi;

/**
 *
 * @author ASUS
 */
public class UpdateMataKuliah extends HttpServlet {

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
        
        String noPage = request.getParameter("no");
        String idKurikulum = request.getParameter("id-kurikulum");
        String idKelompok = request.getParameter("id-kelompok");
        String kodeMatkulLama = request.getParameter("id-matkul");
        String kodeMatkulBaru = request.getParameter("kode_matkul");
        String namaMatkul = request.getParameter("nama_matkul");
        String sks = request.getParameter("sks");
        String deskripsi = request.getParameter("deskripsi");
        String prasyarat = request.getParameter("prasyarat");
        String standarKompetensi = request.getParameter("standar-kompetensi");
        
        //UPDATE tbl_matkul
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "UPDATE tbl_matkul SET col_kode_matkul = ?, col_nama_matkul = ?, col_sks = ?, "+
                    "col_deskripsi_matkul = ?, col_prasyarat = ?, col_standar_kompetensi = ? WHERE col_kode_matkul = ?";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, kodeMatkulBaru);
            prepare.setString(2, namaMatkul);
            prepare.setString(3, sks);
            prepare.setString(4, deskripsi);
            prepare.setString(5, prasyarat);
            prepare.setString(6, standarKompetensi);
            prepare.setString(7, kodeMatkulLama);
            int i = prepare.executeUpdate();
            if(i > 0){
                if(noPage.equals("0")){
                    out.println("<script>window.location = \'KaprodiSI/RecordMataKuliahKurikulum.jsp?no-0&id-kurikulum="+idKurikulum+"&id-matkul="+kodeMatkulBaru+"\';</script>");
                }else{
                    out.println("<script>window.location = \'KaprodiSI/RecordMataKuliahKurikulum.jsp?no=1&id-kurikulum="+idKurikulum+"&id-kelompok="+idKelompok+"&id-matkul="+kodeMatkulBaru+"\';</script>");
                }
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
