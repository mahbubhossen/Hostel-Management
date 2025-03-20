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
                    String url = "jdbc:oracle:thin:@localhost:1521:xe"; 
                    String dbUsername = "DATAFORHOSTEL";  
                    String dbPassword = "M@hbub181253";  

                    try {
                        
                        Class.forName("oracle.jdbc.OracleDriver");

                        
                        conn = DriverManager.getConnection(url, dbUsername, dbPassword);

                        
                        String query = "SELECT * FROM USERS WHERE EMAIL = ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, email);
                        rs = pstmt.executeQuery();

                        if(rs.next()) {
                            String password = rs.getString("PASSWORD");  
                            out.println("<p>Email: " + email + "</p>");
                            out.println("<p>Password: " + password + "</p>");
                        } else {
                            out.println("<p> User not Found</p>");
                        }

                    } catch (ClassNotFoundException e) {
                        out.println("Oracle JDBC Driver not found " + e.getMessage());
                    } catch (SQLException e) {
                        out.println("Database error " + e.getMessage());
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.println("connection error " + e.getMessage());
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
