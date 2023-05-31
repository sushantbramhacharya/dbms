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


