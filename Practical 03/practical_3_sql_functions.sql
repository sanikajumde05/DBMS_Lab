--Aggregate Functions 

--1. COUNT Function
select count(*) as total_instructors from instructor;

--2.	SUM Function
select sum(tsal) as total_salary from instructor;

--3.	AVERAGE Function
select avg(tsal) as avg_salary from instructor;

--4.	MAX & MIN Function
select max(tsal) as highest_salary, min(tsal) as lowest_salary from instructor;

--5.	HAVING Function
select dept_id, count(*) as total_instructors from instructor group by dept_id having count(*) > 3;

--Numeric
--1.	ROUNDING AND TRUNCATION
select name, tsal, round(tsal, 2) as rounded_salary, trunc(tsal, 2) as truncated_salary from instructor;

Function	Description	Example
ABS(n)	Returns the absolute value of n	SELECT ABS(-10) FROM dual; → 10
CEIL(n)	Rounds n up to the nearest integer	SELECT CEIL(3.2) FROM dual; → 4
FLOOR(n)	Rounds n down to the nearest integer	SELECT FLOOR(3.9) FROM dual; → 3
ROUND(n, d)	Rounds n to d decimal places	SELECT ROUND(123.456, 2) FROM dual; → 123.46
TRUNC(n, d)	Truncates n to d decimal places (removes extra digits)	SELECT TRUNC(123.456, 2) FROM dual; → 123.45

Example: select abs(-10) as absolute_value from dual;



--Date

--1.	Finding Earliest (MIN) & Latest (MAX) Date
select min(hiredate) as first_hire_date, max(hiredate) as last_hire_date from instructor;												
--2.	COUNT with EXTRACT
select extract(year from hiredate) as hire_year, count(*) as total_hired from instructor group by extract(year from hiredate) order by hire_year;

--3.	AVERAGE
select avg(sysdate - hiredate) as avg_days_in_org from instructor;

--4.	INTERVAL
select rownum as sr_no, name, hiredate from instructor where hiredate <= sysdate - interval '5' year;

--5.	EXTRACT
select instructor_id, name, extract(year from hiredate) as hire_year, extract(month from hiredate) as hire_month, extract(day from hiredate) as hire_day from instructor;

--String
--1.	To UPPER & LOWER
select name, upper(name) as name_upper, lower(name) as name_lower, initcap(name) as name_capitalized from instructor;

--2.	String Length and Substrings
select name, length(name) as name_length, substr(name, 1, 3) as first_three_chars, instr(name, 'a') as position_of_a   from instructor;

--3.	String Concatenation
select 'prof. ' || name as professor_name from instructor;

--4.	Trimming and Padding Strings
select name, trim(name) as trimmed_name, lpad(name, 10, '*') as left_padded, rpad(name, 10, '*') as right_padded from instructor;

--5.	Replacing and Changing Strings
select name, replace(name, 'a', '@') as replaced_a, translate(name, 'aeiou', '*****') as remove_vowels from instructor;

--6.	Using String Functions in Filtering (LIKE)
select * from instructor where name like 'a%'; 
select * from instructor where name like '%n';
select * from instructor where name like '%smith%'; 

--Conversion
--1.	Number to String Conversion (TO_CHAR)
select name, to_char(tsal, '999,999.99') as formatted_salary, to_char(hiredate, 'dd-mon-yyyy') as hire_date_formatted from instructor;

--2.	String to Number Conversion (TO_NUMBER)
select name, tsal, to_number('10000') + tsal as new_salary from instructor;

--3.	String to Date Conversion (TO_DATE)
select name, hiredate, to_date('01-jan-2020', 'dd-mon-yyyy') as reference_date from instructor where hiredate > to_date('01-jan-2020', 'dd-mon-yyyy');

--4.	Handling Invalid Conversions (CAST)
select name, cast(tsal as varchar2(10)) as salary_string, cast(hiredate as timestamp) as hire_timestamp from instructor;
