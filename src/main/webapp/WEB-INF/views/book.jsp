<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Book Issue</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <script>
        // 🔥 Book List Mapping
        const booksData = {
            "BSc(CS)": {
                "FY": ["C Language", "Mathematics", "Electronics Basics"],
                "SY": ["DSA", "Software Engineering", "Computer Networks"],
                "TY": ["Java", "AI", "Machine Learning"]
            },
            "BCom": {
                "FY": ["Business Studies", "Accounting Basics"],
                "SY": ["Corporate Law", "Banking & Finance"],
                "TY": ["Auditing", "Taxation"]
            },
            "BCA": {
                "FY": ["Fundamentals of Computers", "Programming in C"],
                "SY": ["DBMS", "Web Development"],
                "TY": ["Cloud Computing", "Cyber Security"]
            }
        };

        function loadBooks() {
            const course = document.getElementById("courseSelect").value;
            const year = document.getElementById("yearSelect").value;
            const bookSelect = document.getElementById("bookName");

            // Clear old options
            bookSelect.innerHTML = "<option value=''>--Select Book--</option>";

            if (!course || !year) return;

            const selectedBooks = booksData[course]?.[year] || [];

            if (selectedBooks.length === 0) {
                const option = document.createElement("option");
                option.textContent = "No books found";
                option.value = "";
                bookSelect.appendChild(option);
            } else {
                selectedBooks.forEach(book => {
                    const option = document.createElement("option");
                    option.value = book;
                    option.textContent = book;
                    bookSelect.appendChild(option);
                });
            }
        }

        // 🔥 Issue/Return date logic
        window.addEventListener("DOMContentLoaded", () => {
            const issueDate = document.getElementById("issueDate");
            const returnDate = document.getElementById("returnDate");
            const today = new Date().toISOString().split("T")[0];

            issueDate.min = today;
            returnDate.disabled = true;

            issueDate.addEventListener("change", function () {
                if (issueDate.value) {
                    returnDate.disabled = false;
                    returnDate.min = issueDate.value; // Return date ≥ issue date
                } else {
                    returnDate.disabled = true;
                    returnDate.value = "";
                }
            });
        });
    </script>

    <style>
        body {
            background: linear-gradient(135deg, #0f172a, #4f46e5);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .card {
            width: 100%;
            max-width: 900px;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 12px 25px rgba(0,0,0,0.2);
            padding: 30px;
            position: relative;
        }
        .card h2 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: 700;
            color: #1e3c72;
        }
        .table th {
            background: #1e3c72;
            color: #fff;
        }
        .user-image {
            position: absolute;
            top: 20px;
            right: 20px;
            border-radius: 10px;
            object-fit: cover;
            width: 100px;
            height: 100px;
            border: 2px solid #ddd;
        }
        a.back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            text-decoration: none;
            color: #4f46e5;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="card">
    <!-- User Image -->
    <c:choose>
        <c:when test="${not empty library.imagePath}">
            <img class="user-image" src="${pageContext.request.contextPath}/${library.imagePath}" alt="User Image">
        </c:when>
        <c:otherwise>
            <img class="user-image" src="${pageContext.request.contextPath}/uploads/default.png" alt="Default Image">
        </c:otherwise>
    </c:choose>

    <h2>Book Issue / Return</h2>

    <!-- Book Issue Form -->
    <form action="${pageContext.request.contextPath}/book" method="post">
        <h4 class="mb-3">User Details</h4>
        <table class="table table-bordered">
            <tr><th>Full Name</th><td>${library.fullname}</td></tr>
            <tr><th>Email</th><td>${library.email}</td></tr>
            <tr><th>Birthdate</th><td>${library.birthdate}</td></tr>
            <tr><th>Address</th><td>${library.address}</td></tr>
            <tr><th>Class</th><td>${library.studentClass}</td></tr>
            <tr><th>College</th><td>${library.college}</td></tr>
            <tr><th>Pincode</th><td>${library.pincode}</td></tr>
            <tr><th>Mobile</th><td>${library.phone}</td></tr>
        </table>

        <h4 class="mb-3">Book Details</h4>
        <div class="row">
            <!-- Course Dropdown -->
            <div class="col-md-6 mb-3">
                <label class="form-label">Course</label>
                <select id="courseSelect" name="course" class="form-select" onchange="loadBooks()" required>
                    <option value="">--Select Course--</option>
                    <option value="BSc(CS)">BSc(CS)</option>
                    <option value="BCom">BCom</option>
                    <option value="BCA">BCA</option>
                </select>
            </div>

            <!-- Year Dropdown -->
            <div class="col-md-6 mb-3">
                <label class="form-label">Year</label>
                <select id="yearSelect" name="year" class="form-select" onchange="loadBooks()" required>
                    <option value="">--Select Year--</option>
                    <option value="FY">FY</option>
                    <option value="SY">SY</option>
                    <option value="TY">TY</option>
                </select>
            </div>
        </div>

        <!-- Book Name Dropdown -->
        <div class="mb-3">
            <label class="form-label">Book Name</label>
            <select name="bookName" id="bookName" class="form-select" required>
                <option value="">--Select Book--</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">ISBN</label>
            <input type="text" name="isbn" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Issue Date</label>
            <input type="date" name="issueDate" id="issueDate" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Return Date</label>
            <input type="date" name="returnDate" id="returnDate" class="form-control" required disabled>
        </div>

        <input type="hidden" name="libraryId" value="${library.id}">

        <button type="submit" class="btn btn-primary w-100 mt-3">Save Book Record</button>
    </form>

    <!-- Show My Books -->
    <form action="${pageContext.request.contextPath}/studentBooks" method="get">
        <input type="hidden" name="libraryId" value="${library.id}">
        <button type="submit" class="btn btn-success mt-3 w-100">Show My Books</button>
    </form>

    <!-- Back Link -->
    <a class="back-link" href="${pageContext.request.contextPath}/book">⬅ Back to Book Form</a>
</div>

</body>
</html>
