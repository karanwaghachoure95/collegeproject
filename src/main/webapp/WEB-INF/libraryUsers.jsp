<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Records</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Library Users Records</h2>
    <a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-secondary btn-sm float-end">⬅ Back to Home</a>
    
    <!-- 🔍 Search bar -->
    <div class="mt-3 mb-3">
        <input type="text" id="searchInput" class="form-control" placeholder="🔍 Search records by Name, Email, College, Class...">
    </div>

    <table class="table table-bordered table-striped mt-3" id="recordsTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Address</th>
                <th>Phone</th>
                <th>College</th>
                <th>Class</th>
                <th>Pincode</th>
                <th>Birthdate</th>
                <th>Present Date</th>
                <th>Image</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${libraryUsers}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.fullname}</td>
                    <td>${user.email}</td>
                    <td>${user.address}</td>
                    <td>${user.phone}</td>
                    <td>${user.college}</td>
                    <td>${user.studentClass}</td>
                    <td>${user.pincode}</td>
                    <td>${user.birthdate}</td>
                    <td>${user.presentdate}</td>
                   
                    <td>
                        <c:if test="${not empty user.imagePath}">
                            <img src="${user.imagePath}" alt="Image" width="50" height="50"/>
                        </c:if>
                    </td>
                    <td>
                        <form action="deleteLibraryUser" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="${user.id}">
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
    // 🔎 Table Search Filter
    document.getElementById("searchInput").addEventListener("keyup", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#recordsTable tbody tr");

        rows.forEach(row => {
            let text = row.innerText.toLowerCase();
            row.style.display = text.includes(filter) ? "" : "none";
        });
    });
</script>

</body>
</html>
