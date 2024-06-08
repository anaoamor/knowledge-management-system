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
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author ASUS
 */
@MultipartConfig
public class CreateMateriKuliah extends HttpServlet {

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

        String kodeMatkul = request.getParameter("id-matkul");
        String namaMateri = request.getParameter("nama-materi");
        String deskripsi = request.getParameter("deskripsi");
        Part file = request.getPart("file");
        String fileAuthor = request.getParameter("file-author");
        HttpSession session = request.getSession();
        String idUser = (String) session.getAttribute("idUser");
        String namaUser = "";
        String idMateriKuliah = "";
        String lokasiTarget = "";
        
        try{
            //MENDAPATKAN NAMA USER
            Connection koneksi = Koneksi.getKoneksi();
            PreparedStatement prepare;
            String sql1 = "SELECT col_nama_mhs FROM tbl_mahasiswa WHERE col_nim = ?";
            prepare = koneksi.prepareStatement(sql1);
            prepare.setString(1, idUser);
            
            ResultSet rs1 = prepare.executeQuery();
            while(rs1.next()){
                namaUser = rs1.getString("col_nama_mhs");
            }
            
            //INSERT JUDUL, DESKRIPSI, DAN FILE AUTHOR
            String sql2 = "INSERT INTO tbl_materi_kuliah (col_nama, col_deskripsi, col_jumlah_download, "+
                    "col_upload_by, col_tgl_upload, col_author_file, col_kode_matkul, col_nim) VALUES (?, ?, "+
                    "0, ?, NOW(), ?, ?, ?)";
            prepare = koneksi.prepareStatement(sql2);
            prepare.setString(1, namaMateri);
            prepare.setString(2, deskripsi);
            prepare.setString(3, namaUser);
            prepare.setString(4, fileAuthor);
            prepare.setString(5, kodeMatkul);
            prepare.setString(6, idUser);
            prepare.executeUpdate();
            
            //MENDAPATKAN ID MATERI KULIAH YANG DINSERTKAN
            String sql3 = "SELECT col_id_materi_kuliah FROM tbl_materi_kuliah ORDER BY col_id_materi_kuliah "+
                    "DESC LIMIT 1";
            prepare = koneksi.prepareStatement(sql3);
            ResultSet rs3 = prepare.executeQuery();
            while(rs3.next()){
                idMateriKuliah = rs3.getString("col_id_materi_kuliah");
            }
            
            //CREATE FILE MATERI KULIAH
            String fileName = Paths.get(file.getSubmittedFileName()).getFileName().toString();
            if(fileName != ""){
                InputStream fileContent = file.getInputStream();

                //Ekstensi File
                String ekstensiFile = "";
                if(fileName.lastIndexOf(".") != -1){
                    ekstensiFile = fileName.substring(fileName.lastIndexOf(".")+1);
                }

                //ALIRAN KELUARAN C:\Users\ASUS\Documents\NetBeansProjects
                lokasiTarget = "C:\\Users\\Asus\\Documents\\Netbeans Projects\\KMSMahasiswaSI\\build\\web\\materi-kuliah/"+idMateriKuliah+"."+ekstensiFile;
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
            }
            
            //UPDATE FILEMATERI KULIAH
            String sql4 = "UPDATE tbl_materi_kuliah SET col_file = ?, col_read_kaprodi = 0 WHERE col_id_materi_kuliah = ?";
            prepare = koneksi.prepareStatement(sql4);
            prepare.setString(1, lokasiTarget.substring(55));
            prepare.setString(2, idMateriKuliah);
            
            prepare.executeUpdate();
            
            out.println("<script>alert(\'Materi kuliah barhasil disimpan!');window.location.href = \'MataKuliah.jsp?id-matkul="+kodeMatkul+"\';</script>");
           
        }catch(SQLException e){
            out.println(e.getMessage());
        }catch(NullPointerException ex){
            out.println(ex.getCause());
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
