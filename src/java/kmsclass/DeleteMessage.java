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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class DeleteMessage extends HttpServlet {

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
            
        String[] idRespondenDeleteMessage = request.getParameterValues("id_delete_message[]");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        JSONObject jo = new JSONObject();
        int i = 0;
        
        //MENGHAPUS SEMUA MESSAGE DARI RESPONDEN
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            
            for(int j = 0; j < idRespondenDeleteMessage.length; j++){
                String sql = "DELETE FROM tbl_message WHERE ((col_pengirim = ? AND col_penerima = ?)"+
                        " OR (col_pengirim = ? AND col_penerima = ?))";
                prepare = koneksi.prepareStatement(sql);
                prepare.setString(1, idRespondenDeleteMessage[j]);
                prepare.setString(2, idUser);
                prepare.setString(3, idUser);
                prepare.setString(4, idRespondenDeleteMessage[j]);
                i += prepare.executeUpdate();
            }
        }catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        jo.put("jumlahDelete", i);
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
