<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #f5f7fa, #c3cfe2);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .form-card {
            max-width: 700px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .form-card h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }
        .preview-img {
            width: 150px;
            height: 150px;
            border-radius: 10px;
            object-fit: cover;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div class="form-card">
    <h2>Library Form</h2>
    <form action="upload" method="post" enctype="multipart/form-data">
        <c:set var="user" value="${sessionScope.lastLibrary}" />

        Full Name: <input type="text" name="fullname" class="form-control mb-2"
                          value="${user != null ? user.fullname : ''}" required /><br/>

        Email: <input type="email" name="email" class="form-control mb-2"
                      value="${user != null ? user.email : ''}" required /><br/>

        Address: <input type="text" name="address" class="form-control mb-2"
                        value="${user != null ? user.address : ''}" required /><br/>

        Phone: <input type="text" name="phone" class="form-control mb-2"
                      value="${user != null ? user.phone : ''}" required /><br/>

        College: <input type="text" name="college" class="form-control mb-2"
                        value="${user != null ? user.college : ''}" required /><br/>

        Class: <input type="text" name="class" class="form-control mb-2"
                      value="${user != null ? user.studentClass : ''}" required /><br/>

        Pincode: <input type="text" name="pincode" class="form-control mb-2"
                        value="${user != null ? user.pincode : ''}" required /><br/>

        Birth Date: <input type="date" name="birthdate" class="form-control mb-2"
                           value="${user != null ? user.birthdate : ''}" required /><br/>

        Present Date: <input type="date" name="presentdate" class="form-control mb-2"
                             value="${user != null ? user.presentdate : ''}" required /><br/>

        <c:if test="${user != null && user.imagePath != null}">
            <img src="${user.imagePath}" class="preview-img" alt="Previous Image"/>
        </c:if>

        Image: <input type="file" name="image" class="form-control mb-3" /><br/>

        <input type="submit" value="Submit" class="btn btn-primary w-100" />
                    <a href="${pageContext.request.contextPath}/home.jsp" style="margin-left:auto">Back to home Form</a>
        
    </form>
    
</div>
</body>
</html>
