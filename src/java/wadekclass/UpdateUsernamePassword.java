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
public class UpdateUsernamePassword extends HttpServlet {

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
        
        String passwordLama = request.getParameter("password_lama");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        String usernameBaru = request.getParameter("username_baru");
        String passwordBaru = request.getParameter("password_baru");
        
        //AUTENTIFIKASI PASSWORD LAMA USER
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT col_id_level FROM tbl_user "+
                    "WHERE col_id_user = ? AND col_password = md5(?)";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idUser);
            prepare.setString(2, passwordLama);
            ResultSet rs1 = prepare.executeQuery();
            if(rs1.next()){
                int idLevelUser = rs1.getInt("col_id_level");
                switch(idLevelUser){
                    case 1:{
                        String sql2 = "UPDATE tbl_wadek_kemahasiswaan INNER JOIN tbl_user ON "+
                                "(tbl_user.col_id_user = tbl_wadek_kemahasiswaan.col_nip) SET tbl_user.col_username = ?, "+
                                "tbl_user.col_password = md5(?), tbl_wadek_kemahasiswaan.col_username = ?, "+
                                "tbl_wadek_kemahasiswaan.col_password = md5(?) WHERE tbl_user.col_id_user = ?";
                        prepare = koneksi.prepareStatement(sql2);
                        prepare.setString(1, usernameBaru);
                        prepare.setString(2, passwordBaru);
                        prepare.setString(3, usernameBaru);
                        prepare.setString(4, passwordBaru);
                        prepare.setString(5, idUser);
                        int i = prepare.executeUpdate();
                        
                        out.println("<script>alert(\'User account berhasil diupdate!\'); window.location = \'WadekKemahasiswaan/Setelan.jsp\';</script>");
//                      
                    }
                }
            }else{
                out.println("<script>alert(\'Password lama anda salah!\'); window.location = \'WadekKemahasiswaan/ChangeUserAccount.jsp\'; </script>");
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
