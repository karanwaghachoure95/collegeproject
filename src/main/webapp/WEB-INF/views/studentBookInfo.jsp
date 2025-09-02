<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Books</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">My Issued Books</h2>

    <c:if test="${not empty books}">
        <p>Total books issued: <strong>${books.size()}</strong></p>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Book Name</th>
                    <th>ISBN</th>
                    <th>Issue Date</th>
                    <th>Return Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.bookName}</td>
                        <td>${book.isbn}</td>
                        <td>${book.issueDate}</td>
                        <td>${book.returnDate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty books}">
        <p class="text-danger">No books issued yet.</p>
    </c:if>

    <a href="${pageContext.request.contextPath}/book" class="btn btn-primary mt-3">Back</a>
</div>
</body>
</html>
