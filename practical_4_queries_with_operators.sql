--1.	Using AND Operator
--Find instructors who are HODs (IS_HOD = 'Y') AND have a salary (BSAL) greater than 70,000.
select name, bsal, is_hod from instructor where is_hod = 'y' and bsal > 70000;

--2.	Using OR Operator
--	Find instructors who belong to the Computer Science (DEPT_ID = 1) OR Mathematics (DEPT_ID = 2).
select name, dept_id from instructor where dept_id = 1 or dept_id = 2;

--3.	Using NOT Operator
--	Find instructors who are NOT heads of departments (HODs).
select name, is_hod from instructor where not is_hod = 'y';

--4.	Using LIKE Operator
	Find instructors whose names start with 'A'.
select name from instructor where name like 'a%';
--	Find instructors whose names contain 'Smith'.
select name from instructor where name like '%smith%';
--	Find instructors whose names end with 'son'.
select name from instructor where name like '%son';

--5.	 Using BETWEEN Operator
--	Find instructors whose basic salary (BSAL) is between 60,000 and 80,000.
select name, bsal from instructor where bsal between 60000 and 80000;
--	Find instructors hired between 2015 and 2020.
select name, hiredate from instructor where hiredate between to_date('2015-01-01', 'yyyy-mm-dd')  and to_date('2020-12-31', 'yyyy-mm-dd');

--6.	 Using IN Operator
--	Find instructors who belong to department IDs 1, 2, or 3.
select name, dept_id from instructor where dept_id in (1, 2, 3);
--Find instructors who have a basic salary of 60000, 70000, or 75000.
select name, bsal from instructor where bsal in (60000, 70000, 75000);
--Find instructors who were hired in 2015, 2018, or 2020.
select name, hiredate from instructor where extract(year from hiredate) in (2015, 2018, 2020);
