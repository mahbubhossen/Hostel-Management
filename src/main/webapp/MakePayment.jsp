<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Make Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            font-weight: bold;
        }
        select, input[type="submit"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
        }
        .payment-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
        .payment-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Make Payment</h2>

        
        <form action="ProcessPayment.jsp" method="post">
            <div class="form-group">
                <label for="payment_method">Select Payment Method:</label>
                <select name="payment_method" id="payment_method" required>
                    <option value="">Select</option>
                    <option value="Bkash">Bkash</option>
                    <option value="Nagad">Nagad</option>
                    <option value="Rocket">Rocket</option>
                </select>
            </div>

            <div class="form-group">
                <label for="amount">Enter Amount:</label>
                <input type="number" name="amount" id="amount" min="1" required placeholder="Enter amount in BDT">
            </div>
 
            <div class="form-group">
                
                <input type="submit" class="payment-btn" value="Proceed to Pay">
            </div>

        </form>
    </div>

</body>
</html>
