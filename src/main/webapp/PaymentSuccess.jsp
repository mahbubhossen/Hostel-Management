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
        <h2>Payment Successful</h2>
        
        
        <div class="success-message">
            Your payment has been successfully completed.
        </div>

       
        <p>You will be redirected to the dashboard in 3 seconds...</p>

        <script>
            setTimeout(function() {
                window.location.href = "AfterLogin.jsp"; 
            }, 3000); 
        </script>
    </div>

</body>
</html>
