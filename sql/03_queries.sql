-- Sample advanced SQL queries, views, function, and stored procedure.
-- Execute after schema and sample records.
-- Note: This script also contains INSERT, UPDATE and DELETE demonstrations.

USE Hotel_Management;

-- 1. Room Queries

-- INSERT
INSERT INTO Room
(Room_ID, Room_Number, Room_Type, Room_Price, Room_Status)
VALUES
(11, 207, 'Double', 350.00, 'Available');

-- BETWEEN + ORDER BY
SELECT *
FROM Room
WHERE Room_Price BETWEEN 200 AND 500
ORDER BY Room_Price DESC;

-- IN
SELECT *
FROM Room
WHERE Room_Type IN ('Single', 'Suite');

-- Aggregate + GROUP BY + HAVING
SELECT Room_Type, COUNT(*) AS Total_Rooms
FROM Room
GROUP BY Room_Type
HAVING COUNT(*) > 2;




-- 2. Guest Queries

-- LIKE
SELECT *
FROM Guest
WHERE First_Name LIKE 'A%';

-- IS NULL
SELECT *
FROM Guest
WHERE Email IS NULL;




-- 3. Payment Queries

-- UNION
SELECT Payment_Amount AS Value
FROM Payment

UNION

SELECT Room_Price AS Value
FROM Room;

-- BETWEEN
SELECT *
FROM Payment
WHERE Payment_Amount BETWEEN 300 AND 700;



-- 4. Service Queries

-- DELETE
DELETE FROM Service_Availability_Time
WHERE Service_ID = 1;

-- LIKE
SELECT *
FROM Service
WHERE Service_Name LIKE '%Service%';




-- 5. Employee Queries

-- UPDATE
UPDATE Employee
SET Employee_Salary = 9500
WHERE Job_Title = 'Manager';

-- ORDER BY
SELECT *
FROM Employee
ORDER BY Employee_Salary DESC;



-- RESERVATION QUERIES

-- 1. VIEW
CREATE VIEW Confirmed_Reservations AS
SELECT r.Reservation_ID, g.First_Name, g.Last_Name,
r.Check_in_date, r.Check_out_date, r.Reservation_Status
FROM Reservation r
JOIN Guest g ON r.Guest_ID = g.Guest_ID
WHERE r.Reservation_Status = 'CONFIRMED';

SELECT * FROM Confirmed_Reservations;

-- 2. OUTER JOIN
SELECT g.First_Name, g.Last_Name, r.Reservation_ID,
r.Check_in_date, r.Reservation_Status
FROM Guest g
LEFT OUTER JOIN Reservation r ON g.Guest_ID = r.Guest_ID;
-- 3. EXISTS
SELECT g.First_Name, g.Last_Name
FROM Guest g
WHERE EXISTS (
SELECT 1
FROM Reservation r
WHERE r.Guest_ID = g.Guest_ID
AND r.Reservation_Status = 'CONFIRMED'
);

-- 4. STORED PROCEDURE
DELIMITER $$
CREATE PROCEDURE GetReservationsByStatus(IN res_status VARCHAR(20))
BEGIN
SELECT r.Reservation_ID, g.First_Name, g.Last_Name,
r.Check_in_date, r.Check_out_date
FROM Reservation r
JOIN Guest g ON r.Guest_ID = g.Guest_ID
WHERE r.Reservation_Status = res_status;
END $$
DELIMITER ;

CALL GetReservationsByStatus('CONFIRMED');



-- INVOICE QUERIES

-- 1. FUNCTION
DELIMITER $$
CREATE FUNCTION Calculate_Final_Amount(
total DECIMAL(10,2),
tax DECIMAL(10,2),
discount DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
RETURN (total + tax - discount);
END $$
DELIMITER ;

SELECT Invoice_ID,
Calculate_Final_Amount(Total_Amount, Tax_Amount, Discount_Amount)
AS Final_Amount
FROM Invoice;

-- 2. NESTED QUERY
SELECT *
FROM Invoice
WHERE Total_Amount > (
SELECT AVG(Total_Amount)
FROM Invoice
);

-- 3. NATURAL JOIN
SELECT *
FROM Invoice
NATURAL JOIN Reservation;

-- 4. OUTER JOIN
SELECT i.Invoice_ID, i.Total_Amount, i.Invoice_Status,
p.Payment_Method, p.Payment_Status
FROM Invoice i
LEFT OUTER JOIN Payment p ON i.Reservation_ID = p.Reservation_ID;

-- 5. VIEW + AGGREGATE + GROUP BY + HAVING
CREATE VIEW Invoice_Summary AS
SELECT Invoice_Status,
COUNT(*) AS Total_Invoices,
SUM(Total_Amount) AS Total_Revenue,
AVG(Tax_Amount) AS Avg_Tax
FROM Invoice
GROUP BY Invoice_Status
HAVING COUNT(*) >= 1;

SELECT * FROM Invoice_Summary;

-- Derived Attribute Query (Final Amount)
SELECT *,
(Total_Amount + Tax_Amount - Discount_Amount) AS Final_Amount
FROM Invoice;



-- GUEST_REQUESTS_SERVICE QUERIES

-- 1. NATURAL JOIN
SELECT *
FROM Guest_Requests_Service
NATURAL JOIN Service;

-- INTERSECT USING IN
SELECT Guest_ID, Service_ID
FROM Guest_Requests_Service
WHERE Service_ID IN (
SELECT Service_ID
FROM Employee_Provides_Service
);

-- 3. OUTER JOIN
SELECT g.First_Name, g.Last_Name,
s.Service_Name, s.Service_Price
FROM Guest g
LEFT OUTER JOIN Guest_Requests_Service grs ON g.Guest_ID = grs.Guest_ID
LEFT OUTER JOIN Service s ON grs.Service_ID = s.Service_ID;



-- EMPLOYEE_PROVIDES_SERVICE QUERIES

-- 1. NATURAL JOIN
SELECT *
FROM Employee_Provides_Service
NATURAL JOIN Service;

-- 2.EXCEPT USING NOT IN
SELECT Service_ID
FROM Service
WHERE Service_ID NOT IN (
SELECT Service_ID
FROM Employee_Provides_Service
);

-- 3. OUTER JOIN + EXISTS
SELECT e.First_Name, e.Last_Name, e.Job_Title,
s.Service_Name, s.Service_Price
FROM Employee e
LEFT OUTER JOIN Employee_Provides_Service eps ON e.Employee_ID = eps.Employee_ID
LEFT OUTER JOIN Service s ON eps.Service_ID = s.Service_ID
WHERE EXISTS (
SELECT 1
FROM Employee_Provides_Service eps2
WHERE eps2.Employee_ID = e.Employee_ID);
