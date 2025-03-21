<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hostel Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        .container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 20px;
            justify-items: center;
        }
        .box {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 250px;
        }
        .box h3 {
            margin-bottom: 20px;
            color: #333;
        }
        .box a {
            display: block;
            text-decoration: none;
            color: #fff;
            background-color: #4CAF50;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .box a:hover {
            background-color: #45a049;
        }
        .logout-btn {
            background-color: #ff4d4d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            display: block;
            margin: 20px auto;
            text-align: center;
            width: 150px;
            text-decoration: none;
            text-align: center;
        }
        .logout-btn:hover {
            background-color: #cc0000;
        }
        
    </style>
</head>
<body>
<h1 style="text-align: center; margin-bottom: 40px; margin-top: 30px;">DashBoard</h1>

    <div class="container">
        <div class="box">
            <h3>Profile</h3>
            <a href="Dashboard.jsp">View Profile</a>
        </div>
        
        <div class="box">
            <h3>Room Details</h3>
            <a href="RoomDetails.jsp">View Room Details</a>
        </div>
        
        
        <div class="box">
            <h3>Payment History</h3>
            <a href="paymentHistory.jsp">View Payment History</a>
        </div>
    </div>

    <!-- Logout Button -->
    <a href="logout.jsp" class="logout-btn">Logout</a>

</body>
</html>
