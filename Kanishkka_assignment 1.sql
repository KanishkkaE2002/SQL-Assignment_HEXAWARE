CREATE TABLE CUSTOMERS(
CUSTOMERID INT PRIMARY KEY,
FIRSTNAME VARCHAR(10),
LASTNAME VARCHAR(10),
EMAIL VARCHAR(20),
PHONENO INT,
ADDRESS VARCHAR(20)
);
CREATE TABLE PRODUCTS(
PRODUCTID INT PRIMARY KEY,
PRODUCTNAME VARCHAR(10),
DESCRIPTION VARCHAR(10),
PRICE INT
);
CREATE TABLE ORDERS(
ORDERID INT PRIMARY KEY,
CUSTOMERID INT,
ORDERDATE DATE,
TOTALAMOUNT INT,
FOREIGN KEY(CUSTOMERID) REFERENCES CUSTOMERS(CUSTOMERID)
);
CREATE TABLE ORDERDETAILS(
ORDERDETAILID INT PRIMARY KEY,
ORDERID INT,
PRODUCTID INT,
QUANTITY INT,
FOREIGN KEY(ORDERID) REFERENCES ORDERS(ORDERID),
FOREIGN KEY(PRODUCTID) REFERENCES PRODUCTS(PRODUCTID)
);
CREATE TABLE INVENTORY(
INVENTORYID INT PRIMARY KEY,
PRODUCTID INT,
QUANTITYINSTOCK INT,
LASTSTOCKUPDATE DATE,
FOREIGN KEY(PRODUCTID) REFERENCES PRODUCTS(PRODUCTID)
);

-- values inserted to each table through edit top 200 rows
SELECT *FROM CUSTOMERS
SELECT *FROM PRODUCTS
SELECT *FROM ORDERS
SELECT *FROM ORDERDETAILS
SELECT *FROM INVENTORY

TASK2
--1
SELECT FIRSTNAME,LASTNAME,EMAIL FROM CUSTOMERS
--2
SELECT ORDERDATE,FIRSTNAME,LASTNAME
FROM ORDERS INNER JOIN CUSTOMERS
ON ORDERS.CUSTOMERID = CUSTOMERS.CUSTOMERID
--3
INSERT INTO CUSTOMERS OUTPUT INSERTED.FIRSTNAME, INSERTED.LASTNAME, INSERTED.EMAIL, INSERTED.ADDRESS VALUES (54,'RUBA', 'SRI','RUBA@GMAIL',5432,'ZZ');
--4
UPDATE PRODUCTS SET PRICE=PRICE*1.1
--5
DECLARE @ToDelete INT;
SET @ToDelete = 106;
DELETE FROM OrderDetails
WHERE OrderID = @ToDelete;
DELETE FROM Orders
WHERE OrderID = @ToDelete;
select*from orders
--6
INSERT INTO ORDERS VALUES(2,1,'2024-03-02',750)
--7
select* from customers
DECLARE @IDToUpdate INT;
DECLARE @NewEmail VARCHAR(255);
DECLARE @NewAddress VARCHAR(255);

SET @IDToUpdate = 10;
SET @NewEmail = 'meena@gamil';
SET @NewAddress = 'chennai';
select*from customers
--8
UPDATE ORDERS SET TOTALAMOUNT=(SELECT SUM(ORDERDETAILS.QUANTITY * PRODUCTS.PRICE) FROM ORDERDETAILS,PRODUCTS WHERE ORDERDETAILS.PRODUCTID=PRODUCTS.PRODUCTID
AND ORDERDETAILS.ORDERID = ORDERS.ORDERID
--9
DECLARE @IDToDelete INT;
SET @IDToDelete = 9;
DELETE FROM OrderDetails
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @IDToDelete);
DELETE FROM Orders
WHERE CustomerID = @IDToDelete;
--10
ALTER TABLE PRODUCTS ADD CATEGORY VARCHAR(20)
SELECT*FROM PRODUCTS
--11
alter table orders 
add status varchar(20);
--added new cloumn

DECLARE @OrderID INT; 
DECLARE @NewStatus NVARCHAR(50); 
SET @OrderID = 111;
SET @NewStatus = 'shipped';
UPDATE Orders
SET status = 'shipped'
WHERE OrderID =2;
select*from orders
--12
SELECT COUNT(CUSTOMERID) FROM ORDERS 

TASK3
--1
SELECT OrderID, OrderDate, FirstName,LastName 
FROM 
    Orders
INNER JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID;

--2
SELECT ProductName, SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM 
    OrderDetails, Products
WHERE 
    OrderDetails.ProductID = Products.ProductID
GROUP BY 
    Products.ProductName;

--3
SELECT FIRSTNAME,LASTNAME,EMAIL,PHONENO FROM CUSTOMERS WHERE CUSTOMERID IN (SELECT DISTINCT CUSTOMERID FROM ORDERS)

--4
SELECT p.ProductName,SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od INNER JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName ORDER BY TotalQuantityOrdered DESC

--5
SELECT p.ProductName, o.OrderDetailid
FROM Products p
JOIN OrderDetails o ON p.productid = o.productid
WHERE p.productname = 'phone';


--6
SELECT c.FirstName, c.LastName, AVG(o.TotalAmount) AS AverageOrderValue
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;
--7
SELECT o.OrderID, c.FirstName, c.LastName, o.TotalAmount AS TotalRevenue
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY o.TotalAmount DESC
--8
SELECT p.ProductName, COUNT(od.OrderID) AS NumberOfOrders
FROM Products p LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

TASK 4
--1
SELECT CustomerID, FirstName
FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Orders
);
--2
SELECT COUNT(*) AS total_products
FROM Products
WHERE ProductID IN (
    SELECT DISTINCT ProductID
    FROM Inventory
    WHERE QuantityInStock > 0
);

--3
SELECT SUM(total_price) AS total_revenue
FROM (
    SELECT SUM(Quantity * Price) AS total_price
    FROM Orders, OrderDetails , Products
    WHERE Orders.CustomerID IN (
        SELECT CustomerID
        FROM Customers
    )
) AS revenue_summary;

--5
DECLARE @CustomerID INT = 600 
SELECT SUM(total_price) AS total_revenue
FROM (
    SELECT SUM(Quantity * Price) AS total_price
    FROM Orders , Products, OrderDetails
  --  JOIN Products ON orders.productID = products.product_id
    WHERE orders.CustomerID = @CustomerID
) AS revenue_summary;

--6
SELECT FirstName, LastName, NumOrdersPlaced
FROM ( SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS NumOrdersPlaced
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.FirstName, c.LastName
) AS CustomerOrders
ORDER BY NumOrdersPlaced DESC
--7 
SELECT cname AS MostPopularCategory, TotalQuantityOrdered
FROM (
    SELECT c.first_name, SUM(od.Quantity) AS TotalQuantityOrdered
    FROM Category c
    JOIN Products p ON c.cid = p.cid
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY c.cname
) AS CategoryTotalQuantities
ORDER BY TotalQuantityOrdered DESC
--8
SELECT c.FirstName, c.LastName, TotalSpending
FROM Customers c
JOIN (
    SELECT o.CustomerID, SUM(od.Quantity * p.Price) AS TotalSpending
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Category cat ON p.cid = cat.cid
    WHERE cat.cname = 'Electronics'
    GROUP BY o.CustomerID
) AS CustomerSpending ON c.CustomerID = CustomerSpending.CustomerID
ORDER BY TotalSpending DESC


--9
SELECT AVG(order_value) AS average_order_value
FROM (
    SELECT o.OrderID, SUM(p.Price * oi.quantity) AS order_value
    FROM Orders o , OrderDetails oi
    JOIN Products p ON oi.ProductID = p.ProductID
    GROUP BY o.OrderID
) AS order_values;

--10
SELECT 
    customers.FirstName,
    (
        SELECT COUNT(*)
        FROM Orders o
        WHERE o.CustomerID = customers.CustomerID
    ) AS order_count
FROM 
    customers;
