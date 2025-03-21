<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 60%;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        p {
            font-size: 18px;
            color: #555;
            line-height: 1.6;
        }
        .dashboard-content {
            margin-top: 20px;
        }
        .dashboard-content p {
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }
        .logout-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }
        .logout-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Welcome to the Profile</h2>

        <div class="dashboard-content">
            <%
                String email = (String) session.getAttribute("userEmail");
                
                if(email != null) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    PreparedStatement bookingPstmt = null;
                    ResultSet bookingRs = null;
                    String url = "jdbc:oracle:thin:@localhost:1521:xe"; 
                    String dbUsername = "DATAFORHOSTEL";  
                    String dbPassword = "M@hbub181253";  

                    try {
                        // Load the Oracle JDBC driver
                        Class.forName("oracle.jdbc.OracleDriver");

                        // Establish the connection
                        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

                        // Query to get user information
                        String query = "SELECT USER_ID, NAME, PHONE_NUMBER, DATE_OF_BIRTH, REGISTRATION_DATE, GENDER FROM USERS WHERE EMAIL = ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, email);
                        rs = pstmt.executeQuery();

                        if(rs.next()) {
                            // Display user details
                            String name = rs.getString("NAME");
                            String phoneNumber = rs.getString("PHONE_NUMBER");
                            String dateOfBirth = rs.getString("DATE_OF_BIRTH");
                            String registrationDate = rs.getString("REGISTRATION_DATE");
                            String gender = rs.getString("GENDER");

                            out.println("<p><strong>Name: </strong>" + name + "</p>");
                            out.println("<p><strong>Email: </strong>" + email + "</p>");
                            out.println("<p><strong>Phone Number: </strong>" + phoneNumber + "</p>");
                            out.println("<p><strong>Date of Birth: </strong>" + dateOfBirth + "</p>");
                            out.println("<p><strong>Registration Date: </strong>" + registrationDate + "</p>");
                            out.println("<p><strong>Gender: </strong>" + gender + "</p>");

                            // Query to get room booking details
                            String bookingQuery = "SELECT ROOM_ID, ROOM_TYPE, AMOUNT, BOOKING_DATE FROM ROOM_BOOKINGS WHERE USER_EMAIL = ?";
                            bookingPstmt = conn.prepareStatement(bookingQuery);
                            bookingPstmt.setString(1, email);
                            bookingRs = bookingPstmt.executeQuery();

                            if(bookingRs.next()) {
                                out.println("<h3>Room Booking Details:</h3>");
                                do {
                                    String roomId = bookingRs.getString("ROOM_ID");
                                    String roomType = bookingRs.getString("ROOM_TYPE");
                                    String amount = bookingRs.getString("AMOUNT");
                                    String bookingDate = bookingRs.getString("BOOKING_DATE");

                                    out.println("<p><strong>Room ID: </strong>" + roomId + "</p>");
                                    out.println("<p><strong>Room Type: </strong>" + roomType + "</p>");
                                    out.println("<p><strong>Amount: </strong>" + amount + "</p>");
                                    out.println("<p><strong>Booking Date: </strong>" + bookingDate + "</p>");
                                } while(bookingRs.next());
                            } else {
                                out.println("<p>No room bookings found.</p>");
                            }

                        } else {
                            out.println("<p> User not found.</p>");
                        }

                    } catch (ClassNotFoundException e) {
                        out.println("Oracle JDBC Driver not found " + e.getMessage());
                    } catch (SQLException e) {
                        out.println("Database error " + e.getMessage());
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (bookingRs != null) bookingRs.close();
                            if (bookingPstmt != null) bookingPstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.println("Connection error " + e.getMessage());
                        }
                    }

                    out.println("<a href='logout.jsp' class='logout-btn'>Logout</a>");
                } else {
                    response.sendRedirect("loginPage.jsp");
                }
            %>
        </div>
    </div>

</body>
</html>
