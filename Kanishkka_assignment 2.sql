create table students(
student_id int primary key,
first_name varchar(20),
last_name varchar(20),
date_of_birth date,
email varchar(20),
phone_number int
);
create table teacher(
teacher_id int primary key,
first_name varchar(20),
last_name varchar(20),
email varchar(20)
);
create table courses(
course_id int primary key,
course_name varchar(20),
credits int,
teacher_id int,
foreign key(teacher_id) references teacher(teacher_id)
);
create table enrollments(
enrollment_id int primary key,
student_id int,
course_id int,
enrollment_date date,
foreign key(student_id) references students(student_id),
foreign key(course_id) references courses(course_id)
);
create table payments(
payment_id int primary key,
student_id int,
amount int,
payment_date date,
foreign key(student_id) references students(student_id)
);
-- values inserted to each table through edit top 200 rows
select *from students
select *from courses
select *from teacher
select *from payments
select *from enrollments

TASK 2
--1
insert into students values(44,'john','doe','1995-08-15','john.doe@example.com',1234567890)
select * from students
--2
insert into enrollments (enrollment_id,student_id,course_id,enrollment_date) values(22,1,1,'2-12-2023')
select * from enrollments
--
delete from students where email='john.doe@example.com'
delete from enrollments where enrollment_id=22
--3
update teacher set email='kanishkka@gmail.com' where last_name='eswar'
select * from teacher
--4
delete from enrollments where enrollment_id=101
select* from enrollments
select *from enrollments where student_id=2 and course_id=2
insert into enrollments values(101,1,1,'2024-5-2')
select* from enrollments
--5
update courses set teacher_id=7 where course_id=6
select*from courses
--6 
DELETE FROM Enrollments WHERE student_id = 2;
DELETE FROM Payments WHERE student_id = 2;
DELETE FROM Students WHERE student_id =2;
--7
update payments set amount=2500 where amount=100
select*from payments


TASK 3
--1
SELECT Students.student_id, Students.first_name, SUM(amount) AS total_payments
FROM payments
INNER JOIN students ON Students.student_id = Payments.student_id
WHERE Students.first_name ='harry'
GROUP BY Students.student_id, Students.first_name
--trial
select sum(amount)  from payments inner join students on students.student_id =payments.student_id where first_name='harry'

--2
SELECT course_name, COUNT(student_id) AS enrolled_students
FROM Courses
left join Enrollments ON Courses.course_id = Enrollments.course_id
GROUP BY course_name;

--3
SELECT students.last_name, Students.first_name,Enrollments.student_id
FROM Students
LEFT JOIN Enrollments ON Students.student_id = Enrollments.student_id
WHERE Enrollments.student_id IS NULL;

--4 
select s.first_name,s.last_name,c.course_name 
from Students s join Enrollments e on s.student_id = e.student_id
join Courses c on c.course_id = e.course_id

--5
select teacher.first_name, teacher.last_name, courses.course_name from teacher
inner join courses on courses.teacher_id = teacher.teacher_id

--6
select s.first_name,e.enrollment_date 
from Students s join Enrollments e on s.student_id = e.student_id
where e.course_id = 7


--7
SELECT students.student_id, students.last_name, Students.first_name, payments.amount
FROM Students
LEFT JOIN payments ON Students.student_id = payments.student_id
WHERE payments.amount IS NULL;

--8  
select courses.course_name,enrollments.enrollment_id
from courses
left join enrollments on courses.course_id = enrollments.course_id
where student_id is null

--9
select student_id from enrollments group by student_id having count(course_id)>1
--another way
SELECT DISTINCT e1.student_id
FROM Enrollments e1
JOIN Enrollments e2 ON e1.student_id = e2.student_id
WHERE e1.course_id <> e2.course_id

--10
select teacher.first_name, teacher.last_name,courses.course_name
from teacher
left join courses on courses.teacher_id = teacher.teacher_id
where course_name is null

TASK 4
--1
SELECT 
    course_id, 
    AVG(num_students) AS average_students
FROM 
    (SELECT 
        course_id, 
        COUNT(student_id) AS num_students
    FROM 
        enrollments
    GROUP BY 
        course_id) AS course_enrollment
GROUP BY 
    course_id;

--2
select student_id from payments
where amount = (select max(amount) as totalamount from payments)

--3
select enrollment_id from enrollments
where course_id = (select max(course_id) from enrollments)
--4 
SELECT 
    t.teacher_id,
    t.first_name,
    (
        SELECT SUM(amount)
        FROM Payments
        WHERE Courses.teacher_id = t.teacher_id
 
    ) AS total_payments
FROM 
    Teacher t, Courses;
--5
SELECT student_id
FROM enrollments
WHERE course_id IN (SELECT course_id FROM courses)
GROUP BY student_id
HAVING COUNT(course_id) = (SELECT COUNT(*) FROM courses);
--6
select first_name,last_name from teacher
where teacher_id NOT IN(select distinct teacher_id 
from courses);
--7 
SELECT AVG(age) AS average_age
FROM (
    SELECT DATADIFF(YEAR, date_of_birth, CURRENT_TIMESTAMP) AS age
    FROM students
) AS student_ages;
--8
SELECT course_id, course_name
FROM Courses WHERE course_id NOT IN (
    SELECT DISTINCT course_id
    FROM Enrollments
);
--9
SELECT student_id, course_id,
    (
	SELECT SUM(amount)
	FROM Payments
	WHERE student_id = e.student_id
	AND course_id = e.course_id
    ) AS total_payments
FROM Enrollments e;
--10
SELECT student_id
FROM (
    SELECT student_id, COUNT(*) AS payment_count
    FROM Payments
    GROUP BY student_id
) AS payment_counts
WHERE payment_count > 1;
--11
SELECT s.student_id, s.first_name, s.last_name, SUM(p.amount) AS total_payments
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;

SELECT student_id, first_name, last_name, 
    (SELECT SUM(amount) FROM Payments WHERE student_id = s.student_id) AS total_payments
FROM Students s;
--12
SELECT c.course_name,
    (SELECT COUNT(*)
	FROM Enrollments e
	WHERE e.course_id = c.course_id
    ) AS enrollment_count
FROM Courses c;
--13
SELECT (SELECT AVG(amount) FROM Payments) AS average_payment_amount;


