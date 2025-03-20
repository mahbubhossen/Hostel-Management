<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 60%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .back-btn {
            display: block;
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Payment History</h2>

        <table>
            <tr>
                <th>Payment ID</th>
                <th>Email</th>
                <th>Method</th>
                <th>Amount</th>
                <th>Date</th>
            </tr>

            <%
                
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                
                String userEmail = (String) session.getAttribute("userEmail");

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "DATAFORHOSTEL", "M@hbub181253");

                    
                    String query = "SELECT * FROM PAYMENTS WHERE USER_EMAIL = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, userEmail);
                    rs = pstmt.executeQuery();

                    boolean isEmpty = true;
                    while (rs.next()) {
                        isEmpty = false;
            %>
                        <tr>
                            <td><%= rs.getInt("PAYMENT_ID") %></td>
                            <td><%= rs.getString("USER_EMAIL") %></td>
                            <td><%= rs.getString("PAYMENT_METHOD") %></td>
                            <td><%= rs.getInt("AMOUNT") %></td>
                            <td><%= rs.getString("PAYMENT_DATE") %></td>
                        </tr>
            <%
                    }
                    if (isEmpty) {
                        out.println("<tr><td colspan='5' style='color:red;'>No payment history found.</td></tr>");
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='5' style='color:red;'>Error retrieving data!</td></tr>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            %>
        </table>

        <a href="AfterLogin.jsp" class="back-btn">Back to Dashboard</a>
    </div>

</body>
</html>
