/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kaprodiclass;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import kmsclass.Koneksi;

/**
 *
 * @author ASUS
 */
@MultipartConfig
public class UpdateProfilImage extends HttpServlet {

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
        Part image = request.getPart("file-img");
        String fileName = Paths.get(image.getSubmittedFileName()).getFileName().toString();
        if(fileName != "" && (image.getSize() < 102400)){
            
            InputStream fileContent = image.getInputStream();

            //ALIRAN KELUARAN 
            String lokasiTarget = "C:\\Users\\Asus\\Documents\\Netbeans Projects\\KMSMahasiswaSI\\build\\web\\profil-pict\\"+idUser+".png";
            File fileOutput = new File(lokasiTarget);
            FileOutputStream keluaran = new FileOutputStream(fileOutput);
            BufferedInputStream bis = new BufferedInputStream(fileContent);
            BufferedOutputStream bos = new BufferedOutputStream(keluaran);

            int nilai;
            while((nilai = bis.read()) != -1){
                bos.write(nilai);
            }
            bis.close();
            fileContent.close();
            bos.close();
            keluaran.close();

            try{
                Connection koneksi = Koneksi.getKoneksi();
                PreparedStatement statement = koneksi.prepareStatement("UPDATE tbl_user SET col_user_image = ? WHERE col_id_user = ?");
                statement.setString(1, lokasiTarget.substring(55));
                statement.setString(2, idUser);
                int i = statement.executeUpdate();
                out.println("<script type=\"text/javascript\"> window.location = \'KaprodiSI/User.jsp\';</script>");
            }catch(SQLException ex){

                out.println("<html>"+ex.getMessage()+"</html>");
            }
        }else{
            out.println("<script type=\"text/javascript\"> alert(\'Image Invalid!\'); window.location = \'KaprodiSI/User.jsp';</script>");
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
