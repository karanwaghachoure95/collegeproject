<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Verify OTP</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100vh;
	margin: 0;
	background: #f5f7fb;
}

.card {
	background: white;
	padding: 24px;
	border-radius: 8px;
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
	width: 320px;
}

h2 {
	margin: 0 0 12px 0;
	font-size: 20px;
	text-align: center;
}

label {
	font-size: 14px;
	display: block;
	margin-bottom: 6px;
}

input[type="text"] {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #dcdfe6;
	border-radius: 6px;
	box-sizing: border-box;
}

.btn {
	margin-top: 12px;
	width: 100%;
	padding: 10px;
	border: none;
	background: #007bff;
	color: white;
	border-radius: 6px;
	cursor: pointer;
	font-size: 16px;
}

.btn:disabled {
	background: #93c0ff;
	cursor: not-allowed;
}

.helper {
	margin-top: 12px;
	text-align: center;
	font-size: 13px;
	color: #666;
}

.msg {
	margin-top: 10px;
	text-align: center;
	font-weight: 600;
}

.error {
	color: #b00020;
}

.success {
	color: #0b7a3a;
}

.resend {
	color: #007bff;
	cursor: pointer;
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="card">
		<h2>Enter OTP</h2>

		<form id="otpForm" action="/otp" method="post" novalidate>
			<!-- If using pure HTML form submit, ensure action and method match your controller -->
			<label for="otp">OTP (6 digits)</label> <input id="otp" name="otp"
				type="text" inputmode="numeric" maxlength="6" pattern="\d{6}"
				autocomplete="one-time-code" required />
			<button id="submitBtn" class="btn" type="submit">Verify OTP</button>
		</form>

		<h4 style="color: green">
			<%
			String msg1 = (String) request.getAttribute("msg1");
			if (msg1 != null) {
				out.println(msg1);
			}
			%>
		</h4>

		<h4 style="color: red">
			<%
			String msg2 = (String) request.getAttribute("msg2");

			if (msg2 != null) {
				out.println(msg2);
			}
			%>
		</h4>


		<div class="helper">
			Didn't get OTP? <span id="resend" class="resend">Resend</span>
		</div>

		<div id="message" class="msg"></div>
	</div>

	<script>
    const form = document.getElementById('otpForm');
    const otpInput = document.getElementById('otp');
    const msg = document.getElementById('message');
    const resend = document.getElementById('resend');
    const submitBtn = document.getElementById('submitBtn');

    // Simple client-side validation
    form.addEventListener('submit', function(e){
      const value = otpInput.value.trim();
      const valid = /^\d{6}$/.test(value);
      if(!valid){
        e.preventDefault();
        msg.textContent = 'Enter a valid 6-digit OTP.';
        msg.className = 'msg error';
        otpInput.focus();
        return;
      }
      // If you want to submit via fetch instead of normal POST:
      // e.preventDefault();
      // submitViaFetch(value);
    });

    // Resend placeholder (perform an AJAX request to /resend-otp or navigate)
    resend.addEventListener('click', function(){
      msg.textContent = 'Resending OTP...';
      msg.className = 'msg';
      // Example fetch POST (uncomment & adapt to your backend)
      /*
      fetch('/resend-otp', { method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify({ email: 'user@example.com' })})
        .then(r=>r.json()).then(j=>{
          msg.textContent = j.success ? 'OTP resent.' : 'Could not resend OTP.';
          msg.className = j.success ? 'msg success' : 'msg error';
        }).catch(()=>{ msg.textContent='Network error'; msg.className='msg error'; });
      */
      // For now show temporary message:
      setTimeout(()=>{ msg.textContent='OTP resent (simulate). Check your email.'; msg.className='msg success'; }, 1000);
    });

    // Optional: allow only digits
    otpInput.addEventListener('input', () => {
      otpInput.value = otpInput.value.replace(/\D/g,'').slice(0,6);
    });
  </script>
</body>
</html>
