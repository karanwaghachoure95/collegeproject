package com.example.JijamataCollegeProject.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import javax.validation.constraints.FutureOrPresent;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "Book name is required")
    @Column(nullable = false)
    private String bookName;

    @NotBlank(message = "ISBN is required")
    @Column(nullable = false, unique = true)
    private String isbn;

    @FutureOrPresent(message = "Issue date must be today or in the future")
    @NotNull(message = "Issue date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(nullable = false)
    private LocalDate issueDate;

    @FutureOrPresent(message = "Return date must be today or in the future")
    @NotNull(message = "Return date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(nullable = false)
    private LocalDate returnDate;

    @Column(nullable = true)
    private String course;

    @Column(nullable = true)
    private String year;  
    
    @ManyToOne
    @JoinColumn(name = "library_id", nullable = false)
    private Library libraryUser;
}
