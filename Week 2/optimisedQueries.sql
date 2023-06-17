-- Task 1: create a procedure that displays the maximum ordered quantity 
-- in the Orders table. 
DROP PROCEDURE IF EXISTS GetMaxQuantity;
DELIMITER $$
CREATE PROCEDURE GetMaxQuantity()
BEGIN
	SELECT Quantity AS 'Max Quantity in Order'
    FROM Orders
    ORDER BY Quantity DESC
    LIMIT 1;
END $$
DELIMITER ;

CALL GetMaxQuantity();

-- Taks 2: create a prepared statement called GetOrderDetail
PREPARE GetOrderDetail FROM
'SELECT OrderID, Quantity, TotalCost
FROM Orders
WHERE OrderID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;


-- Task 3:  create a stored procedure called CancelOrder
DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER $$
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
	DELETE FROM Orders
    WHERE OrderID = order_id;
    SELECT CONCAT('Order ', order_id, ' is cancelled') AS CONFIRMATION;
END $$
DELIMITER ;

INSERT INTO Orders VALUES (5, '2023-05-20', 10, 55.60, 4, 4);

CALL CancelOrder(5);
