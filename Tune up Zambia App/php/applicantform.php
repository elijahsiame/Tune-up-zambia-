<?php
$servername = "localhost"; // Change if needed
$username = "root"; // Use your MySQL username
$password = ""; // Use your MySQL password
$database = "car_maintenance";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get form data
$customer_name = $_POST['customerName'];
$phone = $_POST['phone'];
$email = $_POST['email'];
$car_model = $_POST['carModel'];
$license_plate = $_POST['licensePlate'];
$service_type = $_POST['serviceType'];
$description = $_POST['description'];

// Insert data into database
$sql = "INSERT INTO requests (customer_name, phone, email, car_model, license_plate, service_type, description)
        VALUES ('$customer_name', '$phone', '$email', '$car_model', '$license_plate', '$service_type', '$description')";

if ($conn->query($sql) === TRUE) {
    echo "success";
} else {
    echo "error";
}

$conn->close();
?>
