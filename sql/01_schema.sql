-- Hotel Management Database - schema
-- Create the database and tables.

CREATE DATABASE Hotel_Management;

USE Hotel_Management;




-- =========================================================
-- GUEST
-- =========================================================

CREATE TABLE Guest (
    Guest_ID INT PRIMARY KEY,
    Email VARCHAR(100),
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Postal_Code VARCHAR(10),
    Country VARCHAR(50),
    Street VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Guest_Phone_Number (
    Guest_ID INT,
    Guest_Phone_Number VARCHAR(15),

     PRIMARY KEY (Guest_ID, Guest_Phone_Number),

     FOREIGN KEY (Guest_ID)
         REFERENCES Guest(Guest_ID)
         ON DELETE CASCADE
);

-- =========================================================
-- EMPLOYEE
-- =========================================================

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Last_Name VARCHAR(50) NOT NULL,
    First_Name VARCHAR(50) NOT NULL,
    Job_Title VARCHAR(50) NOT NULL,
    Employee_Salary DECIMAL(10,2) NOT NULL
        CHECK (Employee_Salary > 0),
    Hire_Date DATE NOT NULL
);

CREATE TABLE Employee_Phone_Number (
    Employee_ID INT,
    Employee_Phone_Number VARCHAR(15),

     PRIMARY KEY (Employee_ID, Employee_Phone_Number),

     FOREIGN KEY (Employee_ID)
         REFERENCES Employee(Employee_ID)
         ON DELETE CASCADE
);

CREATE TABLE Working_Shifts (
    Employee_ID INT,
    Working_Shifts TIME,

     PRIMARY KEY (Employee_ID, Working_Shifts),

     FOREIGN KEY (Employee_ID)
         REFERENCES Employee(Employee_ID)
         ON DELETE CASCADE
);

-- =========================================================
-- ROOM
-- =========================================================

CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Room_Number INT NOT NULL UNIQUE,
    Room_Type VARCHAR(50) NOT NULL,
    Room_Price DECIMAL(8,2) NOT NULL
        CHECK (Room_Price > 0),
    Room_Status VARCHAR(20) NOT NULL
);

CREATE TABLE Room_Features (
    Room_ID INT,
    Room_Features VARCHAR(50),

     PRIMARY KEY (Room_ID, Room_Features),
     FOREIGN KEY (Room_ID)
         REFERENCES Room(Room_ID)
         ON DELETE CASCADE
);




-- =========================================================
-- RESERVATION
-- =========================================================

CREATE TABLE Reservation (
Reservation_ID INT AUTO_INCREMENT PRIMARY KEY,
Check_in_date DATE NOT NULL,
Check_out_date DATE NOT NULL,

Reservation_Status ENUM(
'CONFIRMED',
'CANCELED',
'REJECTED'
) NOT NULL,

Number_of_Guests INT NOT NULL
CHECK (Number_of_Guests > 0),

Guest_ID INT NOT NULL,
Room_ID INT NOT NULL,
Employee_ID INT,

FOREIGN KEY (Guest_ID)
REFERENCES Guest(Guest_ID),

FOREIGN KEY (Room_ID)
REFERENCES Room(Room_ID),

FOREIGN KEY (Employee_ID)
REFERENCES Employee(Employee_ID)
);

-- 5. TRIGGER
DELIMITER $$
CREATE TRIGGER Check_Dates_Before_Insert
BEFORE INSERT ON Reservation
FOR EACH ROW
BEGIN
IF NEW.Check_out_date <= NEW.Check_in_date THEN
SET NEW.Check_out_date = DATE_ADD(NEW.Check_in_date, INTERVAL 1 DAY);
END IF;
END $$
DELIMITER ;




-- =========================================================
-- PAYMENT
-- =========================================================

CREATE TABLE Payment (
Payment_ID INT AUTO_INCREMENT PRIMARY KEY,

Reservation_ID INT,

Payment_Date DATE NOT NULL,
Payment_Amount DECIMAL(10,2) NOT NULL,
Payment_Method VARCHAR(50) NOT NULL,

Payment_Status ENUM(
'Pending',
'Processing',
'Success',
'Declined'
) NOT NULL DEFAULT 'Pending',

FOREIGN KEY (Reservation_ID)
REFERENCES Reservation(Reservation_ID)
);




-- =========================================================
-- INVOICE
-- =========================================================

CREATE TABLE Invoice (
Invoice_ID INT AUTO_INCREMENT PRIMARY KEY,
Reservation_ID INT,
Guest_ID INT,

 Invoice_Date DATE,

Total_Amount DECIMAL(10,2) NOT NULL DEFAULT 0,
Tax_Amount DECIMAL(10,2) NOT NULL DEFAULT 0,
Discount_Amount DECIMAL(10,2) NOT NULL DEFAULT 0,
Invoice_Status VARCHAR(30),
 Notes VARCHAR(255),

FOREIGN KEY (Reservation_ID)
REFERENCES Reservation(Reservation_ID),

FOREIGN KEY (Guest_ID)
REFERENCES Guest(Guest_ID)
);




-- =========================================================
-- SERVICE
-- =========================================================

CREATE TABLE Service (
Service_ID INT AUTO_INCREMENT PRIMARY KEY,
Service_Name VARCHAR(100) NOT NULL,
Service_Description VARCHAR(255),
Service_Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Service_Availability_Time (
Service_ID INT,
Service_Availability_Time VARCHAR(50),
PRIMARY KEY(Service_ID, Service_Availability_Time),

FOREIGN KEY (Service_ID)
REFERENCES Service(Service_ID)
ON DELETE CASCADE
);




-- =========================================================
-- MANY TO MANY RELATIONSHIPS
-- =========================================================

CREATE TABLE Guest_Requests_Service (
Guest_ID INT,
Service_ID INT,

PRIMARY KEY (Guest_ID, Service_ID),

FOREIGN KEY (Guest_ID)
REFERENCES Guest(Guest_ID)
ON DELETE CASCADE,

FOREIGN KEY (Service_ID)
REFERENCES Service(Service_ID)
ON DELETE CASCADE
);

CREATE TABLE Employee_Provides_Service (
Employee_ID INT,
Service_ID INT,

PRIMARY KEY (Employee_ID, Service_ID),

FOREIGN KEY (Employee_ID)
REFERENCES Employee(Employee_ID)
ON DELETE CASCADE,

FOREIGN KEY (Service_ID)
REFERENCES Service(Service_ID)
ON DELETE CASCADE
);
