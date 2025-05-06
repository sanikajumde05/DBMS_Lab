--1.	Inner Join: Retrieve all instructors with their department names
select i.instructor_id, i.name, d.dept_name, i.bsal, i.tsal from instructor i
join department d on i.dept_id = d.dept_id;

--2.	Left Join: Retrieve all departments and their instructors (even if no instructor exists)
select d.dept_name, i.name, i.bsal from department d left join instructor i on d.dept_id = i.dept_id;

--3.	Subquery: Get instructors whose salary is greater than the average salary
select name, bsal, tsal from instructor where tsal > (select avg(tsal) from instructor);

--4.	Find the highest-paid instructor per department
select name, bsal, dept_id from instructor where (dept_id, bsal) in (    select dept_id, max(bsal)  from instructor     group by dept_id );

--5.	Get the names of HODs (Head of Departments)
select name, dept_id from instructor where is_hod = 'y';

--6.	Find the total salary expenditure for each department
select d.dept_name, sum(i.tsal) as total_expenditure from instructor i
join department d on i.dept_id = d.dept_id group by d.dept_name order by total_expenditure desc;
Groups instructors by department and calculates total salary expenditure per department.

--7.	Get the instructor(s) with the highest salary
select name, bsal, tsal from instructor where tsal = (select max(tsal) from instructor);
Finds the instructor(s) with the highest total salary.

--8.	Find the number of instructors in each department
select d.dept_name, count(i.instructor_id) as total_instructors from department d left join instructor i on d.dept_id = i.dept_id group by d.dept_name order by total_instructors desc;
Counts how many instructors are in each department, including departments with no instructors.

--9.	List instructors hired in the last 5 years
select name, hiredate from instructor where hiredate >= add_months(sysdate, -60) order by hiredate desc;
Finds instructors hired within the last 5 years.

--10.	Find the second highest salary among instructors
select max(tsal) as second_highest_salary from instructor where tsal < (select max(tsal) from instructor);
Finds the second highest total salary.

--11.	 Find instructors who earn more than their department’s average salary
select i.name, i.bsal, d.dept_name from instructor I join department d on i.dept_id = d.dept_id where i.bsal > (select avg(bsal)from instructor
    where dept_id = i.dept_id);

--Lists instructors who earn more than their department's average salary.

--12.	 Get instructors who are NOT assigned to any department
select name from instructor where dept_id is null;
Finds instructors who are not associated with any department.

--13.	 Find the oldest hired instructor
select name, hiredate from instructor where hiredate = (select min(hiredate) from instructor);
Finds the instructor who has been in the institution the longest.

--14.	 Rank instructors by total salary using ROW_NUMBER
select name, tsal, row_number() over (order by tsal desc) as rank
from instructor;
Ranks instructors based on their total salary from highest to lowest.

--15.	 Find the department with the highest number of instructors
select d.dept_name, count(i.instructor_id) as instructor_count from department d left join instructor i on d.dept_id = i.dept_id
group by d.dept_name order by instructor_count desc fetch first 1 rows only;
