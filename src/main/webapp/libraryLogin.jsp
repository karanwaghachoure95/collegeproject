<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Library Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #4f46e5, #0f172a);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.card {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 20px;
    padding: 30px 40px;
    max-width: 400px;
    width: 100%;
    box-shadow: 0 12px 25px rgba(0,0,0,0.25);
}

.card header {
    text-align: center;
    margin-bottom: 25px;
}

.title {
    font-size: 26px;
    font-weight: 700;
    color: #1e3d59;
}

.subtitle {
    font-size: 14px;
    color: #555;
}

label {
    font-weight: 500;
    margin-top: 10px;
}

input[type="email"], input[type="date"] {
    width: 100%;
    padding: 10px 12px;
    border-radius: 10px;
    border: 1px solid #ccc;
    margin-bottom: 15px;
    outline: none;
}

input:focus {
    border-color: #4f46e5;
    box-shadow: 0 0 5px rgba(79, 70, 229, 0.5);
}

.btn {
    width: 100%;
    background-color: #4f46e5;
    color: white;
    padding: 12px;
    border-radius: 50px;
    font-weight: 600;
    border: none;
    transition: 0.3s;
}

.btn:hover {
    background-color: #3730a3;
}

.note.error {
    background: rgba(239, 68, 68, .12);
    color: #b91c1c;
    padding: 10px;
    border-radius: 8px;
    margin-bottom: 15px;
    text-align: center;
}

.footer {
    text-align: center;
    margin-top: 15px;
}

.footer a {
    text-decoration: none;
    color: #4f46e5;
    font-weight: 500;
}

.footer a:hover {
    text-decoration: underline;
}
</style>
</head>
<body>
<div class="card">
    <header>
        <h1 class="title">Library Login</h1>
        <p class="subtitle">Enter your email and birthdate</p>
    </header>

    <c:if test="${not empty error}">
        <div class="note error">${error}</div>
    </c:if>

    <form action="/librarylogin" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <label for="email">Email</label>
        <input id="email" name="email" type="email" placeholder="you@example.com" required />

        <label for="birthdate">Birth Date</label>
        <input id="birthdate" name="birthdate" type="date" required />

        <button class="btn" type="submit">Sign in</button>
    </form>

    <div class="footer">
        <a href="${pageContext.request.contextPath}/library">Back to Library Form</a>
    </div>
</div>
</body>
</html>
