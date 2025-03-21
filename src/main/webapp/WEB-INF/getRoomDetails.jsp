<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    String roomType = request.getParameter("room_type");
    String roomDetailsHtml = "";
    
    if (roomType != null && !roomType.isEmpty()) {
        // Setup database connection
        String url = "jdbc:oracle:thin:@localhost:1521:xe";  // Update with your DB details
        String username = "your_username";
        String password = "your_password";
        
        try {
            // Load the database driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(url, username, password);
            
            String query = "SELECT * FROM rooms WHERE room_type = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, roomType);
            ResultSet rs = stmt.executeQuery();
            
            // Check if room data is available
            if (rs.next()) {
                roomDetailsHtml = "<div class='room-info'>";
                roomDetailsHtml += "<p><span>Room Type:</span> " + rs.getString("room_type") + "</p>";
                roomDetailsHtml += "<p><span>Price per Night:</span> " + rs.getInt("price") + " BDT</p>";
                roomDetailsHtml += "<p><span>Availability:</span> " + rs.getInt("availability") + " rooms available</p>";
                roomDetailsHtml += "<p><span>Room Description:</span> " + rs.getString("description") + "</p>";
                roomDetailsHtml += "</div>";
            } else {
                roomDetailsHtml = "<p>No details found for this room type.</p>";
            }
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            roomDetailsHtml = "<p>Error fetching room details. Please try again later.</p>";
        }
    }
    
    // Return the HTML response to be displayed
    out.print(roomDetailsHtml);
%>
