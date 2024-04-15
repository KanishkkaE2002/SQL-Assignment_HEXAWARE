

-- Venue Table
CREATE TABLE Venue (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);
-- Event Table
CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(20),
    event_date DATE,
    event_time TIME,
    venue_id INT,
    total_seats INT,
    available_seats INT ,
    ticket_price DECIMAL(10, 2) ,
    event_type varchar(20) ,
    booking_id INT
);

-- Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(20),
    email VARCHAR(20),
    phone_number VARCHAR(20) ,
    booking_id INT
);

-- Booking Table
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT NOT NULL,
    total_cost INT NOT NULL,
    booking_date DATE
);
drop table venue 
drop table customer
drop table  booking
drop table event 
-- foreign keys

ALTER TABLE Event ADD FOREIGN KEY (venue_id) REFERENCES Venue(venue_id);

ALTER TABLE Event ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

ALTER TABLE Customer ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

ALTER TABLE Booking ADD FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);

ALTER TABLE Booking ADD FOREIGN KEY (event_id) REFERENCES Event(event_id);

-- Inserting records into the Venue table

INSERT INTO Venue (venue_id, venue_name, address) VALUES
(1, 'Venue-1', 'chennai'),
(2, 'Venue-2', 'ooty'),
(3, 'Venue-3', 'madurai'),
(4, 'Venue-4', 'salem'),
(5, 'Venue-5', 'coimbatore'),
(6, 'Venue-6', 'theni'),
(7, 'Venue-7', 'namakkal'),
(8, 'Venue-8', 'erode'),
(9, 'Venue-9', 'karur'),
(10, 'Venu-10', 'cuddalore');

-- Inserting sample records into the Event table
INSERT INTO Event (event_id, event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type, booking_id) VALUES
(1, 'Event a', '2024-04-1', '09:00:00', 1, 200, 20, 1500, 'Concert', NULL),
(2, 'Event b', '2024-04-2', '11:00:00', 2, 200, 100, 2000, 'Movie', NULL),
(3, 'Event c', '2024-04-2', '15:00:00', 3, 350, 300, 1800, 'Sports', NULL),
(4, 'Event d', '2024-04-3', '12:00:00', 4, 250, 150, 2200, 'Concert', NULL),
(5, 'Event e', '2024-04-4', '23:00:00', 5, 100, 50, 1200, 'Movie', NULL),
(6, 'Event f', '2024-04-5', '14:00:00', 6, 350, 30, 1600, 'Concert', NULL),
(7, 'Event g', '2024-04-6', '20:00:00', 7, 450, 100, 2500, 'Movie', NULL),
(8, 'Event h', '2024-04-7', '18:00:00', 8, 400, 200, 1700, 'Concert', NULL),
(9, 'Event i', '2024-04-8', '21:00:00', 9, 250, 50, 1900, 'Sports', NULL),
(10, 'Event j', '2024-04-9', '16:00:00', 10, 350, 40, 2100, 'Concert', NULL);

-- Inserting sample records into the Customer table
INSERT INTO Customer (customer_id, customer_name, email, phone_number, booking_id) VALUES
(1, 'kani', 'kani@gmail.com', '1234', NULL),
(2, 'dhari', 'dhari@gmail.com', '9876', NULL),
(3, 'raj', 'raj@gmail.com', '4523', NULL),
(4, 'nithish', 'nithi@gmail.com', '3870', NULL),
(5, 'varsha', 'varsha@gmail.com', '90123', NULL),
(6, 'srimalar', 'malar@gmail.com', '6510', NULL),
(7, 'shami', 'shami@gmail.com', '1472', NULL),
(8, 'meena', 'meena@gmail.com', '2580', NULL),
(9, 'narmadha', 'narmu@gmail.com', '1470', NULL),
(10, 'pooja', 'pooja@gmail.com', '2583', NULL);

-- Inserting sample records into the Booking table
INSERT INTO Booking (booking_id, customer_id, event_id, num_tickets, total_cost, booking_date) VALUES
(1, 1, 1, 2, 300, '2024-04-03'),
(2, 2, 2, 3, 600, '2024-04-02'),
(3, 3, 3, 1, 180, '2024-04-01'),
(4, 4, 4, 4, 880, '2024-04-05'),
(5, 5, 5, 2, 240, '2024-04-02'),
(6, 6, 6, 3, 400, '2024-04-06'),
(7, 7, 7, 1, 250, '2024-04-03'),
(8, 8, 8, 2, 340, '2024-04-06'),
(9, 9, 9, 4, 760, '2024-04-02'),
(10, 10, 10, 3, 600,'2024-04-01');

TASK 2
--2
SELECT * FROM Event
--3
SELECT * FROM Event WHERE available_seats > 0
--4
SELECT * FROM Event WHERE event_name LIKE '%cup%'
--5
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500
--6
SELECT * FROM Event WHERE event_date BETWEEN '2024-04-10' AND '2024-04-15'
--7
SELECT * FROM Event WHERE available_seats > 0 AND event_name LIKE '%Concert%';
SELECT * FROM Event WHERE available_seats > 0 AND event_type = 'Concert';
--8
SELECT * FROM customer order by customer_id offset 5 rows fetch next 5 rows only
--9
SELECT * FROM Booking WHERE num_tickets > 4
--10
SELECT * FROM Customer WHERE phone_number LIKE '%000'
--11
SELECT * FROM Event WHERE total_seats > 15000
--12
SELECT * FROM Event WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%'; 

TASK 3
--1
SELECT event_id, event_name, AVG(ticket_price) AS avg_ticket_price FROM Event GROUP BY event_id, event_name;
--2
SELECT SUM(total_cost) AS total_revenue FROM Booking;
--3
SELECT event_id, SUM(num_tickets) AS total_tickets_sold, SUM(total_cost) AS total_revenue FROM Booking GROUP BY event_id
ORDER BY total_tickets_sold DESC, total_revenue DESC
--4
SELECT event_id, SUM(num_tickets) AS total_tickets_sold FROM Booking GROUP BY event_id;
--5
SELECT event_id, event_name FROM Event WHERE event_id NOT IN (SELECT event_id FROM Booking);
--6
SELECT customer_id, SUM(num_tickets) AS total_tickets_booked
FROM Booking
GROUP BY customer_id
HAVING SUM(num_tickets) = (
    SELECT MAX(total_tickets)
    FROM (
        SELECT SUM(num_tickets) AS total_tickets
        FROM Booking
        GROUP BY customer_id
    ) AS subquery
);
--7
SELECT event_id,MONTH(booking_date) AS month, COUNT(*) AS total_tickets_sold FROM Booking GROUP BY event_id,MONTH(booking_date);
--8
SELECT venue_id, AVG(ticket_price) AS avg_ticket_price FROM Event GROUP BY venue_id;
--9
SELECT event_type, SUM(num_tickets) AS total_tickets_sold
FROM Event
JOIN Booking ON Event.event_id = Booking.event_id
GROUP BY event_type;
--10
SELECT YEAR(event_date) AS event_year, SUM(ticket_price * num_tickets) AS total_revenue
FROM event
INNER JOIN booking ON event.event_id = booking.event_id
GROUP BY YEAR(event_date);

--11
SELECT customer_id
FROM Booking
GROUP BY customer_id
HAVING COUNT(DISTINCT event_id) > 1;

--12
SELECT customer_id, SUM(total_cost) AS total_revenue_generated
FROM Booking
GROUP BY customer_id;

--13
SELECT event_type, venue_id, AVG(ticket_price) AS avg_ticket_price
FROM Event
GROUP BY event_type, venue_id;

--14
SELECT customer_id, COUNT(*) AS total_tickets_purchased_last_30_days
FROM Booking
WHERE booking_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY customer_id;

TASK 4
--1
SELECT v.venue_id, v.venue_name, 
       (SELECT AVG(ticket_price) 
        FROM Event 
        WHERE venue_id = v.venue_id) AS avg_ticket_price
FROM Venue v;

--2
SELECT event_id, event_name
FROM Event
WHERE (SELECT SUM(num_tickets) 
       FROM Booking 
       WHERE Booking.event_id = Event.event_id) > (total_seats / 2);

--3
SELECT event_id, event_name,
       (SELECT SUM(num_tickets) 
        FROM Booking 
        WHERE Booking.event_id = Event.event_id) AS total_tickets_sold
FROM Event;

--4
SELECT customer_id, customer_name
FROM Customer c
WHERE NOT EXISTS (
    SELECT * 
    FROM Booking 
    WHERE Booking.customer_id = c.customer_id
);

--5
SELECT event_id, event_name
FROM Event
WHERE event_id NOT IN (
    SELECT event_id 
    FROM Booking
);

--6
SELECT event_type, SUM(total_tickets_sold) AS total_tickets_sold
FROM (
    SELECT event_id, event_type,
           (SELECT SUM(num_tickets) 
            FROM Booking 
            WHERE Booking.event_id = Event.event_id) AS total_tickets_sold
    FROM Event
) AS subquery
GROUP BY event_type;

--7
SELECT event_id, event_name, ticket_price
FROM Event
WHERE ticket_price > (
    SELECT AVG(ticket_price) 
    FROM Event
);

--8
SELECT customer_id, customer_name,
       (SELECT SUM(total_cost) 
        FROM Booking 
        WHERE Booking.customer_id = Customer.customer_id) AS total_revenue_generated
FROM Customer;

--9
SELECT customer_id, customer_name
FROM Customer
WHERE customer_id IN (
    SELECT DISTINCT customer_id 
    FROM Booking 
    WHERE event_id IN (
        SELECT event_id 
        FROM Event 
        WHERE venue_id = 'given_venue_id'
    )
);

--10
SELECT event_type, SUM(total_tickets_sold) AS total_tickets_sold
FROM (
    SELECT event_id, event_type,
           (SELECT SUM(num_tickets) 
            FROM Booking 
            WHERE Booking.event_id = Event.event_id) AS total_tickets_sold
    FROM Event
) AS subquery
GROUP BY event_type;

--11
SELECT booking_id
FROM booking
GROUP BY booking_id
HAVING COUNT(DISTINCT event_id) > 1;

--12
SELECT venue_id, venue_name,
       (SELECT AVG(ticket_price) 
        FROM Event 
        WHERE Event.venue_id = Venue.venue_id) AS avg_ticket_price
FROM Venue;