package com.example.JijamataCollegeProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.JijamataCollegeProject.adminOtp.AdminOtp;
import com.example.JijamataCollegeProject.admissionotp.AdmissionOtp;
import com.example.JijamataCollegeProject.entity.Admission;
import com.example.JijamataCollegeProject.entity.Book;
import com.example.JijamataCollegeProject.entity.CollageOtpSend;
import com.example.JijamataCollegeProject.entity.College;
import com.example.JijamataCollegeProject.entity.ContactUs;
import com.example.JijamataCollegeProject.entity.FyAdmission;
import com.example.JijamataCollegeProject.entity.Library;
import com.example.JijamataCollegeProject.entity.LibraryAdminOtp;
import com.example.JijamataCollegeProject.entity.Otp;
import com.example.JijamataCollegeProject.entity.TyAdmission;
import com.example.JijamataCollegeProject.entity.ContactUser;
import com.example.JijamataCollegeProject.otp.OtpSend;
import com.example.JijamataCollegeProject.passwordsend.SendPassword;
import com.example.JijamataCollegeProject.registerotp.RegisterOtp;
import com.example.JijamataCollegeProject.service.CollegeService;
import com.example.JijamataCollegeProject.setpassword.SetPassword;
import com.example.JijamataCollegeProject.tosendotptocollege.OtpSendToCollege;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.function.Consumer;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class CollegeController {

	@Autowired
	private CollegeService service;

	@GetMapping("/")
	public String openPage() {
	    return "redirect:/login";
	}


	@PostMapping("/register")
	public String register(College user, @RequestParam String email, @RequestParam String username) {
		boolean isInsert = service.register(user, email, username);

		if (isInsert) {
			return "login";
		} else {
			return "register";
		}
	}

	@GetMapping("/registeremailset")
	public String setRegisterEmail() {

		return "registeremailset";
	}

	@PostMapping("/registeremailset")
	public String setRegisterotp(@RequestParam("email") String email, Model model) {
		String otp = RegisterOtp.emailesend(email);

		if (otp != null) {
			service.save(otp);
			return "RegisterOtpCheck";
		} else {
			model.addAttribute("error", "Invalid Email!");
			return "home";
		}

	}

	@PostMapping("/otpRegisterForm")
	public String registerInfo(@RequestParam String otp, Model model) {
		boolean isCorrect = service.checkRegisterOtp(otp);
		
		if(isCorrect) {
		model.addAttribute("users", service.findAllRegisterUser());
		return "registerInfo";
		}else {
			model.addAttribute("msg2", "Invalid otp!");
			return "RegisterOtpCheck";
		}
	}

	@PostMapping("/deleteUser/{id}")
	public String deleteUser(@PathVariable Integer id) {
		service.deleteUserById(id); // service me likha hoga delete ka logic
		return "redirect:/users"; // delete ke baad list page par redirect
	}

	@GetMapping("/login")
	public String goTologin() {
		return "login";
	}

	@GetMapping("/register")
	public String returnRegister() {
		return "register";
	}

	@PostMapping("/login")
	public String collagePage(College user, @RequestParam String email, @RequestParam String password) {
		boolean isTrue = service.collagePage(user, email, password);

		if (isTrue) {
			return "home";
		} else {
			return "login";
		}
	}

	@GetMapping("/contactus")
	public String contactUsPage() {
		return "contact";
	}

	@PostMapping("/contactus")
	public String contactUsPage(ContactUs user, Model model, @RequestParam String email) {
		boolean isInsert = service.contactUsPage(user, email);

		if (isInsert) {
			model.addAttribute("msg", "Information Successfully receive");
			return "contact";
		} else {
			model.addAttribute("msg1", "This email is already exist , please try another email..");
			return "contact";
		}

	}

	@GetMapping("/forgot-password")
	public String forgotPassword() {
		return "forgot";
	}

	@PostMapping("/forgot-password")
	public String forgotPassword(College user, Otp user1) {
		boolean isCorrect = service.forgotPassword(user);

		if (isCorrect) {
			String otp = OtpSend.emailesend(user);
			boolean isInsert = service.saveOtp(user1, otp);
			if (isInsert) {
				String password = SetPassword.setPassword(user);
				service.setPassword(user, password);
				SendPassword.sendPassword(password, user);
				return "otp";
			} else {
				return "forgot";
			}
		} else {
			return "forgot";
		}
	}

	@PostMapping("/otp")
	public String OtpCheck(Otp user, College user1) {
		boolean isCorrect = service.OtpCheck(user);

		if (isCorrect) {
			return "login";
		} else {
			return "otp";
		}

	}// Step 1: Show OTP page

	@GetMapping("/library")
	public String showOtpPage() {
		return "OtpSendCollege";
	}

	// Step 2: Send OTP
	@PostMapping("/sendOtp")
	public String sendOtp(@RequestParam("email") String email, Model model) {
		College user = new College();
		user.setEmail(email);

		String otp = OtpSendToCollege.emaileOtpsendToCollege(user);
		CollageOtpSend otpEntity = new CollageOtpSend();
		otpEntity.setOtp(otp);

		boolean isSaved = service.saveCollegeOtp(otp, otpEntity);

		if (isSaved) {
			model.addAttribute("message", "OTP sent successfully!");
		} else {
			model.addAttribute("error", "Failed to send OTP!");
		}

		model.addAttribute("email", email);
		return "OtpSendCollege"; // same page, but now OTP input enabled
	}

	// Step 3: Verify OTP
	@PostMapping("/verifyOtp")
	public String verifyOtp(@RequestParam("otp") String otp, Model model) {
		CollageOtpSend otpRequest = new CollageOtpSend();
		otpRequest.setOtp(otp);

		boolean isVerified = service.verifyOtp(otpRequest);

		if (isVerified) {
			return "library"; // success page
		} else {
			model.addAttribute("error", "Invalid OTP!");
			return "OtpSendCollege"; // stay on OTP page
		}
	}

	@PostMapping("/upload")
	public String handleForm(@RequestParam("fullname") String fullname, @RequestParam("email") String email,
			@RequestParam("address") String address, @RequestParam("phone") String phone,
			@RequestParam("college") String college, @RequestParam("class") String studentClass, // reserved word avoid
			@RequestParam("pincode") String pincode,
			@RequestParam("birthdate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate birthdate,
			@RequestParam("presentdate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate presentdate,
			@RequestParam("image") MultipartFile image, HttpServletRequest request, Model model) throws IOException {

		// Upload folder
		String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads";
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists())
			uploadDir.mkdir();

		// Save image
		String fileName = System.currentTimeMillis() + "_" + image.getOriginalFilename();
		File file = new File(uploadDir, fileName);
		image.transferTo(file);

		// Create Library object and set all fields
		Library user = new Library();
		user.setFullname(fullname);
		user.setEmail(email);
		user.setAddress(address);
		user.setPhone(phone);
		user.setCollege(college);
		user.setStudentClass(studentClass);
		user.setPincode(pincode);
		user.setBirthdate(birthdate);
		user.setPresentdate(presentdate);
		user.setImagePath("uploads/" + fileName);

		// Save to DB
		boolean isInsert = service.handleForm(user);

		if (isInsert) {
			// Pass attributes to JSP
			model.addAttribute("fullname", fullname);
			model.addAttribute("email", email);
			model.addAttribute("address", address);
			model.addAttribute("phone", phone);
			model.addAttribute("college", college);
			model.addAttribute("studentClass", studentClass);
			model.addAttribute("pincode", pincode);
			model.addAttribute("birthdate", birthdate);
			model.addAttribute("presentdate", presentdate);
			model.addAttribute("imagePath", "uploads/" + fileName);

			return "result"; // /WEB-INF/views/result.jsp
		} else {
			model.addAttribute("msg", "Failed to save data. Please try again.");
			return "library";
		}
	}

	@GetMapping("/librarylogin")
	public String libraryLogin() {
		return "libraryLogin";
	}

	@PostMapping("/librarylogin")
	public String libraryLogin(@RequestParam String email,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate birthdate, Model model) {

		Library user = service.libraryLogin(email, birthdate);

		if (user != null) {
			model.addAttribute("fullname", user.getFullname());
			model.addAttribute("email", user.getEmail());
			model.addAttribute("address", user.getAddress());
			model.addAttribute("phone", user.getPhone());
			model.addAttribute("college", user.getCollege());
			model.addAttribute("studentClass", user.getStudentClass());
			model.addAttribute("pincode", user.getPincode());
			model.addAttribute("birthdate", user.getBirthdate());
			model.addAttribute("presentdate", user.getPresentdate());
			model.addAttribute("imagePath", user.getImagePath());

			return "result"; // result.jsp
		} else {
			model.addAttribute("error", "Email or Birthdate is incorrect!");
			return "libraryLogin";
		}
	}

	@GetMapping("/book")
	public String book() {
		return "booklogin";
	}

	@PostMapping("/booklogin")
	public String bookLogin(@RequestParam String email, @RequestParam String phone, Model model) {

		Library user = service.bookLogin(email, phone);

		if (user != null) {
			// Add full Library object to model
			model.addAttribute("library", user);
			// Book JSP page open karo
			return "book"; // book.jsp
		} else {
			model.addAttribute("error", "Email or Phone is incorrect!");
			return "booklogin"; // booklogin.jsp
		}
	}

	@PostMapping("/book")
	public String book(@RequestParam Long libraryId, @RequestParam String bookName, @RequestParam String isbn,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate issueDate,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate returnDate, Model model) {

		Library library = service.getLibraryById(libraryId); // Service method create karna
		if (library == null) {
			return "booklogin"; // library user nahi mila
		}

		Book book = new Book();
		book.setBookName(bookName);
		book.setIsbn(isbn);
		book.setIssueDate(issueDate);
		book.setReturnDate(returnDate);
		book.setLibraryUser(library); // ✅ Library set karna zaruri hai

		boolean isInsert = service.book(book);

		if (isInsert) {
			model.addAttribute("library", library);
			model.addAttribute("book", book);
			return "bookresult";
		} else {
			return "home";
		}
	}

	@GetMapping("/studentBooks")
	public String studentBooks(@RequestParam Long libraryId, Model model) {
		List<Book> books = service.getBooksByLibrary(libraryId);
		model.addAttribute("books", books);
		return "studentBookInfo"; // studentBooksInfo.jsp
	}

	@GetMapping("/booksByCourseYear")
	@ResponseBody
	public List<Book> getBooksByCourseAndYear(@RequestParam String course, @RequestParam String year) {
		return service.getBooksByCourseAndYear(course, year);
	}

	// ------------------ SHOW ADMISSION FORM ------------------
	@GetMapping("/fyadmission")
	public String FyshowAdmissionForm(Model model) {
		model.addAttribute("fyadmission", new FyAdmission());
		return "fyadmission"; // admission.jsp
	}

	// ------------------ SUBMIT ADMISSION FORM ------------------
	@PostMapping("/fyadmission")
	public String submitFyAdmissionForm(
	        @ModelAttribute("fyadmission") FyAdmission admission,
	        Model model,
	        HttpServletRequest request) {
	    try {
	        // Dynamic path: webapp/uploads ke andar save hoga
	        String uploadDir = request.getServletContext().getRealPath("/uploads/");
	        File dir = new File(uploadDir);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        // Save all files
	        saveFile(admission.getPassportPhoto(), uploadDir, admission::setPassportPhotoFileName);
	        saveFile(admission.getAadhaarDoc(), uploadDir, admission::setAadhaarDocFileName);
	        saveFile(admission.getBirthCert(), uploadDir, admission::setBirthCertFileName);
	        saveFile(admission.getTransferCert(), uploadDir, admission::setTransferCertFileName);
	        saveFile(admission.getLeavingCert(), uploadDir, admission::setLeavingCertFileName);
	        saveFile(admission.getMigrationCert(), uploadDir, admission::setMigrationCertFileName);
	        saveFile(admission.getCasteCert(), uploadDir, admission::setCasteCertFileName);
	        saveFile(admission.getIncomeCert(), uploadDir, admission::setIncomeCertFileName);
	        saveFile(admission.getDomicileCert(), uploadDir, admission::setDomicileCertFileName);
	        saveFile(admission.getCharacterCert(), uploadDir, admission::setCharacterCertFileName);
	        saveFile(admission.getGapCert(), uploadDir, admission::setGapCertFileName);
	        saveFile(admission.getSportsCert(), uploadDir, admission::setSportsCertFileName);
	        saveFile(admission.getMedicalCert(), uploadDir, admission::setMedicalCertFileName);
	        saveFile(admission.getEntranceScoreCard(), uploadDir, admission::setEntranceScoreCardFileName);
	        saveFile(admission.getCetScoreCard(), uploadDir, admission::setCetScoreCardFileName);

	        // Save admission in DB
	        service.save(admission);

	        model.addAttribute("admission", admission);
	        model.addAttribute("message", "Admission Submitted Successfully!");
	        return "fyadmissionSuccess";

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("message", "Error: " + e.getMessage());
	        return "fyadmission"; // return back to form page
	    }
	}


	// ------------------ SHOW ADMISSION FORM ------------------
	@GetMapping("/admission")
	public String showAdmissionForm(Model model) {
		model.addAttribute("admission", new Admission());
		return "admission"; // admission.jsp
	}

	// ------------------ SUBMIT ADMISSION FORM ------------------
	@PostMapping("/admission")
	public String submitAdmissionForm(
	        @ModelAttribute("admission") Admission admission,
	        Model model,
	        HttpServletRequest request) {
	    try {
	        // Dynamic uploads path (webapp/uploads)
	        String uploadDir = request.getServletContext().getRealPath("/uploads/");
	        File dir = new File(uploadDir);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        // Save all files
	        saveFile(admission.getPassportPhoto(), uploadDir, admission::setPassportPhotoFileName);
	        saveFile(admission.getAadhaarDoc(), uploadDir, admission::setAadhaarDocFileName);
	        saveFile(admission.getBirthCert(), uploadDir, admission::setBirthCertFileName);
	        saveFile(admission.getTransferCert(), uploadDir, admission::setTransferCertFileName);
	        saveFile(admission.getLeavingCert(), uploadDir, admission::setLeavingCertFileName);
	        saveFile(admission.getMigrationCert(), uploadDir, admission::setMigrationCertFileName);
	        saveFile(admission.getCasteCert(), uploadDir, admission::setCasteCertFileName);
	        saveFile(admission.getIncomeCert(), uploadDir, admission::setIncomeCertFileName);
	        saveFile(admission.getDomicileCert(), uploadDir, admission::setDomicileCertFileName);
	        saveFile(admission.getCharacterCert(), uploadDir, admission::setCharacterCertFileName);
	        saveFile(admission.getGapCert(), uploadDir, admission::setGapCertFileName);
	        saveFile(admission.getSportsCert(), uploadDir, admission::setSportsCertFileName);
	        saveFile(admission.getMedicalCert(), uploadDir, admission::setMedicalCertFileName);
	        saveFile(admission.getEntranceScoreCard(), uploadDir, admission::setEntranceScoreCardFileName);
	        saveFile(admission.getFyMarkSheet(), uploadDir, admission::setFyMarkSheetFileName);

	        // Save admission in DB
	        service.save(admission);

	        model.addAttribute("admission", admission);
	        model.addAttribute("message", "Admission Submitted Successfully!");
	        return "admissionSuccess";

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("message", "Error: " + e.getMessage());
	        return "admission"; // back to form
	    }
	}

	// -------------------- TY Admission Form --------------------
	@GetMapping("/TYadmission")
	public String TyshowAdmissionForm(Model model) {
		model.addAttribute("TYadmission", new TyAdmission());
		return "TyAdmission";
	}

	@PostMapping("/TYadmission")
	public String TysubmitAdmissionForm(
	        @ModelAttribute("TYadmission") TyAdmission admission,
	        Model model,
	        HttpServletRequest request) {
	    try {
	        // Dynamic path (server ke context ke andar uploads folder banega)
	        String uploadDir = request.getServletContext().getRealPath("/uploads/");
	        File dir = new File(uploadDir);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        // Save uploaded files
	        saveFile(admission.getPassportPhoto(), uploadDir, admission::setPassportPhotoFileName);
	        saveFile(admission.getAadhaarDoc(), uploadDir, admission::setAadhaarDocFileName);
	        saveFile(admission.getBirthCert(), uploadDir, admission::setBirthCertFileName);
	        saveFile(admission.getTransferCert(), uploadDir, admission::setTransferCertFileName);
	        saveFile(admission.getLeavingCert(), uploadDir, admission::setLeavingCertFileName);
	        saveFile(admission.getMigrationCert(), uploadDir, admission::setMigrationCertFileName);
	        saveFile(admission.getCasteCert(), uploadDir, admission::setCasteCertFileName);
	        saveFile(admission.getIncomeCert(), uploadDir, admission::setIncomeCertFileName);
	        saveFile(admission.getDomicileCert(), uploadDir, admission::setDomicileCertFileName);
	        saveFile(admission.getCharacterCert(), uploadDir, admission::setCharacterCertFileName);
	        saveFile(admission.getGapCert(), uploadDir, admission::setGapCertFileName);
	        saveFile(admission.getSportsCert(), uploadDir, admission::setSportsCertFileName);
	        saveFile(admission.getMedicalCert(), uploadDir, admission::setMedicalCertFileName);
	        saveFile(admission.getEntranceScoreCard(), uploadDir, admission::setEntranceScoreCardFileName);
	        saveFile(admission.getFyMarkSheet(), uploadDir, admission::setFyMarkSheetFileName);
	        saveFile(admission.getSyMarkSheet(), uploadDir, admission::setSyMarkSheetFileName);

	        // Save admission in DB
	        service.save(admission);

	        model.addAttribute("admission", admission);
	        model.addAttribute("successMessage", "TY Admission submitted successfully!");
	        return "TyadmissionSuccess";

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("errorMessage", "Error: " + e.getMessage());
	        return "Tyadmission"; // return back to form
	    }
	}


	// ------------------ HELPER METHOD TO SAVE FILE ------------------
	private void saveFile(MultipartFile file, String uploadDir, Consumer<String> setFileName) throws IOException {
		if (file != null && !file.isEmpty()) {
			String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			File dest = new File(uploadDir + fileName);
			file.transferTo(dest);
			setFileName.accept(fileName);
		}
	}

	@GetMapping("/contacts")
	public String viewContacts(Model model) {
		List<ContactUs> contacts = service.findAll();
		model.addAttribute("contacts", contacts);
		return "contacts"; // JSP file name
	}

	@PostMapping("/deleteContact")
	public String deleteContact(@RequestParam Long id) {
		service.deleteContact(id);
		return "redirect:/contacts"; // delete ke baad fir se contacts list reload hogi
	}

	@GetMapping("/libraryUsers")
	public String viewLibrary(Model model) {
		List<Library> members = service.findAllLibrary(); // service se list le rahe
		model.addAttribute("libraryUsers", members); // JSP me ye name use karenge
		return "libraryUsers"; // JSP file name
	}

	@PostMapping("/deleteLibraryUser")
	public String deleteLibrary(@RequestParam Long id) {
		service.deletelibrary(id); // service method delete
		return "redirect:/libraryUsers"; // reload same list page
	}

	@GetMapping("/adminOtpset")
	public String adminOtpset() {
		return "libraryadminemailset";
	}

	@PostMapping("/adminOtpset")
	public String adminOtpset(@RequestParam("email") String email, Model model, LibraryAdminOtp user) {

		String otp = AdminOtp.emailesend(email);
		if (otp != null) {
			service.saveAdminOtp(otp, user);
			return "adminCheckOtp";
		} else {
			model.addAttribute("error", "Invalid Email!");
			return "home";
		}
	}

	@PostMapping("/otpAdminForm")
	public String adminCheckOtp(@RequestParam String otp, Model model) {
		boolean isCorrect = service.adminCheckOtp(otp);

		if (isCorrect) {
			List<Library> users = service.findAllLibrary();
			model.addAttribute("libraryUsers", users);
			model.addAttribute("msg1", "Correct Otp...");

			return "libraryUsers";
		} else {
			model.addAttribute("msg2", "Invalid otp!");
			return "adminCheckOtp";
		}
	}

	@GetMapping("/admincontactemailset")
	public String admincontactemailset() {
		return "contactadminemailset";
	}

	@PostMapping("/admincontactemailset")
	public String admincontactOtpset(@RequestParam("email") String email, Model model, ContactUser user) {

		String otp = AdminOtp.emailesend(email);
		if (otp != null) {
			service.saveContactAdminOtp(otp, user);
			return "adminContactCheckOtp";
		} else {
			model.addAttribute("error", "Invalid Email!");
			return "home";
		}
	}

	@PostMapping("/otpContactAdminForm")
	public String admincontactotpVerify(@RequestParam String otp, Model model) {
		boolean isCorrect = service.admincontactotpVerify(otp);

		if (isCorrect) {
			List<ContactUs> users = service.findAllContact();
			model.addAttribute("contacts", users);
			return "contacts";
		} else {
			return "adminContactCheckOtp";
		}
	}

	@GetMapping("/adminAdmissionEmail")
	public String admissionEmailset() {
		return "admissionEmailset";
	}

	@PostMapping("/adminAdmissionEmail")
	public String admissionEmailset(@RequestParam("email") String email, Model model) {
		String otp = AdmissionOtp.emailesend(email);

		if (otp != null) {
			service.saveAdmissionOtp(otp);
			return "admissionOtp";
		} else {
			model.addAttribute("error", "Invalid Email!");
			return "home";

		}

	}

	@PostMapping("/admissionOtp")
	public String adminAdmissionotpVerify(@RequestParam String otp, Model model) {
		boolean isCorrect = service.adminAdmissionotpVerify(otp);

		if (isCorrect) {
			model.addAttribute("fyStudents", service.fyfindAll());
			model.addAttribute("syStudents", service.syfindAll());
			model.addAttribute("tyStudents", service.tyfindAll());
			return "studentTabs";
		} else {
			return "admissionOtp";
		}
	}

	@GetMapping("/students")
	public String getAllStudents(Model model,
			@RequestParam(value = "activeTab", required = false, defaultValue = "fy") String activeTab) {
		model.addAttribute("fyStudents", service.fyfindAll());
		model.addAttribute("syStudents", service.syfindAll());
		model.addAttribute("tyStudents", service.tyfindAll());
		model.addAttribute("activeTab", activeTab); // active tab bhejna
		return "studentTabs";
	}

	@GetMapping("/deleteFy/{id}")
	public String deleteFy(@PathVariable Long id, Model model) {
		service.deleteFyById(id);
		model.addAttribute("fyStudents", service.fyfindAll());
		model.addAttribute("syStudents", service.syfindAll());
		model.addAttribute("tyStudents", service.tyfindAll());
		return "redirect:/students?activeTab=fy"; // FY tab open rahe
	}

	@GetMapping("/deleteSy/{id}")
	public String deleteSy(@PathVariable Long id, Model model) {
		service.deleteSyById(id);
		model.addAttribute("fyStudents", service.fyfindAll());
		model.addAttribute("syStudents", service.syfindAll());
		model.addAttribute("tyStudents", service.tyfindAll());
		return "redirect:/students?activeTab=sy"; // SY tab open rahe
	}

	@GetMapping("/deleteTy/{id}")
	public String deleteTy(@PathVariable Long id, Model model) {
		service.deleteTyById(id);
		model.addAttribute("fyStudents", service.fyfindAll());
		model.addAttribute("syStudents", service.syfindAll());
		model.addAttribute("tyStudents", service.tyfindAll());
		return "redirect:/students?activeTab=ty"; // TY tab open rahe
	}

}
