package com.example.JijamataCollegeProject.dao;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.JijamataCollegeProject.entity.Book;
import com.example.JijamataCollegeProject.entity.CollageOtpSend;
import com.example.JijamataCollegeProject.entity.College;
import com.example.JijamataCollegeProject.entity.ContactUs;
import com.example.JijamataCollegeProject.entity.Library;
import com.example.JijamataCollegeProject.entity.Otp;

@Repository
public class CollegeDao {

	@Autowired
	SessionFactory factory;

	public boolean register(College user, String email, String username) {
		try (Session session = factory.openSession();) {
			Transaction tx = session.beginTransaction();
			List<Object[]> inf = session.createQuery("select email , username from College", Object[].class)
					.getResultList();
			for (Object row[] : inf) {
				String emails = (String) row[0];
				String usernames = (String) row[1];

				if (emails.contains(email) || usernames.contains(username)) {
					return false;
				}
			}
			session.save(user);
			tx.commit();
			return true;

		} catch (IllegalAccessError e) {
			System.out.println("Session can't open");
			return false;
		}

	}

	public boolean contactUsPage(ContactUs user, String email) {
		try (Session session = factory.openSession();) {
			Transaction tx = session.beginTransaction();
			List<String> emails = session.createQuery("select email from ContactUs", String.class).getResultList();

			if (emails.contains(email)) {
				return false;

			}
			session.save(user);
			tx.commit();
			return true;

		} catch (IllegalAccessError e) {
			System.out.println("Please check insert , something put wrong");
			return false;
		}
	}

	public boolean collagePage(College user, String email, String password) {
		try (Session session = factory.openSession();) {
			List<Object[]> inf = session
					.createQuery("select email , password ,confirmPassword from College", Object[].class)
					.getResultList();
			for (Object row[] : inf) {
				String emails = (String) row[0];
				String passwords = (String) row[1];
				String confirmPassword = (String) row[2];

				if (email.contains(emails) && password.equals(passwords) || password.equals(confirmPassword)) {
					return true;
				}
			}
			return false;

		} catch (IllegalAccessError e) {
			System.out.println("Session can't open");
			return false;
		}
	}

	public boolean forgotPassword(College user) {
		try (Session session = factory.openSession()) {
			List<String> email = session.createQuery("select email from  College", String.class).getResultList();
			if (email.contains(user.getEmail())) {
				return true;
			} else {
				return false;
			}
		} catch (IllegalAccessError e) {
			System.out.println("Session can't open");
			return false;
		}
	}

	public boolean saveOtp(Otp user1, String otp) {
		try (Session session = factory.openSession()) {
			Transaction tx = session.beginTransaction();
			user1.setOtp(otp);
			session.save(user1);
			tx.commit();
			return true;
		} catch (IllegalAccessError e) {
			System.out.println("Session can't open");
			return false;
		}

	}

	public boolean OtpCheck(Otp user) {
		try (Session session = factory.openSession()) {
			List<String> otp = session.createQuery("select otp from  Otp", String.class).getResultList();
			if (otp.contains(user.getOtp())) {
				return true;
			} else {
				return false;
			}
		} catch (IllegalAccessError e) {
			System.out.println("Session can't open");
			return false;
		}

	}

	public boolean setPassword(College user, String password) {
		try (Session session = factory.openSession()) {
			session.beginTransaction();

			int updated = session.createQuery("UPDATE College SET password = :pass WHERE email = :email")
					.setParameter("pass", password).setParameter("email", user.getEmail()).executeUpdate();

			session.getTransaction().commit();
			return updated > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean handleForm(Library user) {
		Session session = factory.openSession();
		Transaction tx = null;
		try {
		    tx = session.beginTransaction();  // ✅ Transaction start pehle
		    session.save(user);               // Save object
		    tx.commit();                      // Commit transaction
		    return true;
		} catch (Exception e) {
		    if (tx != null) tx.rollback();    // Rollback if error
		    e.printStackTrace();
		    return false;                     // ❌ Error me true nahi dena
		} finally {
		    session.close();                  // Session close
		}

	}

	public Library libraryLogin(String email, LocalDate birthdate) {
	    try (Session session = factory.openSession()) {
	        // Query to get Library record by email and birthdate
	        List<Library> list = session.createQuery(
	            "FROM Library WHERE email = :email AND birthdate = :birthdate", Library.class)
	            .setParameter("email", email)
	            .setParameter("birthdate", birthdate)
	            .getResultList();

	        if (!list.isEmpty()) {
	            return list.get(0); // first matching user
	        } else {
	            return null;        // no match found
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}

	public Library bookLogin(String email, String phone) {
		   try (Session session = factory.openSession()) {
		        // Query to get Library record by email and birthdate
		        List<Library> list = session.createQuery(
		            "FROM Library WHERE email = :email AND phone = :phone", Library.class)
		            .setParameter("email", email)
		            .setParameter("phone", phone)
		            .getResultList();

		        if (!list.isEmpty()) {
		            return list.get(0); // first matching user
		        } else {
		            return null;        // no match found
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		        return null;
		    }
		   }

	public boolean book(Book book) {
	    Transaction tx = null;
	    try (Session session = factory.openSession()) {
	        tx = session.beginTransaction();

	        // ✅ libraryUser null check
	        if (book.getLibraryUser() == null) {
	            throw new RuntimeException("Library user must be set before saving the book!");
	        }

	        session.save(book);
	        tx.commit();
	        return true;
	    } catch (Exception e) {
	        if (tx != null) tx.rollback();
	        e.printStackTrace();
	        return false;
	    }
	}

	
	public Library getLibraryById(Long id) {
	    Session session = factory.openSession();
	    Library library = session.get(Library.class, id);
	    session.close();
	    return library;
	}


	public List<Book> getBooksByLibrary(Long libraryId) {
	    Session session = factory.openSession();
	    CriteriaBuilder cb = session.getCriteriaBuilder();
	    javax.persistence.criteria.CriteriaQuery<Book> cq = cb.createQuery(Book.class);
	    Root<Book> root = cq.from(Book.class);
	    cq.select(root).where(cb.equal(root.get("libraryUser").get("id"), libraryId));
	    List<Book> books = session.createQuery(cq).getResultList();
	    session.close();
	    return books;
	}

	

	public boolean saveCollegeOtp(String otp, CollageOtpSend user) {
        try (Session session = factory.openSession()) {
            Transaction tx = session.beginTransaction();
            user.setOtp(otp);
            session.save(user);
            tx.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean verifyOtp(CollageOtpSend user) {
        try (Session session = factory.openSession()) {
            List<String> otpList = session.createQuery(
                "select otp from CollageOtpSend", String.class).getResultList();
            return otpList.contains(user.getOtp());
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Book> getBooksByCourseAndYear(String course, String year) {
        Session session = factory.openSession();
        List<Book> books = null;
        try {
            books = session.createQuery(
                    "FROM Book WHERE course = :course AND year = :year", Book.class)
                    .setParameter("course", course)
                    .setParameter("year", year)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return books;
    }


	

}
