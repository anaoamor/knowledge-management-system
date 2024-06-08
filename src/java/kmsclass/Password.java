/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kmsclass;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author ASUS
 */
public class Password {
    
    /**
     * Men-generate password baru untuk ForgotPassword
     * @return 
     */
    public static String generateNewPassword(String tipeUser, String username, String email){
        String alpha_numeric_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        int count = 8;
        StringBuilder builder = new StringBuilder();
        
        while(count-- != 0){
            int character = (int) (Math.random() * alpha_numeric_string.length());
            builder.append(alpha_numeric_string.charAt(character));
        }
        
        //TIPE USER: MAHASISWA
        if(tipeUser.equals("0")){
            try{
                Connection koneksi = Koneksi.getKoneksi();
                Statement statement = koneksi.createStatement();
                int i = statement.executeUpdate("UPDATE tbl_mahasiswa SET col_password = md5(\'"+builder.toString()+"\') WHERE col_username = \'"+username+"\' and col_email = \'"+email+"\'");
                
            } catch(SQLException ex){
                System.out.println(ex.getMessage());
            }
        } else if(tipeUser.equals("2")){ //TIPE USER: KAPRODI SI
            try{
                Connection koneksi = Koneksi.getKoneksi();
                Statement statement = koneksi.createStatement();
                int i = statement.executeUpdate("UPDATE tbl_kaprodi_si SET col_password = md5(\'"+builder.toString()+"\') WHERE col_username = \'"+username+"\' and col_email = \'"+email+"\'");
                
            } catch(SQLException ex){
                System.out.println(ex.getMessage());
            }
        } else if(tipeUser.equals("1")){ //WADEK III/KEMAHASISWAAN
            try{
                Connection koneksi = Koneksi.getKoneksi();
                Statement statement = koneksi.createStatement();
                int i = statement.executeUpdate("UPDATE tbl_wadek_kemahasiswaan SET col_password = md5(\'"+builder.toString()+"\') WHERE col_username = \'"+username+"\' and col_email = \'"+email+"\'");
                
            } catch(SQLException ex){
                System.out.println(ex.getMessage());
            }
        } else if(tipeUser.equals("3")){ //ADMIN
            try{
                Connection koneksi = Koneksi.getKoneksi();
                Statement statement = koneksi.createStatement();
                int i = statement.executeUpdate("UPDATE tbl_admin SET col_password = md5(\'"+builder.toString()+"\') WHERE col_username = \'"+username+"\' and col_email = \'"+email+"\'");
                
            } catch(SQLException ex){
                System.out.println(ex.getMessage());
            }
        }
        
        return builder.toString();
    }
}
