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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kmsclass.Koneksi;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
public class GetFakultas extends HttpServlet {

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
        
        String idFakultas = request.getParameter("id");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        
        JSONObject jo = new JSONObject();
        
        //MENDAPATKAN RECORD PT DAN ADMIN KMS PT
        try{
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql = "SELECT col_nama_pt, col_nama_fakultas, col_alamat_fakultas, col_no_telp_fakultas, col_email_fakultas, "+
                    "col_nip FROM tbl_fakultas INNER JOIN tbl_pt "+
                    "ON (tbl_pt.col_id_pt = tbl_fakultas.col_id_pt) INNER JOIN tbl_admin ON (tbl_admin.col_id_pt = "+
                    "tbl_pt.col_id_pt) WHERE tbl_fakultas.col_id_fakultas = ?";
            prepare = koneksi.prepareStatement(sql);
            prepare.setString(1, idFakultas);
            ResultSet rs = prepare.executeQuery();
            while(rs.next()){
                jo.put("namaPT", rs.getString("col_nama_pt"));
                jo.put("namaFakultas", rs.getString("col_nama_fakultas"));
                jo.put("alamat", rs.getString("col_alamat_fakultas"));
                jo.put("noTelp", rs.getString("col_no_telp_fakultas"));
                jo.put("email", rs.getString("col_email_fakultas"));
                if(rs.getString("col_nip").equals(idUser)){
                    jo.put("adminFakultas", "YES");
                } else
                    jo.put("adminFakultas", "NO");
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
