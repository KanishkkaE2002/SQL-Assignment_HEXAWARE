create table Users(
UserID INT PRIMARY KEY, 
Name VARCHAR(255), 
Email VARCHAR(255) UNIQUE, 
Password VARCHAR(255), 
ContactNumber VARCHAR(20), 
Address TEXT 
); 
create table Couriers(
CourierID INT PRIMARY KEY, 
SenderName VARCHAR(255), 
SenderAddress TEXT, 
ReceiverName VARCHAR(255), 
ReceiverAddress TEXT, 
Weight DECIMAL(5, 2), 
Status VARCHAR(50), 
TrackingNumber VARCHAR(20) UNIQUE, 
DeliveryDate DATE
); 
create table CourierServices (
ServiceID INT PRIMARY KEY, 
ServiceName VARCHAR(100), 
Cost DECIMAL(8, 2)
); 
create table Employees(
EmployeeID INT PRIMARY KEY, 
Name VARCHAR(255), 
Email VARCHAR(255) UNIQUE, 
ContactNumber VARCHAR(20), 
Role VARCHAR(50), 
Salary DECIMAL(10, 2)
); 
create table Locations(
LocationID INT PRIMARY KEY, 
LocationName VARCHAR(100), 
Address TEXT
); 
create table Payments(
PaymentID INT PRIMARY KEY, 
CourierID INT, 
LocationId INT, 
Amount DECIMAL(10, 2), 
PaymentDate DATE, 
FOREIGN KEY (CourierID) REFERENCES Couriers(CourierID), 
FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);
--values inserted to each table through edit top 200 rows
TASK 2
--1
select *from users
--2
SELECT *FROM Couriers
WHERE SenderName = 'shami'
--3
select*from couriers
--4
SELECT *FROM Couriers WHERE sendername='jaya'
--5
SELECT *FROM Couriers WHERE CourierID = 101;
--6
SELECT *FROM Couriers WHERE status<>'undelivered';
--7
SELECT * FROM Couriers WHERE deliverydate = CURDATE();
--8
SELECT *FROM couriers where status ='delayed'
--9
SELECT courierid, COUNT(*) AS TOTALPACKAGES
FROM couriers GROUP BY courierid
--10
SELECT c.courierid, AVG(datediff(day,c.deliverydate,p.paymentdate))
AS AVGTIME from payments p INNER JOIN Couriers c 
ON c.courierid =p.courierid
GROUP BY courierid
--11
SELECT *FROM Couriers WHERE weight BETWEEN 10 AND 20
--12
SELECT *FROM employees WHERE name ='john'
--13 instead of 50 I will give retrieve records with payment greater thaan 500
SELECT couriers.* FROM couriers JOIN payments 
ON couriers.courierid = payments.courierid WHERE payments.amount >500

TASK 3
--14
SELECT e.employeeid, COUNT(c.courierid) AS TOTAL_NO_OF_COURIERS
FROM employees e LEFT JOIN couriers c 
ON e.employeeid = c.courierid
GROUP BY e.employeeid
--15
SELECT locationid, sum(amount) as TOTAL FROM payments 
GROUP BY locationid
--16
SELECT locationid, count(courierid) FROM payments 
GROUP BY locationid
--17
SELECT p.courierid, AVG(datediff(c.deliverydate,p.paymentdate)) AS AVG_DELIVERY_DATE
FROM payments p INNER JOIN couriers c 
ON c.courierid =p.courieridGROUP BY courierid
ORDER BY AVG_DELIVERY_DATE desc limit 1
--18
SELECT locationId, sum(amount)AS TOTAL_AMOUNT from payments 
GROUP BY locationid HAVING TOTAL_AMOUNT > 20
--19
SELECT locationid, sum(amount) AS TOTAL FROM payments 
GROUP BY locationid
--20
SELECT courierid FROM payments WHERE locationid=33
GROUP BY courierid HAVING sum(amount) > 30
--21
SELECT courierid FROM payments where paymentdate='2024-04-14'
GROUP BY courierid HAVING SUM(amount)>1000
--22
SELECT courierid FROM payments where paymentdate='2024-04-14'
GROUP BY courierid HAVING SUM(amount)>5000

TASK 4
--23
SELECT payments.*, couriers.* 
FROM payments JOIN couriers 
ON payments.courierid=couriers.courierid
--24
SELECT payments.*, locations.* 
FROM payments JOIN locations
ON payments.locationid=locations.locationid
--25
SELECT payments.*, couriers.*, locations.* 
FROM payments JOIN couriers 
ON payments.courierid=couriers.courierid
JOIN locations ON payments.locationid=locations.locationid
--26
SELECT * FROM payments p LEFT JOIN couriers c 
ON p.courierid=c.courierid
--27
SELECT courierid, SUM(amount) AS TOTAL_PAYMENT FROM payments 
GROUP BY courierid
--28
SELECT * FROM payments WHERE paymentdate='2024-04-13'
--29
SELECT *FROM couriers c WHERE c.courierID IN (SELECT courierid FROM payments)
--30
SELECT payments.*, locations.* 
FROM payments LEFT JOIN locations
ON payments.locationid=locations.locationid
--31
SELECT courierid ,sum(amount) as TOTAL FROM payments 
GROUP BY courierid
--32
SELECT *FROM payments WHERE paymentdate BETWEEN '2024-04-14' AND '2024-04-12'

--33
SELECT * FROM users CROSS JOIN courierservices
SELECT u.*, courierid,c.status,c.courierid,c.trackingnumber, c.deliverydate
FROM users u LEFT JOIN couriers c ON
u.name =c.sendername;
--34
SELECT * FROM employees CROSS JOIN courierservices
--35
SELECT * FROM employees CROSS JOIN payments
--36
SELECT * FROM users CROSS JOIN courierservices
--37
SELECT * FROM employees CROSS JOIN locations
--38
SELECT *FROM couriers LEFT JOIN users 
ON couriers.sendername='jaya'
--39
SELECT *FROM couriers LEFT JOIN users 
ON couriers.sendername='rohita'
--43
SELECT * FROM couriers WHERE sendername IN (SELECT sendername FROM couriers 
GROUP BY sendername HAVING count(*)>1)
--44
SELECT e1.*,e2.* FROM employees e1, employees e2 WHERE e1.role=e2.role
AND e1.employeeid<> e2.employeeid 
--45
SELECT * FROM payments p1 INNER JOIN payments p2 ON
p1.locationid=p2.locationid AND p1.paymentid <>p2.paymentid
--46
SELECT * FROM couriers c1 INNER JOIN couriers c2 
ON c1.senderaddress == c2.senderaddress and c1.courierid<>c2.courierid
--49
SELECT * FROM couriers WHERE weight >(SELECT AVG(weight) FROM couriers)
--50
SELECT name FROM employees WHERE salary>(SELECT AVG(salary) FROM Employees)
--51
SELECT SUM(cost) FROM courierservices WHERE cost <(SELECT MAX(cost) FROM courierservices)
--52
SELECT * FROM couriers c1 WHERE weight > all
(SELECT weight FROM couriers c2 WHERE c2.sendername='durai')
SELECT * FROM couriers where sendername='durai'
--53
SELECT locationid FROM payments 
WHERE amount=(SELECT MAX(amount) FROM payments)
--54
SELECT * FROM couriers c1 WHERE weight > ALL
(SELECT weight FROM couriers c2 WHERE c2.sendername='eswar')