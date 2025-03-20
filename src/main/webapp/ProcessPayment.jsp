<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    
    String userEmail = (String) session.getAttribute("userEmail");
    String paymentMethod = request.getParameter("payment_method");
    String amountStr = request.getParameter("amount");
    String errorMessage = "";

    
    if (amountStr != null && !amountStr.trim().isEmpty()) {
        try {
            double amount = Double.parseDouble(amountStr);

            
            Connection conn = null;
            PreparedStatement stmt = null;

            if (userEmail != null && paymentMethod != null && amount > 0) {
                try {
                    
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "DATAFORHOSTEL", "M@hbub181253");

                    
                    String query = "INSERT INTO payments (user_email, payment_method, amount) VALUES (?, ?, ?)";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, userEmail);
                    stmt.setString(2, paymentMethod);
                    stmt.setDouble(3, amount);

                    int rows = stmt.executeUpdate(); 

                    if (rows > 0) {
                        response.sendRedirect("PaymentSuccess.jsp"); 
                    } else {
                        errorMessage = "Payment failed. Please try again.";
                    }
                } catch (Exception e) {
                    errorMessage = "Database error: " + e.getMessage();
                } finally {
                    try {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                errorMessage = "Invalid payment details.";
            }
        } catch (NumberFormatException e) {
            errorMessage = "Invalid amount entered. Please enter a valid number.";
        }
    } else {
        errorMessage = "Amount is required.";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Processing Payment</title>
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
        .error {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Processing Payment</h2>

        <div class="error">
            <%= errorMessage %>
        </div>
    </div>

</body>
</html>
