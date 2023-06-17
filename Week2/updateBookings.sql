-- Task:  create a new procedure called AddBooking to add a new 
-- table booking record.
DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER $$
CREATE PROCEDURE AddBooking (
	IN booking_id INT,
    IN booking_date DATE,
	IN table_number INT,
    IN customer_id INT
)
BEGIN
	INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID)
    VALUES (booking_id, booking_date, table_number, customer_id);
    SELECT 'New booking added' AS 'Confirmation';
END $$
DELIMITER ;

CALL AddBooking(15, '2022-12-30', 3, 4);


-- Task 2:  create a new procedure called UpdateBooking that they can use 
-- to update existing bookings in the booking table.
DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER $$
CREATE PROCEDURE UpdateBooking(IN id_booking INT, IN date_booking DATE)
BEGIN
	UPDATE Bookings
    SET BookingDate = date_booking
    WHERE BookingID = id_booking;
    SELECT CONCAT('Booking ', id_booking, ' updated') AS 'Confirmation';
END $$
DELIMITER ;

CALL UpdateBooking(3, '2023-01-05');

-- Task 3: create a new procedure called CancelBooking that they can use 
-- to cancel or remove a booking.
DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER $$
CREATE PROCEDURE CancelBooking(IN id_booking INT)
BEGIN
	DELETE FROM Bookings WHERE BookingID = id_booking;
    SELECT CONCAT('Booking ', id_booking, ' cancelled') AS 'Confirmation';
END $$

CALL CancelBooking(15);


DELIMITER ;
