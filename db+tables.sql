-- Create the database
CREATE DATABASE IF NOT EXISTS bank;

-- Use the database
USE bank;

-- Create the users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    checking_balance DECIMAL(10, 2) DEFAULT 0,
    savings_balance DECIMAL(10, 2) DEFAULT 0
);

-- Create the user
CREATE USER 'sysadmin'@'%' IDENTIFIED BY 'changeme';

-- Grant privileges on the bank database to the user from any host
GRANT ALL PRIVILEGES ON bank.* TO 'sysadmin'@'%';

-- Flush privileges to apply changes
FLUSH PRIVILEGES;

-- Insert 5 users with realistic data into the users table
INSERT INTO users (username, password, checking_balance, savings_balance)
VALUES 
    ('johndoe', 'Passw0rd!', 2500.00, 10000.00),
    ('janedoe', 'Secret123', 3000.00, 15000.00),
    ('michael_smith', 'P@ssw0rd', 5000.00, 20000.00),
    ('emily_jones', 'Sunshine42', 4000.00, 18000.00),
    ('alex_wang', 'Welcome2022', 3500.00, 22000.00),
    ('amanda_smith', 'BlueSky987', 4200.00, 18000.00),
    ('ryan_miller', 'Summer2023', 3200.00, 12000.00),
    ('laura_jackson', 'GreenApple42', 3800.00, 16000.00),
    ('daniel_wilson', 'P@ssword!', 4800.00, 22000.00),
    ('sophia_brown', 'Blossom123', 2700.00, 14000.00),
    ('natalie_adams', 'Sunset2023', 3800.00, 16000.00),
    ('kevin_rodriguez', 'Winter2024', 4200.00, 18000.00),
    ('jessica_carter', 'Moonlight!', 3000.00, 12000.00),
    ('adam_gonzalez', 'Skyline789', 3500.00, 14000.00),
    ('olivia_martinez', 'Spring2025', 4000.00, 16000.00);