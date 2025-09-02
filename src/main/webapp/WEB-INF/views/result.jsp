<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Submission Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: url('https://images.unsplash.com/photo-1562059390-a761a0847683?auto=format&fit=crop&w=1650&q=80') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .result-card {
            max-width: 850px;
            margin: 60px auto;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px 35px;
            border-radius: 20px;
            box-shadow: 0 12px 25px rgba(0,0,0,0.25);
            border-top: 5px solid #1e3d59;
        }
        .result-card h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #1e3d59;
            font-weight: bold;
        }
        .result-row {
            display: flex;
            align-items: flex-start;
            gap: 25px;
            flex-wrap: wrap;
        }
        .result-photo {
            flex: 0 0 180px;
        }
        .result-photo img {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #1e3d59;
        }
        .result-info {
            flex: 1;
            min-width: 300px;
        }
        .result-info p {
            font-size: 1.1rem;
            margin-bottom: 10px;
        }
        .result-info p strong {
            color: #1e3d59;
        }
        .btn-back {
            display: block;
            margin: 30px auto 0 auto;
            width: 220px;
            font-weight: bold;
            background: #1e3d59;
            color: #fff;
            border-radius: 50px;
            transition: all 0.3s ease;
            text-align: center;
            padding: 10px;
        }
        .btn-back:hover {
            background: #3a6ea5;
            color: #fff;
        }
    </style>
</head>
<body>

<div class="result-card">
    <h2>Library Form Submitted Successfully</h2>
    <div class="result-row">
        <div class="result-photo">
            <img src="${imagePath}" alt="Uploaded Image" />
        </div>
        <div class="result-info">
            <p><strong>Full Name:</strong> ${fullname}</p>
            <p><strong>Email:</strong> ${email}</p>
            <p><strong>Address:</strong> ${address}</p>
            <p><strong>Phone:</strong> ${phone}</p>
            <p><strong>College:</strong> ${college}</p>
            <p><strong>Class:</strong> ${studentClass}</p>
            <p><strong>Pincode:</strong> ${pincode}</p>
            <p><strong>Birth Date:</strong> ${birthdate}</p>
            <p><strong>Present Date:</strong> ${presentdate}</p>
        </div>
    </div>

    <a href="library" class="btn-back">Back to Form</a>
</div>

</body>
</html>
