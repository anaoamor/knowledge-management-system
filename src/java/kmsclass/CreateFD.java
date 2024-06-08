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
public class CreateFD extends HttpServlet {

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
        
        String topikFD = request.getParameter("topik-fd");
        String subbidang = request.getParameter("subbidang-fd");
        String deskripsi = request.getParameter("deskripsi");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        //INSERT FORUM DISKUSI BARU
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "INSERT INTO tbl_fd(col_topik_fd, col_subbidang_diskusi, "+
                    "col_deskripsi_fd, col_tgl, col_waktu, col_status, col_creator) "+
                    "VALUES (?, ?, ?, now(), now(), 'Progress', ?)";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, topikFD);
            prepare.setString(2, subbidang);
            prepare.setString(3, deskripsi);
            prepare.setString(4, idUser);
            
            int i = prepare.executeUpdate();
            
            //MENDAPATKAN ID FORUM DISKUSI YANG DIINSERTKAN
            String idFD = "";
            String sql1 = "SELECT col_id_fd FROM tbl_fd ORDER BY col_id_fd DESC LIMIT 1";
            ResultSet rs1 = prepare.executeQuery(sql1);
            while(rs1.next()){
                idFD = rs1.getString("col_id_fd");
            }
            
            //INSERT ID PESERTA FORUM DISKUSI
            String sql2 = "INSERT INTO tbl_peserta_fd (col_id_fd, col_id_peserta) VALUES "+
                    "(?, ?)";
            prepare = koneksi.prepareStatement(sql2);
            prepare.setString(1, idFD);
            prepare.setString(2, idUser);
            
            int j = prepare.executeUpdate();
            if(j > 0){
                
                //MENDAPATKAN ID LEVEL USER
                int idLevelUser = 0;
                String sql3 = "SELECT col_id_level FROM tbl_user WHERE col_id_user = ?";
                prepare = koneksi.prepareStatement(sql3);
                prepare.setString(1, idUser);
                ResultSet rs3 = prepare.executeQuery();
                while(rs3.next()){
                    idLevelUser = rs3.getInt("col_id_level");
                }
                
                String nextPage = "";
                switch(idLevelUser){
                    case 0:{
                        nextPage = "RecordFD.jsp";
                        break;
                    } case 2:{
                        nextPage = "KaprodiSI/RecordFD.jsp";
                        break;
                    } default:{
                        nextPage = "Admin/RecordFD.jsp";
                    }
                }
                out.println("<script>window.location = \'"+nextPage+"?id-fd="+idFD+"\';</script>");
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
