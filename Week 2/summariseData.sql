-- Task 1: Create OrdersView
CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost AS Cost
FROM Orders
WHERE Quantity > 2;

SELECT * FROM OrdersView;

-- Task 2: Using a JOIN clause
SELECT c.CustomerID AS CustomerID,  c.CustomerName as FullName, o.OrderID as OrderID, o.TotalCost AS Cost, m.MenuName AS MenuName, co.CourseName
FROM Customers as c
INNER JOIN Orders as o ON o.CustomerID = c.CustomerID
INNER JOIN Menus as m ON m.MenuID = o.MenuID
INNER JOIN Courses as co ON co.MenuID = m.MenuID
WHERE TotalCost > 150
ORDER BY TotalCost ASC;

-- Task 3: Using ANY
SELECT MenuName
FROM menus
WHERE MenuID = ANY (
	SELECT MenuID
    FROM Orders
    WHERE Quantity > 2 
)
