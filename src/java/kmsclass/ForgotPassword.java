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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kmsclass.Koneksi;
import kmsclass.Password;

/**
 *
 * @author ASUS
 */
public class ForgotPassword extends HttpServlet {

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
            throws ServletException, IOException, MessagingException {
        
        //MENDAPATKAN TIPE USER, USERNAME DAN EMAIL USER
        String tipeUser = request.getParameter("user");
        String username = request.getParameter("username");
        String email =  request.getParameter("email");
        
        //TIPE USER: MAHASISWA
        if(tipeUser.equals("0")){
            try{
                Connection konek = Koneksi.getKoneksi();
                PreparedStatement statement = konek.prepareStatement("SELECT col_email, col_nama_mhs, col_username FROM tbl_mahasiswa WHERE col_username = ? AND "
                        + "col_email = ?");
                statement.setString(1, username);
                statement.setString(2, email);
                ResultSet rs = statement.executeQuery();
                
                if(rs.next()){
                    String emailRecipient = rs.getString("col_email");
                    String namaMahasiswa = rs.getString("col_nama_mhs");
                    String usernameMahasiswa = rs.getString("col_username");
                    
                    String password = Password.generateNewPassword(tipeUser, username, email);
                    
                    //E-mail recovery password
                    SendEmail.send(emailRecipient, namaMahasiswa, usernameMahasiswa, password);
                   
                    response.sendRedirect("CheckEmailForgotPassword.jsp");
                } else
                    response.sendRedirect("RecordNotFound.jsp");
            }catch(SQLException ex){

            }
        } else if(tipeUser.equals("2")){
            try{
                Connection konek = Koneksi.getKoneksi();
                PreparedStatement statement = konek.prepareStatement("SELECT col_email, col_nama_kaprodi, col_username FROM tbl_kaprodi_si WHERE col_username = ? AND "
                        + "col_email = ?");
                statement.setString(1, username);
                statement.setString(2, email);
                ResultSet rs = statement.executeQuery();
                
                if(rs.next()){
                    String emailRecipient = rs.getString("col_email");
                    String namaKaprodi = rs.getString("col_nama_kaprodi");
                    String usernameKaprodi = rs.getString("col_username");
                    
                    String password = Password.generateNewPassword(tipeUser, username, email);
                    
                    //E-mail recovery password
                    SendEmail.send(emailRecipient, namaKaprodi, usernameKaprodi, password);
                   
                    response.sendRedirect("CheckEmailForgotPassword.jsp");;
                } else
                    response.sendRedirect("RecordNotFound.jsp");
            }catch(SQLException ex){

            }
        } else if(tipeUser.equals("1")){
            try{
                Connection konek = Koneksi.getKoneksi();
                PreparedStatement statement = konek.prepareStatement("SELECT col_email, col_nama_wadek, col_username FROM tbl_wadek_kemahasiswaan WHERE col_username = ? AND "
                        + "col_email = ?");
                statement.setString(1, username);
                statement.setString(2, email);
                ResultSet rs = statement.executeQuery();
                
                if(rs.next()){
                    String emailRecipient = rs.getString("col_email");
                    String namaWadek = rs.getString("col_nama_wadek");
                    String usernameWadek = rs.getString("col_username");
                    
                    String password = Password.generateNewPassword(tipeUser, username, email);
                    
                    //E-mail recovery password
                    SendEmail.send(emailRecipient, namaWadek, usernameWadek, password);
                   
                    response.sendRedirect("CheckEmailForgotPassword.jsp");
                } else
                    response.sendRedirect("RecordNotFound.jsp");
            }catch(SQLException ex){

            }
        } else if(tipeUser.equals("3")){
            try{
                Connection konek = Koneksi.getKoneksi();
                PreparedStatement statement = konek.prepareStatement("SELECT col_email, col_nama_admin, col_username FROM tbl_admin WHERE col_username = ? AND "
                        + "col_email = ?");
                statement.setString(1, username);
                statement.setString(2, email);
                ResultSet rs = statement.executeQuery();
                
                if(rs.next()){
                    String emailRecipient = rs.getString("col_email");
                    String namaAdmin = rs.getString("col_nama_admin");
                    String usernameAdmin = rs.getString("col_username");
                    
                    String password = Password.generateNewPassword(tipeUser, username, email);
                    
                    //E-mail recovery password
                    SendEmail.send("moriza.husna13@mhs.uinjkt.ac.id", namaAdmin, usernameAdmin, password);
                   
                    response.sendRedirect("CheckEmailForgotPassword.jsp");
                } else
                    response.sendRedirect("RecordNotFound.jsp");
            }catch(SQLException ex){

            }
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
        try {
            processRequest(request, response);
        } catch (MessagingException ex) {
            Logger.getLogger(ForgotPassword.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (MessagingException ex) {
            Logger.getLogger(ForgotPassword.class.getName()).log(Level.SEVERE, null, ex);
        }
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
