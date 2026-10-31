-- Fictional sample records for demonstration.
-- Requires sql/01_schema.sql first.

USE Hotel_Management;

-- =========================
-- Guest
-- =========================
INSERT INTO Guest
(Guest_ID, Email, First_Name, Last_Name, Postal_Code, Country, Street, City)
VALUES
(1, 'ahmed@example.com', 'Ahmed', 'Ali', '31411', 'Saudi Arabia', 'King Road', 'Dammam'),
(2, 'sara@example.com', 'Sara', 'Mohammed', '11564', 'Saudi Arabia', 'Olaya Street', 'Riyadh'),
(3, 'lana@example.com', 'Lana', 'Khaled', '21955', 'Saudi Arabia', 'Sea Street', 'Jeddah'),
(4, 'mona@example.com', 'Mona', 'Hassan', '31952', 'Saudi Arabia', 'Palm Street', 'Khobar'),
(5, 'yousef@example.com', 'Yousef', 'Salem', '51432', 'Saudi Arabia', 'Prince Road', 'Jubail'),
(6, 'reem@example.com', 'Reem', 'Nasser', '24231', 'Saudi Arabia', 'Airport Road', 'Makkah'),
(7, 'faisal@example.com', 'Faisal', 'Omar', '42311', 'Saudi Arabia', 'University St', 'Madinah'),
(8, 'noor@example.com', 'Noor', 'Saad', '71321', 'Saudi Arabia', 'Garden St', 'Hail'),
(9, 'amal@example.com', 'Amal', 'Kareem', '81111', 'Saudi Arabia', 'Lake Road', 'Tabuk'),
(10, 'tariq@example.com', 'Tariq', 'Majed', '91919', 'Saudi Arabia', 'City Center', 'Abha');



-- =========================
-- Guest Phone Numbers
-- =========================
INSERT INTO Guest_Phone_Number
(Guest_ID, Guest_Phone_Number)
VALUES
(1, '0000000001'),
(2, '0000000002'),
(3, '0000000003'),
(4, '0000000004'),
(5, '0000000005'),
(6, '0000000006'),
(7, '0000000007'),
(8, '0000000008'),
(9, '0000000009'),
(10, '0000000010');



-- =========================
-- Employee
-- =========================
INSERT INTO Employee
(Employee_ID, Last_Name, First_Name, Job_Title, Employee_Salary, Hire_Date)
VALUES
(1, 'Hassan', 'Omar', 'Manager', 9500, '2022-03-15'),
(2, 'Ali', 'Nora', 'Receptionist', 5000, '2023-01-10'),
(3, 'Salem', 'Fahad', 'Cleaner', 3500, '2024-02-01'),
(4, 'Khaled', 'Rana', 'Chef', 6000, '2021-07-20'),
(5, 'Nasser', 'Majed', 'Security', 4000, '2020-11-05'),
(6, 'Saad', 'Amal', 'Receptionist', 5200, '2022-08-14'),
(7, 'Yousef', 'Huda', 'Cleaner', 3400, '2023-09-09'),
(8, 'Omar', 'Lina', 'Chef', 6200, '2021-04-18'),
(9, 'Kareem', 'Sami', 'Manager', 9800, '2019-06-11'),
(10, 'Adel', 'Noor', 'Security', 4100, '2024-01-01');



-- =========================
-- Employee Phone Numbers
-- =========================
INSERT INTO Employee_Phone_Number
(Employee_ID, Employee_Phone_Number)
VALUES
(1, '0000000011'),
(2, '0000000012'),
(3, '0000000013'),
(4, '0000000014'),
(5, '0000000015'),
(6, '0000000016'),
(7, '0000000017'),
(8, '0000000018'),
(9, '0000000019'),
(10, '0000000020');



-- =========================
-- Working Shifts
-- =========================
INSERT INTO Working_Shifts
(Employee_ID, Working_Shifts)
VALUES
(1, '08:00:00'),
(2, '09:00:00'),
(3, '10:00:00'),
(4, '11:00:00'),
(5, '12:00:00'),
(6, '13:00:00'),
(7, '14:00:00'),
(8, '15:00:00'),
(9, '16:00:00'),
(10, '17:00:00');



-- =========================
-- Room
-- =========================
INSERT INTO Room
(Room_ID, Room_Number, Room_Type, Room_Price, Room_Status)
VALUES
(1, 101, 'Single', 200, 'Available'),
(2, 102, 'Double', 350, 'Occupied'),
(3, 103, 'Suite', 700, 'Available'),
(4, 104, 'Single', 220, 'Maintenance'),
(5, 105, 'Double', 370, 'Available'),
(6, 106, 'Suite', 800, 'Occupied'),
(7, 107, 'Single', 250, 'Available'),
(8, 108, 'Double', 390, 'Occupied'),
(9, 109, 'Suite', 900, 'Available'),
(10, 110, 'Single', 210, 'Available');



-- =========================
-- Room Features
-- =========================
INSERT INTO Room_Features
(Room_ID, Room_Features)
VALUES
(1, 'WiFi'),
(2, 'TV'),
(3, 'Jacuzzi'),
(4, 'Mini Bar'),
(5, 'Sea View'),
(6, 'Balcony'),
(7, 'Air Conditioner'),
(8, 'Coffee Machine'),
(9, 'King Bed'),
(10, 'Smart TV');



-- =========================
-- Reservation
-- =========================
INSERT INTO Reservation
(Check_in_date, Check_out_date, Reservation_Status,
Number_of_Guests, Guest_ID, Room_ID, Employee_ID)
VALUES
('2026-05-20', '2026-05-25', 'CONFIRMED', 2, 1, 2, 2),
('2026-05-22', '2026-05-24', 'CANCELED', 1, 2, 1, 2),
('2026-06-01', '2026-06-05', 'CONFIRMED', 3, 3, 3, 1),
('2026-06-02', '2026-06-04', 'REJECTED', 1, 4, 4, 6),
('2026-06-10', '2026-06-15', 'CONFIRMED', 2, 5, 5, 2),
('2026-06-12', '2026-06-18', 'CONFIRMED', 4, 6, 6, 1),
('2026-06-20', '2026-06-25', 'CANCELED', 2, 7, 7, 6),
('2026-06-22', '2026-06-27', 'CONFIRMED', 1, 8, 8, 2),
('2026-07-01', '2026-07-05', 'REJECTED', 2, 9, 9, 1),
('2026-07-10', '2026-07-15', 'CONFIRMED', 3, 10, 10, 6);



-- =========================
-- Payment
-- =========================
INSERT INTO Payment
(Reservation_ID, Payment_Date, Payment_Amount, Payment_Method, Payment_Status)
VALUES
(1, '2026-05-18', 1200, 'Credit Card', 'Success'),
(2, '2026-05-20', 200, 'Cash', 'Declined'),
(3, '2026-05-28', 3500, 'Bank Transfer', 'Processing'),
(4, '2026-06-01', 400, 'Cash', 'Pending'),
(5, '2026-06-08', 1500, 'Credit Card', 'Success'),
(6, '2026-06-09', 4200, 'Bank Transfer', 'Processing'),
(7, '2026-06-15', 1000, 'Cash', 'Declined'),
(8, '2026-06-18', 1800, 'Credit Card', 'Success'),
(9, '2026-06-28', 5000, 'Bank Transfer', 'Pending'),
(10, '2026-07-05', 2500, 'Credit Card', 'Success');



-- =========================
-- Invoice
-- =========================
INSERT INTO Invoice
(Invoice_ID, Reservation_ID, Guest_ID, Invoice_Date,
Total_Amount, Tax_Amount, Discount_Amount,
Invoice_Status, Notes)
VALUES
(1, 1, 1, '2026-05-18', 1200, 180, 50, 'Paid', 'No notes'),
(2, 2, 2, '2026-05-20', 200, 30, 0, 'Canceled', 'Refund pending'),
(3, 3, 3, '2026-05-28', 3500, 525, 100, 'Pending', 'VIP guest'),
(4, 4, 4, '2026-06-01', 400, 60, 20, 'Rejected', 'Invalid booking'),
(5, 5, 5, '2026-06-08', 1500, 225, 50, 'Paid', 'Completed'),
(6, 6, 6, '2026-06-09', 4200, 630, 200, 'Pending', 'Large reservation'),
(7, 7, 7, '2026-06-15', 1000, 150, 0, 'Canceled', 'Canceled by guest'),
(8, 8, 8, '2026-06-18', 1800, 270, 80, 'Paid', 'Special offer'),
(9, 9, 9, '2026-06-28', 5000, 750, 250, 'Rejected', 'Payment issue'),
(10, 10, 10, '2026-07-05', 2500, 375, 100, 'Paid', 'Completed');
-- =========================
-- Service
-- =========================
INSERT INTO Service
(Service_Name, Service_Description, Service_Price)
VALUES
('Laundry Service', 'Cleaning clothes', 80),
('Room Cleaning', 'Daily cleaning', 50),
('Spa Service', 'Massage and spa', 300),
('Breakfast Buffet', 'Morning buffet', 120),
('Airport Pickup', 'Transport service', 200),
('Gym Access', 'Fitness center', 100),
('Swimming Pool', 'Pool access', 90),
('Car Rental', 'Rent a vehicle', 400),
('WiFi Premium', 'High speed internet', 60),
('Dinner Service', 'Luxury dinner', 250);



-- =========================
-- Service Availability Time
-- =========================
INSERT INTO Service_Availability_Time
(Service_ID, Service_Availability_Time)
VALUES
(1, '08:00 AM - 10:00 PM'),
(2, '24 Hours'),
(3, '12:00 PM - 11:00 PM'),
(4, '06:00 AM - 11:00 AM'),
(5, '24 Hours'),
(6, '08:00 AM - 12:00 AM'),
(7, '09:00 AM - 09:00 PM'),
(8, '24 Hours'),
(9, '24 Hours'),
(10, '06:00 PM - 12:00 AM');



-- =========================
-- Guest Requests Service
-- =========================
INSERT INTO Guest_Requests_Service
(Guest_ID, Service_ID)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);



-- =========================
-- Employee Provides Service
-- =========================
INSERT INTO Employee_Provides_Service
(Employee_ID, Service_ID)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);
