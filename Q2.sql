--a. How many orders were shipped by Speedy Express in total?

SELECT COUNT(*) AS NumOrders
FROM Orders
JOIN Shippers 
	ON Orders.ShipperID = Shippers.ShipperId
WHERE Shippers.ShipperName = 'Speedy Express'

ANSWER: 54

--b. What is the last name of the employee with the most orders?

SELECT Employees.LastName
FROM Employees
JOIN Orders 
	ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.LastName
HAVING COUNT(*) = (	SELECT MAX(numberOrders)
					FROM (	SELECT EmployeeID, COUNT(OrderID) AS numberOrders
							FROM Orders
							GROUP BY EmployeeID) maxOrders)

ANSWER: PEACOCK

--c. What product was ordered the most by customers in Germany?
SELECT Products.ProductName
FROM Products
JOIN (
            SELECT ProductID, MAX(Quantity)
            FROM (
                  SELECT ProductID, SUM(Quantity) as Quantity
                  FROM Orders
                  INNER JOIN (--Get German Customers
                    SELECT CustomerID
                    FROM Customers
                    WHERE Country = 'Germany') germanCustomer 
                  ON Orders.CustomerID = germanCustomer.CustomerID
                  JOIN OrderDetails
                  ON OrderDetails.OrderID = Orders.OrderID
                  GROUP BY ProductID )
                  ) germanProduct
ON germanProduct.ProductID = Products.ProductID

ANSWER: Boston Crab Meat