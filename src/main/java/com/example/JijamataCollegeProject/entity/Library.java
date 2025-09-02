package com.example.JijamataCollegeProject.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "library")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Library {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "Full name is required")
    @Column(nullable = false)
    private String fullname;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String phone;

    @Column(nullable = false)
    private String college;

    @Column(name = "student_class", nullable = false)
    private String studentClass;

    @Column(nullable = false)
    private String pincode;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(nullable = false)
    private LocalDate birthdate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(nullable = false)
    private LocalDate presentdate;

    @Column(name = "image_path")
    private String imagePath; // Store uploaded image path

    // 👇 One-to-Many mapping
    @OneToMany(mappedBy = "libraryUser", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Book> books;
}
