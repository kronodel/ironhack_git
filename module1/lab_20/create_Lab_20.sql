-- Challenge 2 - Create the Database and Tables -- 

CREATE DATABASE if not exists lab_mysql;
USE lab_mysql;

CREATE TABLE if not exists Cars (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    VIN VARCHAR(255) NOT NULL,
    Manufacturer VARCHAR(255) NOT NULL,
    Model VARCHAR(255) NOT NULL,
    Year INT NOT NULL,
    Color VARCHAR(255) NOT NULL
);

CREATE TABLE if not exists Customers (
    ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Phone_number VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    State_Province VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL,
    Zip_Postal_code VARCHAR(255) NOT NULL
);

CREATE TABLE if not exists Salespersons (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Staff_ID INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Store VARCHAR(255) NOT NULL
);

CREATE TABLE if not exists Invoices (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Invoice_number INT NOT NULL,
    Date DATE NOT NULL,
    Car INT NOT NULL,
    Customer INT NOT NULL,
    Salesperson INT NOT NULL,
    FOREIGN KEY (Car) REFERENCES Cars(ID),
    FOREIGN KEY (Customer) REFERENCES Customers(ID),
    FOREIGN KEY (Salesperson) REFERENCES Salespersons(ID)
);
