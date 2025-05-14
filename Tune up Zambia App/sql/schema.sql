-- Create the database (if it doesn't exist)
CREATE DATABASE passport_system;

-- Switch to the passport_system database
\c passport_system;

-- Create the 'users' table to store user data (username, password, role, etc.)
CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       role VARCHAR(20) DEFAULT 'user', -- 'user' or 'admin'
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'passport_applications' table to store passport application data
CREATE TABLE passport_applications (
                                       id SERIAL PRIMARY KEY,
                                       user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                                       application_data JSONB NOT NULL, -- Flexible structure for application details (e.g., name, DOB, address, etc.)
                                       biometric_data BYTEA,            -- Placeholder for biometric data (e.g., fingerprint, facial scan)
                                       status VARCHAR(50) DEFAULT 'Pending', -- 'Pending', 'Approved', 'Rejected'
                                       submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'biometric_data' table to handle biometric information
CREATE TABLE biometric_data (
                                id SERIAL PRIMARY KEY,
                                application_id INT NOT NULL REFERENCES passport_applications(id) ON DELETE CASCADE,
                                fingerprint BYTEA,        -- Placeholder for fingerprint data
                                facial_scan BYTEA,         -- Placeholder for facial scan data
                                iris_scan BYTEA,           -- Placeholder for iris scan data
                                collected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'admin_actions' table to log admin actions (approval, rejection, etc.)
CREATE TABLE admin_actions (
                               id SERIAL PRIMARY KEY,
                               admin_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                               application_id INT NOT NULL REFERENCES passport_applications(id) ON DELETE CASCADE,
                               action VARCHAR(50) NOT NULL, -- 'Approved', 'Rejected', etc.
                               action_note TEXT,            -- Optional note or reason for the action
                               action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'audit_logs' table to track user and system activities for security purposes
CREATE TABLE audit_logs (
                            id SERIAL PRIMARY KEY,
                            user_id INT REFERENCES users(id) ON DELETE SET NULL,
                            action VARCHAR(255) NOT NULL, -- Description of the action
                            ip_address INET,              -- IP address of the user
                            timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
