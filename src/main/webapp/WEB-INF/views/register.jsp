<!-- File: /WEB-INF/views/register.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Register</title>
  <style>
    :root { --bg:#0f172a; --card:#111827; --muted:#94a3b8; --text:#e5e7eb; --accent:#22c55e; }
    *{box-sizing:border-box} body{margin:0; font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,Inter,sans-serif; background:linear-gradient(120deg,#0b1020,#10172d);} 
    .wrap{min-height:100vh; display:grid; place-items:center; padding:24px}
    .card{width:100%; max-width:480px; background:rgba(17,24,39,.85); backdrop-filter: blur(8px); border:1px solid rgba(148,163,184,.15); border-radius:16px; box-shadow:0 10px 30px rgba(0,0,0,.35);}
    .card header{padding:28px 24px 8px; text-align:center}
    .title{margin:0; font-weight:700; font-size:24px; color:var(--text)}
    .subtitle{margin:6px 0 0; color:var(--muted); font-size:14px}
    form{padding:20px 24px 24px}
    label{display:block; font-size:13px; color:var(--muted); margin:14px 0 6px}
    input{width:100%; padding:12px 14px; border-radius:12px; border:1px solid rgba(148,163,184,.25); background:#0b1020; color:var(--text); outline:none}
    input:focus{border-color:var(--accent); box-shadow:0 0 0 3px rgba(34,197,94,.25)}
    .btn{width:100%; padding:12px 16px; border-radius:12px; background:var(--accent); color:white; border:none; font-weight:600; cursor:pointer; margin-top:14px}
    .btn:hover{filter:brightness(1.05)}
    .note{padding:10px 14px; border-radius:10px; font-size:13px; margin:10px 24px;}
    .error{background:rgba(239,68,68,.12); color:#fecaca; border:1px solid rgba(239,68,68,.3)}
    .ok{background:rgba(34,197,94,.12); color:#bbf7d0; border:1px solid rgba(34,197,94,.3)}
    .footer{padding:0 24px 20px; text-align:center; color:var(--muted); font-size:12px}
  </style>
</head>
<body>
  <div class="wrap">
    <div class="card">
      <header>
        <h1 class="title">Create an account</h1>
        <p class="subtitle">Join us and get started</p>
      </header>

      <!-- Messages -->
      <c:if test="${not empty msg}">
        <div class="note ok">${msg}</div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="note error">${error}</div>
      </c:if>

      <!-- Registration Form -->
      <form action="register" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <label for="fullname">Full Name</label>
        <input id="fullname" name="fullname" type="text" placeholder="Your full name" required />

        <label for="email">Email</label>
        <input id="email" name="email" type="email" placeholder="you@example.com" required />

        <label for="username">Username</label>
        <input id="username" name="username" type="text" placeholder="username123" required />

        <label for="password">Password</label>
        <input id="password" name="password" type="password" placeholder="••••••••" required />

        <label for="confirmPassword">Confirm Password</label>
        <input id="confirmPassword" name="confirmPassword" type="password" placeholder="••••••••" required />

        <button class="btn" type="submit">Register</button>
      </form>
     
      
      <div class="footer">
        <span>Already have an account?</span>
        <a href="${pageContext.request.contextPath}/login" style="color:#86efac; text-decoration:none;">Login here</a>
      </div>
    </div>
  </div>
</body>
</html>
