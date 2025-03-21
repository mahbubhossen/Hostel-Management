<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Room Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .room-category {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px 0;
        }
        .category-box {
            padding: 15px 25px;
            border-radius: 8px;
            background-color: #4CAF50;
            color: white;
            font-size: 18px;
            cursor: pointer;
            transition: 0.3s;
        }
        .category-box:hover {
            background-color: #388E3C;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        td {
            background-color: #f9f9f9;
        }
        .book-room-btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
        }
        .book-room-btn:hover {
            background-color: #388E3C;
        }
    </style>
</head>
<body>

    <h2>Select Room Type</h2>
    <div class="room-category">
        <div class="category-box" onclick="loadRooms('Single')">Single</div>
        <div class="category-box" onclick="loadRooms('Double')">Double</div>
        <div class="category-box" onclick="loadRooms('Triple')">Triple</div>
    </div>

    <div id="roomDetails"></div>

    <!-- Book Room Button -->
    <a href="RoomBooking.jsp" class="book-room-btn">Book Room</a>
    
    
    <h1 style="text-align: center; margin-bottom: 40px; margin-top: 60px;">All our room prices are in BDT and on a per-month basis.</h1>
    

    <script>
        function loadRooms(roomType) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "RoomDetailsAjax.jsp?room_type=" + roomType, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("roomDetails").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>

</body>
</html>
