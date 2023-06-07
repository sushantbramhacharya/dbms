CREATE TABLE tbl_Student (
    roll_no number,
    student_name VARCHAR2(50),
    dob DATE,
    address VARCHAR2(50),primary key(roll_no)
);

CREATE TABLE tbl_Subjects (
    subject_id number  ,
    subject_name VARCHAR2(50),
    primary key(subject_id)
);
 
CREATE TABLE tbl_Marks (
    marks_id number,
    student_roll number ,
    subject_id number ,
    obtained_marks number,
    FOREIGN KEY(student_roll) REFERENCES tbl_Student(roll_no),
    FOREIGN KEY(subject_id) REFERENCES tbl_Subjects(subject_id),
    primary key(marks_id)
);

INSERT INTO tbl_Student (roll_no, student_name, dob, address)
VALUES (4, 'sujal Doe', TO_DATE('2006-02-08', 'YYYY-MM-DD'), 'NYC');

INSERT INTO tbl_Subjects (subject_id, subject_name)
VALUES (2, 'C');

INSERT INTO tbl_Marks (marks_id, student_roll, subject_id, obtained_marks)
VALUES (5, 4, 2,59 );


--write query for getting sum of marks by each student
SELECT s.roll_no, s.student_name, SUM(m.obtained_marks) AS total_marks
FROM tbl_Student s
JOIN tbl_Marks m ON s.roll_no = m.student_roll
GROUP BY s.roll_no, s.student_name;

--subqueries
SELECT s.roll_no,s.student_name,(SELECT SUM(m.obtained_marks)FROM tbl_Marks m WHERE m.student_roll=s.roll_no) as TOTAL From tbl_Student s;

--write query for getting average marks by each student
SELECT s.roll_no, s.student_name, AVG(m.obtained_marks) AS average_marks
FROM tbl_Student s
JOIN tbl_Marks m ON s.roll_no = m.student_roll;

--subqueries
SELECT s.roll_no,s.student_name,(SELECT AVG(m.obtained_marks)FROM tbl_Marks m WHERE m.student_roll=s.roll_no) as avg From tbl_Student s;

--write query for getting max marks in each subject
SELECT subject_id, MAX(obtained_marks) AS max_marks
FROM tbl_Marks
GROUP BY subject_id;


--write query for getting min marks in each subject
SELECT subject_id, MIN(obtained_marks) AS min_marks
FROM tbl_Marks
GROUP BY subject_id;

--counting
SELECT student_roll, COUNT(DISTINCT subject_id) AS subject_count
FROM tbl_Marks
GROUP BY student_roll;

--who have max marks
select student_name,subject_id ,obtained_marks from tbl_student s,
tbl_marks m where s.roll_no=m.student_roll AND obtained_marks = (SELECT max(obtained_marks) from tbl_marks);

--displays subject
SELECT
    (SELECT student_name FROM tbl_student WHERE roll_no = m.student_roll) AS name,
    (SELECT subject_name FROM tbl_subjects WHERE subject_id = m.subject_id) AS subject,
    m.obtained_marks
FROM tbl_marks m
WHERE m.obtained_marks = (SELECT MAX(obtained_marks) FROM tbl_marks);

Delete from tbl_student s where substr(student_name,-1)='i' and (select obtained_marks from tbl_marks where s.roll_no=student_roll) >60;


--altering column in table with fk
--for student roll
ALTER TABLE tbl_marks
ADD student_roll NUMBER;

ALTER TABLE tbl_marks
ADD CONSTRAINT tbl_student_roll_fk FOREIGN KEY (student_roll) REFERENCES tbl_Student(roll_no) on DELETE CASCADE;

--for subject id
ALTER TABLE tbl_marks
ADD subject_id NUMBER;

ALTER TABLE tbl_marks
ADD CONSTRAINT tbl_subject_id_fk FOREIGN KEY (subject_id) REFERENCES tbl_Subjects(subject_id) on DELETE CASCADE;


-- paste bin codes
CREATE TABLE
    tbl_Employee (
        employee_name VARCHAR2(255) NOT NULL,
        street VARCHAR2(255) NOT NULL,
        city VARCHAR2(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );
 
 
CREATE TABLE
    tbl_Works (
        employee_name VARCHAR2(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR2(255),
        salary DECIMAL(10, 2)
    );
 
CREATE TABLE
    tbl_Company (
        company_name VARCHAR2(255) NOT NULL,
        city VARCHAR2(255),
        PRIMARY KEY(company_name)
    );
 
CREATE TABLE
    tbl_Manages (
        employee_name VARCHAR2(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR2(255)
    );
 
 INSERT into tbl_Employee (employee_name, street, city)
 values ('John Smith', '321 Maple St', 'Houston');
INSERT ALL
    INTO tbl_Employee (employee_name, street, city)
    VALUES ('Alice Williams', '321 Maple St', 'Houston')
    INTO tbl_Employee (employee_name, street, city)
    VALUES ('Sara Davis', '159 Broadway', 'New York')
    INTO tbl_Employee (employee_name, street, city)
    VALUES ('Mark Thompson', '235 Fifth Ave', 'New York')
    INTO tbl_Employee (employee_name, street, city)
    VALUES ('Ashley Johnson', '876 Market St', 'Chicago')
    INTO tbl_Employee (employee_name, street, city)
    VALUES ('Emily Williams', '741 First St', 'Los Angeles')
    INTO tbl_Employee (employee_name, street, city)
    VALUES ('Michael Brown', '902 Main St', 'Houston')
    INTO tbl_Employee (employee_name, street, city)
    VALUES ('Samantha Smith', '111 Second St', 'Chicago')
SELECT 1 FROM DUAL;

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Patrick',
        '123 Main St',
        'New Mexico'
    );
 
INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Patrick',
        'Pongyang Corporation',
        500000
    );
 
INSERT INTO tbl_Works (employee_name, company_name, salary)
 VALUES ('John Smith', 'First Bank Corporation', 82500.00);
INSERT ALL
    INTO tbl_Works (employee_name, company_name, salary)
    VALUES ('Sara Davis', 'First Bank Corporation', 82500.00)
    INTO tbl_Works (employee_name, company_name, salary)
    VALUES ('Mark Thompson', 'Small Bank Corporation', 78000.00)
    INTO tbl_Works (employee_name, company_name, salary)
    VALUES ('Ashley Johnson', 'Small Bank Corporation', 92000.00)
    INTO tbl_Works (employee_name, company_name, salary)
    VALUES ('Emily Williams', 'Small Bank Corporation', 86500.00)
    INTO tbl_Works (employee_name, company_name, salary)
    VALUES ('Michael Brown', 'Small Bank Corporation', 81000.00)
    INTO tbl_Works (employee_name, company_name, salary)
    VALUES ('Samantha Smith', 'Small Bank Corporation', 77000.00)
SELECT * FROM DUAL;

 
INSERT ALL
    INTO tbl_Company (company_name, city) VALUES ('Small Bank Corporation', 'Chicago')
    INTO tbl_Company (company_name, city) VALUES ('ABC Inc', 'Los Angeles')
    INTO tbl_Company (company_name, city) VALUES ('Def Co', 'Houston')
    INTO tbl_Company (company_name, city) VALUES ('First Bank Corporation', 'New York')
    INTO tbl_Company (company_name, city) VALUES ('456 Corp', 'Chicago')
    INTO tbl_Company (company_name, city) VALUES ('789 Inc', 'Los Angeles')
    INTO tbl_Company (company_name, city) VALUES ('321 Co', 'Houston')
    INTO tbl_Company (company_name, city) VALUES ('Pongyang Corporation', 'Chicago')
SELECT * FROM DUAL;

 
 INSERT INTO tbl_Manages(employee_name, manager_name)
SELECT 'Mark Thompson', 'Emily Williams' FROM dual
UNION ALL
SELECT 'John Smith', 'Jane Doe' FROM dual
UNION ALL
SELECT 'Alice Williams', 'Emily Williams' FROM dual
UNION ALL
SELECT 'Samantha Smith', 'Sara Davis' FROM dual
UNION ALL
SELECT 'Patrick', 'Jane Doe' FROM dual;

 
SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Company;
SELECT * FROM tbl_Manages;

select employee_name from tbl_Works where company_name='First Bank Corporation';
select e.employee_name,city from tbl_Employee e where e.employee_name in (select employee_name from tbl_Works w where w.company_name ='First Bank Corporation');
select * from tbl_Employee e where e.employee_name in (select employee_name from tbl_Works w where w.company_name ='First Bank Corporation' and salary>10000);
SELECT employee_name, street, e.city FROM tbl_Employee e WHERE e.city IN (SELECT c.city FROM tbl_Company c WHERE c.company_name IN (SELECT w.company_name FROM tbl_Works w WHERE w.employee_name = e.employee_name));

SELECT employee_name, street, city
FROM tbl_Employee
WHERE (street, city) IN (
SELECT street, city
FROM tbl_Employee
WHERE employee_name IN (
SELECT manager_name
FROM tbl_Manages
)
);


-- Update the value of salary to 1000 where employee name= John Smith and company_name = First Bank Corporation
UPDATE tbl_Works
SET salary = '1000'
WHERE
    employee_name = 'John Smith'
AND company_name = 'First Bank Corporation';
 
 
 
