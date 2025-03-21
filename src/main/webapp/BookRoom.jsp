<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String url = "jdbc:oracle:thin:@localhost:1521:xe"; 
    String username = "DATAFORHOSTEL";  
    String password = "M@hbub181253";  

    String userEmail = request.getParameter("user_email");  
    String roomType = request.getParameter("room_type");   
    String roomId = "";
    String price = "";

    if (userEmail != null && roomType != null) {
        try {
            // Oracle JDBC ড্রাইভার লোড
            Class.forName("oracle.jdbc.OracleDriver");

            // ডাটাবেজ সংযোগ
            conn = DriverManager.getConnection(url, username, password);

            // রুম তথ্য খোঁজা
            String query = "SELECT ROOM_NUMBER, PRICE FROM ROOMS WHERE ROOM_TYPE = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, roomType);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                roomId = rs.getString("ROOM_NUMBER");  
                price = rs.getString("PRICE");   
            }

            // যদি রুম পাওয়া যায় তাহলে বুকিং সংরক্ষণ এবং session সেট করা
            if (roomId != null && price != null) {
                String insertQuery = "INSERT INTO ROOM_BOOKINGS (USER_EMAIL, ROOM_ID, ROOM_TYPE, AMOUNT, BOOKING_DATE) "
                                   + "VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, userEmail);     
                pstmt.setString(2, roomId);        
                pstmt.setString(3, roomType);       
                pstmt.setString(4, price);         
                pstmt.setDate(5, new Date(System.currentTimeMillis())); 

                int result = pstmt.executeUpdate();

                if (result > 0) {
                    // **Session এ price সংরক্ষণ**
                    session.setAttribute("userEmail", userEmail);
                    session.setAttribute("roomType", roomType);
                    session.setAttribute("roomId", roomId);
                    session.setAttribute("price", price); // Price সংরক্ষণ করলাম
                    
                    // Make Payment পেজে রিডাইরেক্ট
                    response.sendRedirect("MakePayment.jsp");
                } else {
                    out.println("Please Try again");
                }
            } else {
                out.println("Room Information not found");
            }

        } catch (ClassNotFoundException e) {
            out.println("Oracle JDBC Driver not found " + e.getMessage());
        } catch (SQLException e) {
            out.println("Database error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("Connection error: " + e.getMessage());
            }
        }
    } else {
        out.println("Fill up all information");
    }
%>
