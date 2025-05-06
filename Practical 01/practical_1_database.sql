--Create all necessary tables:

CREATE TABLE UNIVERSITY (
    university_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE DEPARTMENT (
    dept_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    building VARCHAR(50),
    budget DECIMAL(12, 2),
    university_id INT,
    FOREIGN KEY (university_id) REFERENCES UNIVERSITY(university_id)
);

CREATE TABLE INSTRUCTOR (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    dept_id INT,
    is_hod BOOLEAN DEFAULT FALSE,
    salary DECIMAL(10, 2),
    FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)
);

CREATE TABLE COURSE (
    course_id VARCHAR(8) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    dept_id INT,
    credits INT,
    FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id)
);





CREATE TABLE SECTION (
    section_id INT PRIMARY KEY,
    course_id VARCHAR(8),
    sec_id INT,
    semester VARCHAR(6),
    year INT,
    building VARCHAR(50),
    room_number VARCHAR(10),
    time_slot_id VARCHAR(4),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);

CREATE TABLE TEACHES (
    instructor_id INT,
    section_id INT,
    PRIMARY KEY (instructor_id, section_id),
    FOREIGN KEY (instructor_id) REFERENCES INSTRUCTOR(instructor_id),
    FOREIGN KEY (section_id) REFERENCES SECTION(section_id)
);

CREATE TABLE STUDENT (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    tot_cred INT
);

CREATE TABLE TAKES (
    student_id INT,
    section_id INT,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, section_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (section_id) REFERENCES SECTION(section_id)
);

CREATE TABLE TIME_SLOT (
    time_slot_id VARCHAR(4) PRIMARY KEY,
    day VARCHAR(1),
    start_time TIME,
    end_time TIME
);

CREATE TABLE CLASSROOM (
    building VARCHAR(50),
    room_number VARCHAR(10),
    capacity INT,
    PRIMARY KEY (building, room_number)
);
