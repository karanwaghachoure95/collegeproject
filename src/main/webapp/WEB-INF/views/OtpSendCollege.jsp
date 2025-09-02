<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>College OTP Verification</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        margin: 0;
        background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
    }

    .container {
        background: rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border-radius: 16px;
        padding: 40px;
        width: 380px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        color: #fff;
        text-align: center;
        animation: fadeIn 0.8s ease-in-out;
    }

    h2 {
        font-size: 26px;
        margin-bottom: 25px;
        font-weight: 600;
    }

    label {
        font-size: 14px;
        margin-bottom: 6px;
        display: block;
        text-align: left;
    }

    input[type="text"], input[type="email"] {
        width: 100%;
        padding: 12px;
        font-size: 16px;
        border: none;
        border-radius: 8px;
        outline: none;
        margin-bottom: 20px;
        box-sizing: border-box;
        background: rgba(255, 255, 255, 0.8);
        color: #000;
    }

    .btn {
        width: 100%;
        padding: 12px;
        border: none;
        border-radius: 8px;
        background: linear-gradient(to right, #4facfe, #00f2fe);
        color: white;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.3s ease;
        margin-bottom: 15px;
    }

    .btn:hover {
        transform: scale(1.05);
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    }

    .msg {
        margin-top: 10px;
        font-weight: bold;
    }

    .error {
        color: #ff4d4d;
    }

    .success {
        color: #4dff88;
    }

    .helper {
        margin-top: 12px;
        font-size: 14px;
    }

    .resend {
        color: #ffeb3b;
        cursor: pointer;
        text-decoration: underline;
        font-weight: bold;
    }

    @keyframes fadeIn {
        0% { opacity: 0; transform: translateY(-20px); }
        100% { opacity: 1; transform: translateY(0); }
    }
</style>
</head>
<body>
<div class="container">
    <h2>College OTP Verification</h2>

    <!-- Email input for sending OTP -->
    <form id="sendOtpForm" action="/sendOtp" method="post">
        <input type="hidden" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" />
        <button type="submit" class="btn">Send OTP</button>
    </form>

    <!-- OTP verification form -->
    <form id="otpForm" action="/verifyOtp" method="post" novalidate>
        <input type="hidden" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" />
        <label for="otp">Enter OTP (6 digits)</label>
        <input id="otp" name="otp" type="text" inputmode="numeric" maxlength="6" pattern="\d{6}" required />
        <button class="btn" type="submit">Verify OTP</button>
    </form>

    <!-- Messages -->
    <h4 class="success">
        <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
    </h4>
    <h4 class="error">
        <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
    </h4>

    <div class="helper">
        Didn't get OTP? <span id="resend" class="resend">Resend</span>
        <div>
                        <a href="${pageContext.request.contextPath}/home.jsp">Back to Home Page</a>
        
        </div>
        
    </div>
</div>

<script>
    const otpForm = document.getElementById('otpForm');
    const otpInput = document.getElementById('otp');
    const resend = document.getElementById('resend');
    const msg = document.querySelector('.msg');

    // OTP input validation
    otpForm.addEventListener('submit', function(e){
        const value = otpInput.value.trim();
        if(!/^\d{6}$/.test(value)){
            e.preventDefault();
            alert('Enter a valid 6-digit OTP.');
            otpInput.focus();
        }
    });

    // Resend OTP (just a UI feedback)
    resend.addEventListener('click', function(){
        alert('Click "Send OTP" button to resend the OTP.');
    });

    // Allow only numbers
    otpInput.addEventListener('input', () => {
        otpInput.value = otpInput.value.replace(/\D/g,'').slice(0,6);
    });
</script>
</body>
</html>
