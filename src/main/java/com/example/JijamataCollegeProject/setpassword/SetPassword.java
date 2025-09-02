package com.example.JijamataCollegeProject.setpassword;

import java.util.Random;

import com.example.JijamataCollegeProject.entity.College;

public class SetPassword {

	public static String setPassword(College user) {
		Random rs = new Random();
		String pass = "User" + rs.nextInt(9999) + "&&**" + rs.nextInt(9999);
		return pass;
	}
}
