<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
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
    </style>
</head>
<body>

<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        
        Class.forName("oracle.jdbc.driver.OracleDriver");
        
        
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "DATAFORHOSTEL", "M@hbub181253");

        
        stmt = conn.createStatement();

        
        String sql = "SELECT ROOM_NUMBER, ROOM_TYPE, PRICE, STATUS FROM ROOMS";

        
        rs = stmt.executeQuery(sql);
%>

    
    <table>
        <thead>
            <tr>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Price</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                
                while(rs.next()) {
                    int roomNumber = rs.getInt("ROOM_NUMBER");
                    String roomType = rs.getString("ROOM_TYPE");
                    double price = rs.getDouble("PRICE");
                    String status = rs.getString("STATUS");
            %>
            <tr>
                <td><%= roomNumber %></td>
                <td><%= roomType %></td>
                <td><%= price %></td>
                <td><%= status %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>

</body>
</html>
