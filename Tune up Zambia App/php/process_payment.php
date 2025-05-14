<?php
$servername = "localhost";
$username = "root"; // Change if necessary
$password = ""; // Change if necessary
$database = "car_maintenance";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve form data
$customer_name = $_POST['customerName'];
$car_model = $_POST['carModel'];
$service_type = $_POST['serviceType'];
$email = $_POST['email'];
$amount = $_POST['amount'];

// Insert data into database
$sql = "INSERT INTO payments (customer_name, car_model, service_type, email, amount)
        VALUES ('$customer_name', '$car_model', '$service_type', '$email', '$amount')";

if ($conn->query($sql) === TRUE) {
    echo "success";
} else {
    echo "error";
}

$conn->close();
?>
