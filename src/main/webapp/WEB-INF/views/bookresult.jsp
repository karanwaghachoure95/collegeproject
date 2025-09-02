<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Book Issue Result</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { font-family: Arial; background: linear-gradient(135deg, #0f172a, #4f46e5); padding: 20px; }
.card { max-width: 900px; margin: auto; background: #fff; padding: 30px; border-radius: 20px; box-shadow: 0 12px 25px rgba(0,0,0,0.2);}
.user-image { float:right; width: 100px; height:100px; border-radius:10px; object-fit:cover; }
</style>
</head>
<body>
<div class="card">
    <c:choose>
        <c:when test="${not empty library.imagePath}">
            <img class="user-image" src="${pageContext.request.contextPath}${library.imagePath}" alt="User Image"/>
        </c:when>
        <c:otherwise>
            <img class="user-image" src="${pageContext.request.contextPath}/uploads/default.png" alt="Default Image"/>
        </c:otherwise>
    </c:choose>

    <h2>Book Issue Confirmation</h2>

    <h4>Library User Details</h4>
    <table class="table table-bordered">
        <tr><th>Full Name</th><td>${library.fullname}</td></tr>
        <tr><th>Email</th><td>${library.email}</td></tr>
        <tr><th>Phone</th><td>${library.phone}</td></tr>
        <tr><th>College</th><td>${library.college}</td></tr>
        <tr><th>Class</th><td>${library.studentClass}</td></tr>
    </table>

    <h4>Book Details</h4>
    <table class="table table-bordered">
        <tr><th>Book Name</th><td>${book.bookName}</td></tr>
        <tr><th>ISBN</th><td>${book.isbn}</td></tr>
        <tr><th>Issue Date</th><td>${book.issueDate}</td></tr>
        <tr><th>Return Date</th><td>${book.returnDate}</td></tr>
    </table>
</div>
</body>
</html>
