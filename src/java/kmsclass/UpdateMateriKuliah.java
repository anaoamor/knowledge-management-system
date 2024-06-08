/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kmsclass;

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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author ASUS
 */
@MultipartConfig
public class UpdateMateriKuliah extends HttpServlet {

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
        
        //Variable untuk nama materi
        String idRequestPage = request.getParameter("no");
        String id = request.getParameter("id-materi");
        String namaMateri = request.getParameter("nama-materi");
        String deskripsiMateriKuliah = request.getParameter("deskripsi");
        String fileAuthor = request.getParameter("file-author");
        Part file = request.getPart("file-update");
        
        int i = 0;
        
        try{
            //(file != null)
            String fileName = Paths.get(file.getSubmittedFileName()).getFileName().toString();
            if(!fileName.equals("")){
                
                InputStream fileContent = file.getInputStream();

                String ekstensiFile = "";
                if(fileName.lastIndexOf(".") != -1){
                    ekstensiFile = fileName.substring(fileName.lastIndexOf(".")+1);
                }

                //ALIRAN KELUARAN
                String lokasiTarget = "C:\\Users\\Asus\\Documents\\Netbeans Projects\\KMSMahasiswaSI\\build\\web\\materi-kuliah/"+id+"."+ekstensiFile;
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

                //String Update Materi Kuliah
                Connection koneksi = Koneksi.getKoneksi();
                Statement statement = koneksi.createStatement();
                i = statement.executeUpdate("UPDATE tbl_materi_kuliah SET col_nama = \'"+namaMateri+"\', col_deskripsi = \'"+deskripsiMateriKuliah+"\', "
                            + "col_file = \'"+lokasiTarget.substring(55)+"\', col_author_file = \'"+fileAuthor+"\', col_read_kaprodi = 0 WHERE col_id_materi_kuliah = "
                            + id);
                  
            } else{
                Connection koneksi = Koneksi.getKoneksi();
                Statement statement = koneksi.createStatement();
                i = statement.executeUpdate("UPDATE tbl_materi_kuliah SET col_nama = \'"+namaMateri+"\', col_deskripsi = \'"+deskripsiMateriKuliah+"\', "
                    + " col_author_file = \'"+fileAuthor+"\', col_read_kaprodi = 0 WHERE col_id_materi_kuliah = "
                    + id);
               
            }
        }catch(NullPointerException e){
            out.println(e.getCause());
        }
        
        catch(SQLException ex){
            out.println(ex.getMessage());
        }
        
        if(i > 0 ){
            if(idRequestPage.equals("0")){
                out.println("<script>alert(\'Materi kuliah berhasil diupdate!\');window.location = \'SatuMateriKuliah.jsp?id-materi="+id+"\';</script>");
            }else
                out.println("<script>alert(\'Materi kuliah berhasil diupdate!\');window.location = \'RecordMyUpload.jsp?id-materi="+id+"\';</script>");
                
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
