<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Processing Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 40%;
            margin: 100px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        h2 {
            color: #333;
        }

        .message {
            font-size: 18px;
            color: #28a745;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .error {
            color: red;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
<%
    // Oracle Database Connection Info
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String username = "DATAFORHOSTEL";  // নিজের Oracle username দিও
    String password = "M@hbub181253";  // নিজের Oracle password দিও

    // User Input Data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String pass = request.getParameter("password");
    String dob = request.getParameter("dob");
    String gender = request.getParameter("gender");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load Oracle JDBC Driver
        Class.forName("oracle.jdbc.driver.OracleDriver");
        
        // Create Connection
        conn = DriverManager.getConnection(url, username, password);

        // SQL Query
        String sql = "INSERT INTO users (name, email, phone_number, password, date_of_birth, gender) VALUES (?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, phone);
        pstmt.setString(4, pass);
        pstmt.setString(5, dob);
        pstmt.setString(6, gender);

        // Execute Query
        int rowsInserted = pstmt.executeUpdate();

        if (rowsInserted > 0) {
%>
<%
response.sendRedirect("loginPage.jsp"); 
%>
            <h2>Registration Successful!</h2>
            <p class="message">Welcome, <%= name %>! Your account has been created.</p>
            <a href="loginPage.jsp" class="btn">Go to Login</a>
<%
        } else {
%>
            <h2 class="error">Registration Failed!</h2>
            <p class="error">Something went wrong. Please try again.</p>
<%
        }

    } catch (Exception e) {
%>
        <h2 class="error">Error Occurred!</h2>
        <p class="error"><%= e.getMessage() %></p>
<%
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
</div>

</body>
</html>
