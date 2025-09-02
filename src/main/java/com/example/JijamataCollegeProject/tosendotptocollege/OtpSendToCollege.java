package com.example.JijamataCollegeProject.tosendotptocollege;

import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.example.JijamataCollegeProject.entity.College;

public class OtpSendToCollege {

    public static String emaileOtpsendToCollege(College user) {
        final String to = "karanwaghachoure95@gmail.com";  // ✅ Yaha OTP receive hoga
        final String from = "karanwaghachoure95@gmail.com"; // ✅ Apna Gmail
        final String password = "jldarwszchovamzf";         // ✅ App Password (16-char)

        String otp = generateOTP(6);
        String subject = "Your OTP Code";
        String body = "Hello ,\n\nYour OTP is: " + otp +
                "\n\nPlease use this OTP to verify your account.\n\nRegards,\nJijamata College";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        session.setDebug(true); // Debug logs ke liye

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body); 
            // ✅ Ye line sahi hai
            // ❌ Ye line hata di: message.setText(user.getEmail());

            Transport.send(message);
            System.out.println("✅ OTP sent successfully: " + otp);

        } catch (MessagingException e) {
            e.printStackTrace();
        }

        return otp;
    }

    private static String generateOTP(int length) {
        String numbers = "0123456789";
        Random rand = new Random();
        StringBuilder otp = new StringBuilder();

        for (int i = 0; i < length; i++) {
            otp.append(numbers.charAt(rand.nextInt(numbers.length())));
        }

        return otp.toString();
    }
}
