<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            font-size: 16px;
            color: #555;
        }

        select, input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            margin-top: 8px;
            border-radius: 5px;
            border: 1px solid #ddd;
            box-sizing: border-box;
        }

        select {
            background-color: #f9f9f9;
        }

        .payment-btn {
            list-style: none;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 18px;
            border-radius: 5px;
        }

        .payment-btn:hover {
            background-color: #45a049;
        }

        #room_details {
            margin-top: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: none;
        }

        .room-info {
            font-size: 16px;
            color: #333;
        }

        .room-info p {
            margin: 5px 0;
        }

        .room-info span {
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Room Booking</h2>

       
        <form action="BookRoom.jsp" method="post">
            <div class="form-group">
                <label for="user_email">Your Email</label>
                <input type="text" name="user_email" id="user_email" required>
            </div>
            
            <div class="form-group">
                <label for="room_type">Select Room Type</label>
                <select name="room_type" id="room_type" onchange="getRoomDetails(this.value)" required>
                    <option value="">Select</option>
                    <option value="Single">Single</option>
                    <option value="Double">Double</option>
                    <option value="Triple">Triple</option>
                </select>
            </div>
            
            
            <div id="room_details">
                
            </div>

            <div class="form-group">
                <input type="submit" value="Book Room" class="payment-btn">
            </div>
        </form>
    </div>

    <script>
        
        function getRoomDetails(roomType) {
            if (roomType) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "getRoomDetails.jsp?room_type=" + roomType, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        document.getElementById("room_details").innerHTML = xhr.responseText;
                        document.getElementById("room_details").style.display = 'block'; 
                    }
                };
                xhr.send();
            } else {
                document.getElementById("room_details").innerHTML = "";
                document.getElementById("room_details").style.display = 'none';  
            }
        }
    </script>

</body>
</html>
