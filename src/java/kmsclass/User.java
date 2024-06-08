package kmsclass;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import kmsclass.Koneksi;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sun.util.logging.PlatformLogger;

/**
 *
 * @author ASUS
 */
public class User {
    String tipeUser; 
    String username;
    String userImage;
    String password;
    String idUser;
    
    public User(){
        
    }
    
    public User(String tipeUser, String username, String password){
        this.tipeUser = tipeUser;
        this.username = username;
        this.password = password;
    }
    
    public User(String idUser, String userImage){
        this.idUser = idUser;
        this.userImage = userImage;
    }
    
    /**
     * Metode untuk mengautentifikasi user KMS
     * @param username
     * @param password
     * @param tipeUser
     * @return 
     */
    public int autentifikasi (String tipeUser, String username, String password){
        String enkripsiPassword = getEncryption(password);
        
        int jenisService = 0;
        
        //TIPE USER 1: MAHASISWA
        if(tipeUser.equals("0")){
            try{
                Connection koneksi = Koneksi.getKoneksi();
                PreparedStatement statement = koneksi.prepareStatement("SELECT col_nim, col_username, col_password FROM tbl_mahasiswa WHERE col_username = ? and col_password = ? AND col_nip IS NOT NULL");
                statement.setString(1, username);
                statement.setString(2, enkripsiPassword);
                ResultSet rs = statement.executeQuery();
                
                while(rs.next()){
                    idUser = rs.getString("col_nim");
                    jenisService = 0;
                }
                
            } catch(SQLException ex){
                System.out.println(ex.getMessage());
            }
        }
        
        //TIPE USER 2: KAPRODI_SI 
        else if(tipeUser.equals("2")){
            try{
                Connection koneksi = Koneksi.getKoneksi();;
                PreparedStatement statement = koneksi.prepareStatement("SELECT col_nip, col_username, col_password FROM tbl_kaprodi_si WHERE col_username = ? and col_password = ?");
                statement.setString(1, username);
                statement.setString(2, enkripsiPassword);
                ResultSet rs = statement.executeQuery();
                
                while(rs.next()){
                    idUser = rs.getString("col_nip");
                    jenisService = 2;
                }
                
            } catch(SQLException ex){
                System.out.println(ex.getMessage());
            }
        }
            
        //TIPE USER 3: Wadek III
        else if(tipeUser.equals("1")){
            try{
                Connection koneksi = Koneksi.getKoneksi();;
                PreparedStatement statement = koneksi.prepareStatement("SELECT col_nip, col_username, col_password FROM tbl_wadek_kemahasiswaan WHERE col_username = ? and col_password = ?");
                statement.setString(1, username);
                statement.setString(2, enkripsiPassword);
                ResultSet rs = statement.executeQuery();
                
                while(rs.next()){
                    idUser = rs.getString("col_nip");
                    jenisService = 1;
                }
                
            } catch(SQLException ex){
                System.out.println(ex.getMessage());
            }
        }
            
        //TIPE USER 4 : ADMIN
        else if(tipeUser.equals("3")){
            try{
                Connection koneksi = Koneksi.getKoneksi();;
                PreparedStatement statement = koneksi.prepareStatement("SELECT col_nip, col_username, col_password FROM tbl_admin WHERE col_username = ? and col_password = ?");
                statement.setString(1, username);
                statement.setString(2, enkripsiPassword);
                ResultSet rs = statement.executeQuery();
                
                while(rs.next()){
                    idUser = rs.getString("col_nip");
                    jenisService = 3;
                }
                
            } catch(SQLException ex){
                System.out.println(ex.getMessage());
            }
        }else{
            jenisService = 4;
        }
        
        return jenisService;
    }
    
    public String getIdUser(){
        return idUser;
    }
    
    public static String getEncryption(String password){
        MessageDigest messageDigest;
        String result = "";
        
        try{
            messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.update(password.getBytes("UTF8"));
            byte message[] = messageDigest.digest();
            
            for (int i = 0; i < message.length; i++){
                result += Integer.toHexString((0x000000ff &
                        message[i]) | 0xffffff00).substring(6);
            }
        }catch (NoSuchAlgorithmException ex){
            Logger.getLogger(User.class.getName()).log(Level.SEVERE,
                    null, ex);
        }catch(UnsupportedEncodingException ex){
            Logger.getLogger(User.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        
        return result;
    }
    
}
