-- Task 1: Populate the Bookings table 
INSERT INTO Bookings (BookingDate, TableNumber, CustomerID)
VALUES 	("2022-10-10", 5, 1),
		("2022-11-12", 3, 3),
		("2022-10-11", 2, 2),
		("2022-10-13", 2, 1);
        
SELECT BookingID, BookingDate, TableNumber, CustomerID
FROM Bookings;


-- Task 2: create a stored procedure called CheckBooking to check whether a table 
-- in the restaurant is already booked
DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER $$
CREATE PROCEDURE CheckBooking (IN asked_date DATE, IN table_number INT)
BEGIN
	SELECT CONCAT("Table ", TableNumber, " is already booked for customer", CustomerID) AS "Booking Status"
    FROM Bookings
    WHERE TableNumber IN (
		SELECT TableNumber
        FROM Bookings
        WHERE BookingDate = asked_date AND TableNumber = table_number
    );
END $$
DELIMITER ;

CALL CheckBooking("2022-10-10", 5);

-- Task 3: create a new procedure called AddValidBooking. This procedure must use 
-- a transaction statement to perform a rollback if a customer reserves a table 
-- that’s already booked under another name.
DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER $$
CREATE PROCEDURE AddValidBooking (IN booking_date DATE, IN table_number INT)
BEGIN
	DECLARE booked INT DEFAULT 0;
    
    SELECT COUNT(BookingID) INTO booked 
    FROM Bookings
    WHERE BookingDate = booking_date AND TableNumber = table_number;
    
	START TRANSACTION;
	INSERT INTO Bookings (BookingDate, TableNumber)
    VALUES (booking_date, table_number);
    
    IF booked > 0 THEN
		SELECT CONCAT("Table ", table_number, " is already booked on - booking cancelled") AS "Booking Status";
        ROLLBACK;
	ELSE
		COMMIT;
	END IF;
END $$
DELIMITER ;

CALL AddValidBooking("2022-12-17", 6);
