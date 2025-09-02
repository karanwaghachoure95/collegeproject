package com.example.JijamataCollegeProject.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.JijamataCollegeProject.dao.CollegeDao;
import com.example.JijamataCollegeProject.entity.Book;
import com.example.JijamataCollegeProject.entity.CollageOtpSend;
import com.example.JijamataCollegeProject.entity.College;
import com.example.JijamataCollegeProject.entity.ContactUs;
import com.example.JijamataCollegeProject.entity.Library;
import com.example.JijamataCollegeProject.entity.Otp;

@Service
public class CollegeService {

	@Autowired
	private CollegeDao dao;
	
	public boolean register(College user , String email , String username) {
		return dao.register(user,email,username);
	}

	public boolean contactUsPage(ContactUs user ,String email) {
		return dao.contactUsPage(user,email);
	}

	public boolean collagePage(College user, String email, String password) {
		return dao.collagePage(user,email,password);
		
	}

	public boolean forgotPassword(College user) {
		return dao.forgotPassword(user);
	}

	public boolean OtpCheck(Otp user) {
		return dao.OtpCheck(user);
	}

	public boolean saveOtp(Otp user1,String otp) {
		return dao.saveOtp(user1,otp);
	}

	public boolean setPassword(College user, String password) {

		return dao.setPassword(user,password);
	}

	public boolean handleForm(Library user) {
		return dao.handleForm(user);
		
	}

	public Library libraryLogin(String email, LocalDate birthdate) {
	    return dao.libraryLogin(email, birthdate);
	}

	public Library bookLogin(String email, String phone) {
	    return dao.bookLogin(email, phone);
	}

	public boolean book(Book user ) {
		return dao.book(user);
	}


	public Library getLibraryById(Long id) {
	    return dao.getLibraryById(id);
	}

	public List<Book> getBooksByLibrary(Long libraryId) {
		return  dao.getBooksByLibrary(libraryId);
	}

	
	 public boolean saveCollegeOtp(String otp, CollageOtpSend user) {
	        return dao.saveCollegeOtp(otp, user);
	    }

	    public boolean verifyOtp(CollageOtpSend user) {
	        return dao.verifyOtp(user);
	    }

		public List<Book> getBooksByCourseAndYear(String course, String year) {
			return  dao.getBooksByCourseAndYear(course,year);
		
		}
	
}
