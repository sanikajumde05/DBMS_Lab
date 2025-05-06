--Insert sample data into all tables

INSERT INTO UNIVERSITY (university_id, name) VALUES 
(1, 'Example University'),
(2, 'Another University'),
(3, 'Third University'),
(4, 'Fourth University'),
(5, 'Fifth University'),
(6, 'Sixth University'),
(7, 'Seventh University');

INSERT INTO DEPARTMENT (dept_id, name, building, budget, university_id) VALUES 
(1, 'Computer Science', 'Taylor', 100000, 1),
(2, 'Mathematics', 'Watson', 90000, 1),
(3, 'Physics', 'Newton', 95000, 1),
(4, 'Biology', 'Darwin', 85000, 1),
(5, 'Chemistry', 'Curie', 92000, 1),
(6, 'English', 'Shakespeare', 80000, 1),
(7, 'History', 'Roosevelt', 78000, 1);

INSERT INTO INSTRUCTOR (instructor_id, name, dept_id, is_hod, salary) VALUES 
(1, 'John Doe', 1, TRUE, 80000),
(2, 'Jane Smith', 1, FALSE, 75000),
(3, 'Bob Johnson', 2, TRUE, 82000),
(4, 'Alice Brown', 2, FALSE, 76000),
(5, 'Charlie Davis', 3, TRUE, 81000),
(6, 'Eva Wilson', 3, FALSE, 77000),
(7, 'Frank Miller', 4, TRUE, 79000);

INSERT INTO COURSE (course_id, title, dept_id, credits) VALUES 
('CS-101', 'Introduction to Programming', 1, 3),
('CS-201', 'Data Structures', 1, 4),
('MATH-101', 'Calculus I', 2, 4),
('MATH-201', 'Linear Algebra', 2, 3),
('PHY-101', 'Mechanics', 3, 4),
('PHY-201', 'Quantum Physics', 3, 4),
('BIO-101', 'Introduction to Biology', 4, 4);

INSERT INTO SECTION (section_id, course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES 
(1, 'CS-101', 1, 'Fall', 2023, 'Taylor', '3128', 'A'),
(2, 'CS-201', 1, 'Spring', 2024, 'Taylor', '3114', 'B'),
(3, 'MATH-101', 1, 'Fall', 2023, 'Watson', '2230', 'C'),
(4, 'MATH-201', 1, 'Spring', 2024, 'Watson', '2245', 'D'),
(5, 'PHY-101', 1, 'Fall', 2023, 'Newton', '1320', 'E'),
(6, 'PHY-201', 1, 'Spring', 2024, 'Newton', '1310', 'F'),
(7, 'BIO-101', 1, 'Fall', 2023, 'Darwin', '2110', 'G');

INSERT INTO TEACHES (instructor_id, section_id) VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7);

INSERT INTO STUDENT (student_id, name, tot_cred) VALUES 
(1, 'Mike Johnson', 60),
(2, 'Sarah Lee', 45),
(3, 'Tom Brown', 30),
(4, 'Emily Davis', 75),
(5, 'David Wilson', 90),
(6, 'Lisa Anderson', 15),
(7, 'Chris Taylor', 105);

INSERT INTO TAKES (student_id, section_id, grade) VALUES 
(1, 1, 'A'), (1, 3, 'B'),
(2, 2, 'A'), (2, 4, 'B'),
(3, 1, 'B'), (3, 5, 'A'),
(4, 2, 'A'), (4, 6, 'B'),
(5, 3, 'A'), (5, 7, 'A'),
(6, 4, 'B'), (6, 1, 'A'),
(7, 5, 'A'), (7, 2, 'B');




INSERT INTO TIME_SLOT (time_slot_id, day, start_time, end_time) VALUES 
('A', 'M', '09:00', '10:30'),
('B', 'T', '10:30', '12:00'),
('C', 'W', '13:00', '14:30'),
('D', 'R', '15:00', '16:30'),
('E', 'F', '11:00', '12:30'),
('F', 'M', '14:00', '15:30'),
('G', 'T', '16:00', '17:30');

INSERT INTO CLASSROOM (building, room_number, capacity) VALUES 
('Taylor', '3128', 50),
('Taylor', '3114', 40),
('Watson', '2230', 60),
('Watson', '2245', 45),
('Newton', '1320', 55),
('Newton', '1310', 50),
('Darwin', '2110', 40);



--iii. Alter the datatypes of any 3 columns
ALTER TABLE INSTRUCTOR ALTER COLUMN name TYPE VARCHAR(100);
ALTER TABLE COURSE ALTER COLUMN credits TYPE SMALLINT;
ALTER TABLE STUDENT ALTER COLUMN name TYPE VARCHAR(100);

--iv. Increase the salary of each instructor in the Comp. Sci. department by 10%
UPDATE INSTRUCTOR
SET salary = salary * 1.1
WHERE dept_id = (SELECT dept_id FROM DEPARTMENT WHERE name = 'Computer Science');

 --v. Delete all courses that have never been offered
DELETE FROM COURSE
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM SECTION);

--vi. Delete all tuples in the instructor relation for those instructors associated with a department located in the Watson Building
DELETE FROM INSTRUCTOR
WHERE dept_id IN (SELECT dept_id FROM DEPARTMENT WHERE building = 'Watson');

 --vii. Give a 5% salary raise to those instructors who earn less than 70000
UPDATE INSTRUCTOR
SET salary = salary * 1.05
WHERE salary < 70000;

 --viii. a. Create a new course "CS-001", titled "Weekly Seminar", with 1 credit
INSERT INTO COURSE (course_id, title, dept_id, credits)
VALUES ('CS-001', 'Weekly Seminar', 1, 1);

 --viii. b. Create a section of this course in Fall 2017
INSERT INTO SECTION (section_id, course_id, sec_id, semester, year, building, room_number, time_slot_id)
VALUES (8, 'CS-001', 1, 'Fall', 2017, NULL, NULL, NULL);

 --viii. c. Delete the course CS-001
First, delete any sections of this course
DELETE FROM SECTION WHERE course_id = 'CS-001';
Then delete the course
DELETE FROM COURSE WHERE course_id = 'CS-001';

 --ix. Create Views

 --Create a view without check option
CREATE VIEW CS_INSTRUCTORS AS
SELECT * FROM INSTRUCTOR
WHERE dept_id = (SELECT dept_id FROM DEPARTMENT WHERE name = 'Computer Science');

--Create a view with check option
CREATE VIEW HIGH_SALARY_INSTRUCTORS AS
SELECT * FROM INSTRUCTOR
WHERE salary > 80000
WITH CHECK OPTION;

 --Create a read-only view
CREATE VIEW COURSE_SUMMARY AS
SELECT c.course_id, c.title AS course_name, d.name AS department_name, i.name AS instructor_name
FROM COURSE c
JOIN DEPARTMENT d ON c.dept_id = d.dept_id
JOIN SECTION s ON c.course_id = s.course_id
JOIN TEACHES t ON s.section_id = t.section_id
JOIN INSTRUCTOR i ON t.instructor_id = i.instructor_id
WITH READ ONLY;

 --Select from a view
SELECT * FROM CS_INSTRUCTORS;

--Drop a view
DROP VIEW IF EXISTS CS_INSTRUCTORS;

-- x. Create a table with a sequence
CREATE SEQUENCE employee_seq START 1;
CREATE TABLE EMPLOYEE (
    emp_id INT DEFAULT nextval('employee_seq') PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100)
);
INSERT INTO EMPLOYEE (name, position) VALUES 
('John Doe', 'Manager'),
('Jane Smith', 'Developer');

--Drop the sequence
DROP SEQUENCE IF EXISTS employee_seq;

--xi. Rename the table
ALTER TABLE EMPLOYEE RENAME TO STAFF;

 --xii. Add a new column PINCODE with not null constraints
ALTER TABLE STAFF ADD COLUMN PINCODE VARCHAR(10) NOT NULL DEFAULT '000000';


 --xiii. Drop the column with cascade constraints
ALTER TABLE STAFF DROP COLUMN IF EXISTS PINCODE CASCADE;

