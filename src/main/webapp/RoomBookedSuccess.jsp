<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .success-message {
            color: green;
            font-size: 20px;
            font-weight: bold;
        }
        p {
            font-size: 16px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Success!!</h2>
        
        <!-- Payment Success Message -->
        <div class="success-message">
            Room Booked Successfully!!
        </div>

        <!-- Redirect Message -->
        <p>আপনি 3 সেকেন্ডের মধ্যে ড্যাশবোর্ডে রিডাইরেক্ট হবেন...</p>

        <script>
            setTimeout(function() {
                window.location.href = "MakePayment.jsp"; // Redirect to dashboard or any other page
            }, 3000); // Redirect after 3 seconds
        </script>
    </div>

</body>
</html>
