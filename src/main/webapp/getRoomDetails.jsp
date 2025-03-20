<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String roomType = request.getParameter("room_type");
    String roomDetails = "";

    if (roomType != null && !roomType.isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "DATAFORHOSTEL", "M@hbub181253");

            
            String query = "SELECT ROOM_NUMBER, ROOM_TYPE, PRICE, STATUS FROM ROOMS WHERE ROOM_TYPE = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, roomType);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String roomNumber = rs.getString("ROOM_NUMBER");
                String price = rs.getString("PRICE");
                String status = rs.getString("STATUS");

                roomDetails += "<div class='room'>";
                roomDetails += "<p>Room Number: " + roomNumber + "</p>";
                roomDetails += "<p>Price: " + price + "</p>";
                roomDetails += "<p>Status: " + status + "</p>";
                roomDetails += "<input type='radio' name='room_number' value='" + roomNumber + "'> Select this room<br>";
                roomDetails += "</div><br>";
            }

        } catch (Exception e) {
            roomDetails = "Error fetching room details: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    out.println(roomDetails);
%>
