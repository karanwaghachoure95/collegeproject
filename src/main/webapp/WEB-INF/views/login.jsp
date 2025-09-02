<!-- File: /WEB-INF/views/login.jsp (Spring MVC + Spring Security friendly) -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Login</title>
<!-- Minimal, dependency-free styling -->
<style>
:root {
	--bg: #0f172a;
	--card: #111827;
	--muted: #94a3b8;
	--text: #e5e7eb;
	--accent: #4f46e5;
}

* {
	box-sizing: border-box
}

body {
	margin: 0;
	font-family: system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Inter,
		sans-serif;
	background: linear-gradient(120deg, #0b1020, #10172d);
}

.wrap {
	min-height: 100vh;
	display: grid;
	place-items: center;
	padding: 24px
}

.card {
	width: 100%;
	max-width: 420px;
	background: rgba(17, 24, 39, .85);
	backdrop-filter: blur(8px);
	border: 1px solid rgba(148, 163, 184, .15);
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .35);
}

.card header {
	padding: 28px 24px 8px;
	text-align: center
}

.title {
	margin: 0;
	font-weight: 700;
	font-size: 24px;
	color: var(--text)
}

.subtitle {
	margin: 6px 0 0;
	color: var(--muted);
	font-size: 14px
}

form {
	padding: 20px 24px 24px
}

label {
	display: block;
	font-size: 13px;
	color: var(--muted);
	margin: 14px 0 6px
}

input[type="email"], input[type="password"] {
	width: 100%;
	padding: 12px 14px;
	border-radius: 12px;
	border: 1px solid rgba(148, 163, 184, .25);
	background: #0b1020;
	color: var(--text);
	outline: none
}

input:focus {
	border-color: var(--accent);
	box-shadow: 0 0 0 3px rgba(79, 70, 229, .25)
}

.row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 12px;
	margin: 12px 0 6px
}

.row label.inline {
	display: flex;
	align-items: center;
	gap: 8px;
	margin: 0
}

.row a {
	color: #a5b4fc;
	font-size: 13px;
	text-decoration: none
}

.btn {
	width: 100%;
	padding: 12px 16px;
	border-radius: 12px;
	background: var(--accent);
	color: white;
	border: none;
	font-weight: 600;
	cursor: pointer;
	margin-top: 14px
}

.btn:hover {
	filter: brightness(1.05)
}

.note {
	padding: 10px 14px;
	border-radius: 10px;
	font-size: 13px;
	margin: 10px 24px;
}

.error {
	background: rgba(239, 68, 68, .12);
	color: #fecaca;
	border: 1px solid rgba(239, 68, 68, .3)
}

.ok {
	background: rgba(34, 197, 94, .12);
	color: #bbf7d0;
	border: 1px solid rgba(34, 197, 94, .3)
}

.footer {
	padding: 0 24px 20px;
	text-align: center;
	color: var(--muted);
	font-size: 12px
}
</style>
</head>
<body>
	<div class="wrap">
		<div class="card">
			<header>
				<h1 class="title">Welcome back</h1>
				<p class="subtitle">Sign in to continue</p>
			</header>

			<!-- Status messages (Spring Security common query params) -->
			<c:if test="${param.error != null}">
				<div class="note error">Invalid username or password.</div>
			</c:if>
			<c:if test="${param.logout != null}">
				<div class="note ok">You have been logged out successfully.</div>
			</c:if>

			<!-- LOGIN FORM -->
			<!-- If you use Spring Security default loginProcessingUrl, keep action="${pageContext.request.contextPath}/login" method="post" -->

			<form action="login" method="post">
				<!-- CSRF (Spring Security) -->
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <label for="email">Email</label> <input
					id="email" name="email" type="email" placeholder="you@example.com"
					required /> <label for="password">Password</label> <input
					id="password" name="password" type="password"
					placeholder="••••••••" required />

				<div class="row">
					<label class="inline"> <input type="checkbox"
						name="remember-me" /> Remember me
					</label> <a href="${pageContext.request.contextPath}/forgot-password">Forgot
						password?</a>
				</div>
				<h4 style="color: green">
					<%
					String msg1 = (String) request.getAttribute("msg1");
					if (msg1 != null) {
						out.println(msg1);
					}
					%>
				</h4>
				<button class="btn" type="submit">Sign in</button>
			</form>

			<div class="footer">
				<span>New here?</span> <a
					href="${pageContext.request.contextPath}/register"
					style="color: #c7d2fe; text-decoration: none;"> Create an
					account </a>

			</div>
		</div>
	</div>

	<!-- Hints:
    1) If you customized loginProcessingUrl in Security config, change the form action to match it, e.g. action="${pageContext.request.contextPath}/perform_login".
    2) In Spring Security, default username parameter is "username" and password is "password". If you changed them, update the input names accordingly.
    3) Place this file under /WEB-INF/views/login.jsp and return "login" from your controller to render it, or permitAll() for GET /login.
  -->
</body>
</html>

<!-- ========================= PLAIN HTML VERSION (no Spring) =========================
Save as login.html if you are not using JSP/CSRF. Change the <form action> to your server endpoint.

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <style>/* You can reuse styles from above or add Bootstrap/Tailwind */</style>
</head>
<body>
  <form action="/api/login" method="post">
    <label>Email <input type="email" name="email" required></label>
    <label>Password <input type="password" name="password" required></label>
    <button type="submit">Sign in</button>
  </form>
</body>
</html>
-->
