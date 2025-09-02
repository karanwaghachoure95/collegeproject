<!-- File: /WEB-INF/views/forgot-password.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Forgot Password</title>
<style>
:root {
	font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial;
}

body {
	background: #f6f7fb;
	margin: 0;
	display: grid;
	place-items: center;
	min-height: 100vh;
}

.card {
	width: min(420px, 92vw);
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .08);
}

h1 {
	font-size: 1.35rem;
	margin: 0 0 6px;
}

p {
	color: #555;
	margin: 0 0 18px;
}

label {
	display: block;
	font-weight: 600;
	margin: 14px 0 6px;
}

input[type="email"] {
	width: 100%;
	padding: 12px 14px;
	border: 1px solid #d9dbe3;
	border-radius: 10px;
	font-size: 1rem;
}

.actions {
	display: flex;
	gap: 10px;
	align-items: center;
	margin-top: 18px;
}

button {
	padding: 12px 16px;
	border: 0;
	border-radius: 10px;
	cursor: pointer;
	font-weight: 700;
}

.btn-primary {
	background: #3b82f6;
	color: #fff;
}

.btn-ghost {
	background: transparent;
	color: #3b82f6;
}

.msg {
	margin-top: 12px;
	padding: 10px 12px;
	border-radius: 10px;
	font-size: .95rem;
}

.msg.success {
	background: #ecfdf5;
	color: #065f46;
	border: 1px solid #a7f3d0;
}

.msg.error {
	background: #fef2f2;
	color: #991b1b;
	border: 1px solid #fecaca;
}

.help {
	font-size: .9rem;
	color: #666;
	margin-top: 8px;
}

a {
	color: #3b82f6;
	text-decoration: none;
}
</style>
<script>
	function validateEmail(form) {
		const email = form.email.value.trim();
		const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		if (!re.test(email)) {
			alert("Please enter a valid email address.");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div class="card">
		<h1>Forgot your password?</h1>
		<p>Enter your registered email. We’ll send a password reset link.</p>

		<c:if test="${not empty success}">
			<div class="msg success">${success}</div>
		</c:if>
		<c:if test="${not empty error}">
			<div class="msg error">${error}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/forgot-password"
			method="post" onsubmit="return validateEmail(this)">
			<label for="email">Email address</label> <input id="email"
				name="email" type="email" required autocomplete="email"
				placeholder="you@example.com" />

			<!-- Spring Security CSRF -->
			<c:if test="${not empty _csrf}">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</c:if>

			<div class="actions">
				<button type="submit" class="btn-primary">Send reset link</button>
				<a class="btn-ghost" href="${pageContext.request.contextPath}/login">Back
					to login</a>
			</div>
			<div class="help">Didn’t receive the email? Check spam or try
				again after a minute.</div>
		</form>

		<h4 style="color: red">
			<%
			String msg2 = (String) request.getAttribute("msg2");

			if (msg2 != null) {
				out.println(msg2);
			}
			%>
		</h4>


	</div>
</body>
</html>
