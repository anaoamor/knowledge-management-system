package kmsclass;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ASUS
 */
public class Koneksi {
    private static Connection koneksi;

    public static Connection getKoneksi() {
        if (koneksi == null) {
            try {
		String url = "jdbc:mysql://localhost:3306/db_kms_mhs_si";
		String username = "root";
		String password = "pelangi123";

		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		koneksi = DriverManager.getConnection(url+"?user="+username+"&password="+password);
            }catch (SQLException ex){
                System.out.print(ex.getMessage());
            }
	}
	return koneksi;
    }
}
