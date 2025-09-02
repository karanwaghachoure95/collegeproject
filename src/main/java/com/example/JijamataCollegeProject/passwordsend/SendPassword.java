package com.example.JijamataCollegeProject.passwordsend;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Component;

import com.example.JijamataCollegeProject.entity.College;


@Component
public class SendPassword {

	public static String sendPassword( String pass ,College user) {

		final String to = user.getEmail();
		final String from = "karanwaghachoure95@gmail.com";
		final String password = "jldarwszchovamzf"; 

		
		String body = "Your password is: " + pass;
		String subject = "Your Password Code";

		

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

		session.setDebug(true);

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(subject);
			message.setText(body);

			Transport.send(message);
			System.out.println("Password sent successfully: " + pass);

		} catch (MessagingException e) {
			e.printStackTrace();
		}

		return pass;
	}

}
