use assignments;
show tables;

-- Joins Excersises

CREATE TABLE Students (student_id INT PRIMARY KEY, name VARCHAR(100), age INT);
CREATE TABLE Courses (course_id INT PRIMARY KEY, course_name VARCHAR(100));
CREATE TABLE Enrollments (enrollment_id INT PRIMARY KEY, student_id INT, course_id INT);
 
INSERT INTO Students VALUES
(1, 'Arjun', 20), (2, 'Bhavana', 21), (3, 'Charan', 22), (4, 'Divya', 20),
(5, 'Eswar', 23), (6, 'Farhan', 21), (7, 'Gowri', 22);
 
INSERT INTO Courses VALUES
(101, 'Mathematics'), (102, 'Physics'), (103, 'Biology'),
(104, 'Chemistry'), (105, 'Computer Science');
 
INSERT INTO Enrollments VALUES
(1, 1, 101), (2, 2, 101), (3, 2, 102), (4, 3, 103),
(5, 4, 101), (6, 5, 104), (7, 1, 102), (8, 6, 105);

-- 1. List all students with the courses they are enrolled in.
select s.name, c.course_name from students s left join enrollments e
on s.student_id=e.student_id left join courses c on e.course_id=c.course_id;

-- 2. Show course names along with student names.
select s.name, c.course_name from students s inner join enrollments e
on s.student_id=e.student_id inner join courses c on e.course_id=c.course_id;

-- 3. Get names of students enrolled in "Physics".
select s.name,c.course_name from students s inner join enrollments e on s.student_id=e.student_id
inner join courses c on e.course_id=c.course_id where course_name='Physics';

-- 4. List all students with their courses, if enrolled.
select s.name, c.course_name from students s left join enrollments e
on s.student_id=e.student_id left join courses c on e.course_id=c.course_id;

-- 5. Show all courses and the students who enrolled, even if none.
select s.name, c.course_name from students s right join enrollments e
on s.student_id=e.student_id right join courses c on e.course_id=c.course_id;

-- 6. Display all students with course details, even if some courses have no enrollments.
select s.name, c.course_name from students s left join enrollments e
on s.student_id=e.student_id left join courses c on e.course_id=c.course_id;

-- 7. List all students and all courses, even if there is no match (simulate FULL JOIN).
select s.name, c.course_name from students s left join enrollments e
on s.student_id=e.student_id left join courses c on e.course_id=c.course_id
union
select s.name, c.course_name from students s right join enrollments e
on s.student_id=e.student_id right join courses c on e.course_id=c.course_id;

-- 8. Show pairs of students who have the same age.
select s1.name as student1,s2.name as student2,s1.age from students s1
join students s2 on s1.age=s2.age where s1.student_id<s2.student_id; 

-- 9.Count how many students are enrolled in each course.
select c.course_name, count(e.student_id) as total from courses c left join 
enrollments e on c.course_id=e.course_id group by c.course_name;

-- Q10. Show the number of courses each student is enrolled in.
select s.name, count(e.course_id) as total from students s left join enrollments e
on s.student_id=e.student_id group by s.name;

-- Q11. List all students and their courses ordered by student name.
select s.name, c.course_name from students s left join enrollments e
on s.student_id=e.student_id left join courses c on e.course_id=c.course_id
order by s.name desc;

-- Q12. Show student names and course names ordered by course name.
select s.name, c.course_name from students s left join enrollments e
on s.student_id=e.student_id left join courses c on e.course_id=c.course_id
union
select s.name, c.course_name from students s right join enrollments e
on s.student_id=e.student_id right join courses c on e.course_id=c.course_id
order by course_name;

-- Q13. Show only courses with more than one student enrolled.
select c.course_name, count(e.student_id) as total from courses c left join
enrollments e on c.course_id=e.course_id 
group by c.course_name having total>1;

-- Q14. List students enrolled in more than one course.
select s.name, count(e.course_id) as total from students s left join
enrollments e on s.student_id=e.student_id 
group by s.name having total>1;

-- Q15. Display student names and count of enrollments, ordered
select s.name, count(e.course_id) as total from students s left join
enrollments e on s.student_id=e.student_id 
group by s.name having total>1
order by total;
