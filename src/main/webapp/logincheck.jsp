<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Processing</title>
</head>
<body>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String url = "jdbc:oracle:thin:@localhost:1521:xe";  
    String username = "DATAFORHOSTEL"; 
    String dbPassword = "M@hbub181253";  

    Class.forName("oracle.jdbc.OracleDriver");

    conn = DriverManager.getConnection(url, username, dbPassword);

    String checkQuery = "SELECT * FROM USERS WHERE EMAIL = ? AND PASSWORD = ?";
    pstmt = conn.prepareStatement(checkQuery);
    pstmt.setString(1, email);
    pstmt.setString(2, password);
    rs = pstmt.executeQuery();

    if (rs.next()) {  
        session.setAttribute("userEmail", email);  
        response.sendRedirect("Dashboard.jsp");  
    } else {  
        out.println("<h3 style='color:red;'>Invalid Email or Password</h3>");
    }

    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
%>

</body>
</html>
