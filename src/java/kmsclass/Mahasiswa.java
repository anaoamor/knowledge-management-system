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
public class Mahasiswa {
    String nim;
    String namaMahasiswa;
    String tglLahir;
    String jenisKelamin;
    String noHp;
    String alamat;
    String angkatan;
    String status;
    String agama;
    String email;
    String username;
    String password;
    String idProdiSI, idPerguruanTinggi;
    String nip;
    Connection konek;
    
    int i;//untuk value return registrasi
    String formatTglLahir;
    
    public Mahasiswa(String nim, String namaMahasiswa, String tglLahir, String jenisKelamin, String noHp, String alamat, 
            String angkatan, String status, String agama, String email,String username, String password, String idPerguruanTinggi){
        this.nim = nim;
        this.namaMahasiswa = namaMahasiswa;
        this.tglLahir = tglLahir;
        this.jenisKelamin = jenisKelamin;
        this.noHp = noHp;
        this.alamat = alamat;
        this.angkatan = angkatan;
        this.status = status;
        this.agama = agama;
        this.email = email;
        this.username = username;
        this.password = password;
        this.idPerguruanTinggi = idPerguruanTinggi;
    }
    
    public int registrasi(String nim, String namaMahasiswa, String tglLahir, String jenisKelamin, String noHp, String alamat, 
            String angkatan, String status, String agama, String email,String username, String password, String idPerguruanTinggi){
        
        idProdiSI = getIdProdiSI(idPerguruanTinggi);
        String tglLahirSQL = getFormatTglLahir(tglLahir);
        
        try{
            konek = Koneksi.getKoneksi();
            Statement statement = konek.createStatement();
            i += statement.executeUpdate("INSERT INTO tbl_mahasiswa(col_nim, col_nama_mhs, col_tgl_lahir, col_jenis_kelamin, col_no_hp, col_alamat,"
                    + "col_angkatan, col_status, col_agama, col_email, col_username, col_password, col_id_prodi_si, col_read_registrasi) VALUES (\'"+nim+"\', \'"+namaMahasiswa+
                       "\', \'"+tglLahirSQL+"\', \'"+jenisKelamin+"\', \'"+noHp+"\', \'"+alamat+"\', "+angkatan+", "+status+", \'"+agama+"\', \'"+email+"\', \'"+username+"\', md5(\'"+password+"\'), "
                    +idProdiSI+", 0)");
        } catch(SQLException ex){
            
        }
        
        return i;
    }
    
    public String getIdProdiSI(String idPerguruanTinggi){
        String idProdiSi = null;
        
        try{
            konek = Koneksi.getKoneksi();
            PreparedStatement statement = konek.prepareStatement("SELECT col_id_prodi_si FROM tbl_prodi_si INNER JOIN tbl_fakultas ON"
                    + "(tbl_fakultas.col_id_fakultas = tbl_prodi_si.col_id_fakultas) INNER JOIN tbl_pt ON(tbl_pt.col_id_pt = tbl_fakultas.col_id_pt)"
                    + "WHERE tbl_pt.col_id_pt = ?");
            statement.setString(1, idPerguruanTinggi);
            ResultSet rs = statement.executeQuery();
            
            while(rs.next()){
                idProdiSi = rs.getString("col_id_prodi_si");
            }
        } catch(SQLException exx){
            
        }
        
        return idProdiSi;
    }
    
    /**
     * Mengembalikan format tanggal untuk MySQL
     */
    public String getFormatTglLahir(String tglLahir){
        formatTglLahir = tglLahir.substring(6, 10)+String.valueOf(tglLahir.charAt(5))+tglLahir.substring(3,5)+
                String.valueOf(tglLahir.charAt(2))+tglLahir.substring(0,2);
        
        return formatTglLahir;
    }
}
