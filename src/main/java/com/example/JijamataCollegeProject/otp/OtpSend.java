package com.example.JijamataCollegeProject.otp;

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

public class OtpSend {
	  public static String emailesend(College user) {
	        final String to = user.getEmail();
	        final String from = "karanwaghachoure95@gmail.com";  // Apna Gmail daalo yaha
	        final String password = "jldarwszchovamzf";       // Yaha app password daalo (16 characters, bina spaces)

	        String otp = generateOTP(6);
	        String subject = "Your OTP Code";
	        String body = "Your OTP is: " + otp;

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

	        // Debug on for detailed logs
	        session.setDebug(true);//this line dikhayega console per process.

	        try {
	            Message message = new MimeMessage(session);
	            message.setFrom(new InternetAddress(from));
	            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
	            message.setSubject(subject);
	            message.setText(body);

	            Transport.send(message);
	            System.out.println("OTP sent successfully: " + otp);

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
