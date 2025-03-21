<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String roomType = request.getParameter("room_type");

    try {
        Class.forName("oracle.jdbc.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "DATAFORHOSTEL", "M@hbub181253");

        String sql = "SELECT ROOM_NUMBER, PRICE, STATUS FROM ROOMS WHERE ROOM_TYPE = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, roomType);
        rs = pstmt.executeQuery();
%>

<table>
    <thead>
        <tr>
            <th>Room Number</th>
            <th>Price</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <%
            while(rs.next()) {
                int roomNumber = rs.getInt("ROOM_NUMBER");
                double price = rs.getDouble("PRICE");
                String status = rs.getString("STATUS");
        %>
        <tr>
            <td><%= roomNumber %></td>
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
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
