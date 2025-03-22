<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "DATAFORHOSTEL", "M@hbub181253");

    String userEmail = request.getParameter("user_email");  
    String roomType = request.getParameter("room_type");   
    String roomId = "";
    String price = "";

    if (userEmail != null && roomType != null) {
        
        Class.forName("oracle.jdbc.OracleDriver");

        PreparedStatement pstmt = conn.prepareStatement("SELECT ROOM_NUMBER, PRICE FROM ROOMS WHERE ROOM_TYPE = ?");
        pstmt.setString(1, roomType);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            roomId = rs.getString("ROOM_NUMBER");
            price = rs.getString("PRICE");
        }

        rs.close();
        pstmt.close();

        if (roomId != null && price != null) {
            pstmt = conn.prepareStatement("INSERT INTO ROOM_BOOKINGS (USER_EMAIL, ROOM_ID, ROOM_TYPE, AMOUNT, BOOKING_DATE) VALUES (?, ?, ?, ?, ?)");
            pstmt.setString(1, userEmail);
            pstmt.setString(2, roomId);
            pstmt.setString(3, roomType);
            pstmt.setString(4, price);
            pstmt.setDate(5, new Date(System.currentTimeMillis()));

            int result = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            if (result > 0) {
                session.setAttribute("userEmail", userEmail);
                session.setAttribute("roomType", roomType);
                session.setAttribute("roomId", roomId);
                session.setAttribute("price", price);

                response.sendRedirect("MakePayment.jsp");
            } else {
                out.println("Please Try again");
            }
        } else {
            out.println("Room Information not found");
        }
    } else {
        out.println("Fill up all information");
    }
%>
