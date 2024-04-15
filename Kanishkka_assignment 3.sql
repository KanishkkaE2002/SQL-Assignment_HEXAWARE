create table customers(
customer_id int primary key,
first_name varchar(20),
last_name varchar(20),
dob date,
email varchar(20),
phone_number int,
address varchar(20)
);
create table accounts(
account_id int primary key,
customer_id int,
account_type varchar(20),
balance int,
foreign key(customer_id) references customers(customer_id)
);

create table transactions(
transaction_id int primary key,
account_id int,
transaction_type varchar(20),
amount int,
transaction_date date,
foreign key(account_id) references accounts(account_id)
);
--values inserted by edit top 200 rows
select * from customers
select * from accounts
select * from transactions

TASK 1
--1
select * from customers
--2
select * from transactions
--3
update accounts set balance = balance +1000 where account_id=14
--4
select concat(first_name,' ',last_name) AS full_name from customers
--5
delete from accounts where balance =0 and account_type='savings'
--6
select *from customers where address='ccc'
--7
select balance from accounts where account_id=21
--8
select* from accounts where account_type='current' and balance>1000
--9
select *from accounts a join transactions t on a.account_id=t.account_id
where a.account_id=11
--10
select account_id, balance *2 AS interest from accounts
select *from accounts
--11
select account_id,balance from accounts where balance <10000
--12
select * from customers where address<> 'ddd'

TASK3
--1
select avg(balance) from accounts 
--2
select top 10 account_id,balance from accounts order by balance desc
--3
select transaction_id,amount,transaction_date from transactions where transaction_date='2024-01-11'
--4
select top 1 *from customers
ORDER BY dob
select top 1 *from customers
ORDER BY dob desc
--5
select t.transaction_id, t.account_id, a.account_type,t.amount from transactions t join accounts a 
on a.account_id=t.account_id
--6
select c.customer_id,c.first_name,c.last_name,a.account_type from customers c join accounts a 
on a.customer_id=c.customer_id
--7
select t.transaction_id,t.transaction_date,t.amount,c.customer_id,c.first_name,c.last_name,t.account_id
from transactions t join accounts a 
on t.account_id=a.account_id
join customers c on a.customer_id=c.customer_id
where t.account_id= 11
--8
select customer_id, count(account_id) AS number_of_accounts
from accounts group by customer_id having count(account_id)>1
--9
 SELECT 
    (SELECT SUM(Amount) FROM Transactions WHERE transaction_type = 'Deposit') - 
    (SELECT SUM(Amount) FROM Transactions WHERE transaction_type = 'Withdrawal') AS Difference;
--10
SELECT account_id, AVG(balance) AS average_daily_balance
FROM Accounts
GROUP BY account_id;
--11
select account_type, sum(balance) AS total from accounts 
group by account_type
--12
select account_id, count(*) AS transaction_count
from transactions
group by account_id 
order by transaction_count desc
--13
SELECT c.customer_id, a.account_type, SUM(a.balance)
FROM Customers c , Accounts a
GROUP BY c.customer_id, a.account_type
HAVING SUM(a.balance) > 10000;
--14
SELECT transaction_id, transaction_type, amount, transaction_date, account_id, COUNT(*) 
FROM Transactions
GROUP BY transaction_type, amount, transaction_date, account_id,transaction_id
HAVING COUNT(*)> 1;


TASK 4
--1
select *from accounts
where balance=(select max(balance) from accounts)
--2 wrong
select *from accounts
where balance =(select avg(balance) from accounts)
having count(customer_id)>1

SELECT AVG(balance) AS average_balance
FROM (
    SELECT customer_id, COUNT(*) AS NEWNAMES
    FROM accounts
    GROUP BY customer_id
    HAVING NEWNAMES > 1
) AS multi_account_customers
JOIN accounts ON multi_account_customers.customer_id = accounts.customer_id;
--3
select account_id,amount from transactions 
where amount>(select avg(amount) from transactions)
--4 
select customer_id,first_name from customers 
where customer_id not in (select customer_id from transactions)
--5
SELECT SUM(balance) AS total_balance
FROM accounts
WHERE account_id NOT IN (SELECT DISTINCT account_id FROM transactions);
--6
SELECT *
FROM transactions
WHERE account_id IN (
    SELECT account_id
    FROM accounts
    WHERE balance = (
        SELECT MIN(balance)
        FROM accounts
    )
);
--7
SELECT customer_id
FROM Accounts
GROUP BY customer_id
HAVING COUNT(DISTINCT account_type) > 1

--8
SELECT account_type, cOUNT(*) AS num_accounts,
    (COUNT() * 100.0 / (SELECT COUNT() FROM Accounts)) AS percentage
FROM Accounts GROUP BY account_type
--9
SELECT * FROM Transactions
WHERE account_id IN (
    SELECT account_id FROM Accounts WHERE customer_id = 8)
--10
SELECT account_type,
    (SELECT SUM(balance) FROM Accounts 
	WHERE account_type = A.account_type) AS total_balance
FROM Accounts AS A
GROUP BY account_type


