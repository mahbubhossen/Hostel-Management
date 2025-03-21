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

    try {
        
        Class.forName("oracle.jdbc.OracleDriver");

        
        conn = DriverManager.getConnection(url, username, dbPassword);

        
        String checkQuery = "SELECT * FROM USERS WHERE EMAIL = ? AND PASSWORD = ?";
        pstmt = conn.prepareStatement(checkQuery);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            
            session.setAttribute("userEmail", email);  
            response.sendRedirect("AfterLogin.jsp");  
        } else {
            
            String insertQuery = "INSERT INTO USERS (EMAIL, PASSWORD) VALUES (?, ?)";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            int result = pstmt.executeUpdate();

            if (result > 0) {
                session.setAttribute("userEmail", email);  
                response.sendRedirect("AfterLogin.jsp");  
            } else {
                out.println("<h3 style='color:red;'>Data Can't save</h3>");
            }
        }

    } catch (ClassNotFoundException e) {
        out.println("Oracle JDBC Driver not found" + e.getMessage());
    } catch (SQLException e) {
        out.println("User Not Found" + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println( e.getMessage());
        }
    }
%>

</body>
</html>
