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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class VerifikasiKode extends HttpServlet {

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

        String nim = request.getParameter("nim");
        String kode = request.getParameter("kode");
        
        HttpSession session;
        
        //MENDAPATKAN KODE VERIFIKASI YANG DIGENERATE OLEH WADEK KEMAHASISWAAN
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT col_username, col_password, col_kode_verifikasi FROM tbl_mahasiswa "+
                    "WHERE col_nim = ? AND col_kode_verifikasi = ?";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, nim);
            prepare.setString(2, kode);
            ResultSet rs1 = prepare.executeQuery();
            if(rs1.next()){
                //MENDAPATKAN NIP WADEK KEMAHASISWAAN 
                String sql2 = "SELECT tbl_wadek_kemahasiswaan.col_nip FROM tbl_wadek_kemahasiswaan "+
                        "INNER JOIN tbl_fakultas ON (tbl_fakultas.col_id_fakultas = tbl_wadek_kemahasiswaan.col_id_fakultas) "+
                        "INNER JOIN tbl_prodi_si ON (tbl_prodi_si.col_id_fakultas = tbl_fakultas.col_id_fakultas) "+
                        "INNER JOIN tbl_mahasiswa ON (tbl_mahasiswa.col_id_prodi_si = tbl_prodi_si.col_id_prodi_si) "+
                        "WHERE tbl_mahasiswa.col_nim = ?";
                prepare = koneksi.prepareStatement(sql2);
                prepare.setString(1, nim);
                ResultSet rs2 = prepare.executeQuery();
                while(rs2.next()){
                    String sql3 = "UPDATE tbl_mahasiswa SET col_nip = ? WHERE col_nim = ?";
                    prepare = koneksi.prepareStatement(sql3);
                    prepare.setString(1, rs2.getString("col_nip"));
                    prepare.setString(2, nim);
                    int i = prepare.executeUpdate();
                }
                
                //CREATE RECORD USER PADA TABLE USER
                String sql4 = "INSERT INTO tbl_user(col_id_user, col_username, col_password, "+
                "col_id_level) VALUES (\'"+nim+"\', \'"+rs1.getString("col_username")+"\', \'"+rs1.getString("col_password")+"\', 0)";
                prepare = koneksi.prepareStatement(sql4);
                int j = prepare.executeUpdate();
                if(j > 0){
                    session = request.getSession(true);
                    session.setAttribute("idUser", nim);
                    session.setAttribute("tipeUser", 0);
                    out.println("<script>window.location = \'HomeMahasiswa.jsp\';</script>");
                }
            }else{
                out.println("<script>alert(\'Kode verifikasi salah!\'); window.location = \'VerifikasiAccount.jsp\';</script>");
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
