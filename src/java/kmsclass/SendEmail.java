package kmsclass;


import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ASUS
 */
public class SendEmail {
    
    public static void send(String recipient, String nama, String usernameKMS, String passwordKMS){
        final String username = "moriza74@gmail.com";
        final String password = "sandigmail";
        
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        
        Session session = Session.getInstance(prop, new javax.mail.Authenticator(){
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(username, password);
            }
        });
        
        try{
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("moriza74@gmail.com"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            message.setSubject("Lupa Password : KMS Mahasiswa SI");
            message.setText("Salam\n"
                    + "\n"
                    + "Dear "+nama+",\n"
                    + "Password account KMS Mahasiswa SI kamu sudah kami reset.\n"
                    + "Silahkan login ke KMS Mahasiswa SI (http://127.0.0.1:8080/KMSMahasiswaSI/LoginRegistrasi.jsp?menu=LOG+IN) \n"
                    + "dengan:\n"
                    + "Username = "+usernameKMS+"\n"
                    + "Password = "+passwordKMS+"\n"
                    + "\n"
                    + "Mohon ubah password kamu demi keamanan.\n"
                    + "Terimakasih atas perhatiannya.");
            
            Transport.send(message);
            System.out.println("DONE");
        }catch(MessagingException e){
            e.printStackTrace();
        }
    }
    
    /**
     * Send Kode Verifikasi
     */
    public static void sendKodeVerifikasi(String nim, String recipient, String kode){
        final String username = "moriza74@gmail.com";
        final String password = "sandigmail";
        
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        
        Session session = Session.getInstance(prop, new javax.mail.Authenticator(){
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(username, password);
            }
        });
        
        try{
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("moriza74@gmail.com"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            message.setSubject("Konfirmasi Akun KMS Mahasiswa SI");
            message.setText("Hai,\n"
                    + "\n"
                    + "Terimakasih telah bergabung dengan KMS Mahasiswa SI\n"
                    + "Harap mengkonfirmasi akun kamu dengan menginputkan kode "+kode+" pada "+
                    " tautan berikut: http://127.0.0.1:8080/KMSMahasiswaSI/VerifikasiAccount.jsp?nim="+nim+" \n"
                    + "Kamu dapat mengakses situs ini dengan mengunjungi (http://127.0.0.1:8080/KMSMahasiswaSI) \n\n"
                    + "Kami tunggu kehadiranmu di KMS Mahasiswa SI.\n\n"
                    + "Tim KMS Mahasiswa SI");
            
            Transport.send(message);
            System.out.println("DONE");
        }catch(MessagingException e){
            e.printStackTrace();
        }
    }
    
}
