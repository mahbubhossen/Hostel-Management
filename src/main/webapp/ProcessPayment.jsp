<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

    String userEmail = (String) session.getAttribute("userEmail");
    String paymentMethod = request.getParameter("payment_method");
    String amountStr = request.getParameter("amount");

    if (amountStr != null && !amountStr.trim().isEmpty()) {
        
        double amount = Double.parseDouble(amountStr); 

        Connection conn = null;
        PreparedStatement stmt = null;

        if (userEmail != null && paymentMethod != null && amount > 0) {
            
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "DATAFORHOSTEL", "M@hbub181253");

            String query = "INSERT INTO payments (user_email, payment_method, amount) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, userEmail);
            stmt.setString(2, paymentMethod);
            stmt.setDouble(3, amount);

            int rows = stmt.executeUpdate(); 

            stmt.close();
            conn.close();

            if (rows > 0) {
                response.sendRedirect("PaymentSuccess.jsp"); 
            } 
        }
    }
%>
