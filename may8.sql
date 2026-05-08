
CREATE TABLE dept_47 (
    Dept_ID    INT PRIMARY KEY,
    Dept_Name  VARCHAR2(50),
    Budget     NUMBER(12,2),
    Building   VARCHAR2(50)
);


CREATE TABLE course_47 (
    Course_ID  INT PRIMARY KEY,
    Title      VARCHAR2(100),
    Dept_ID    INT,
    Credits    INT,
    FOREIGN KEY (Dept_ID) REFERENCES dept_47(Dept_ID)
);


CREATE TABLE instructor_47 (
    ID      INT PRIMARY KEY,
    Name    VARCHAR2(50),
    Dept_ID INT,
    Salary  NUMBER(12,2),
    FOREIGN KEY (Dept_ID) REFERENCES dept_47(Dept_ID)
);


CREATE TABLE student_47 (
    ID       INT PRIMARY KEY,
    Name     VARCHAR2(50),
    Dept_ID  INT,
    Tot_Cred INT,
    FOREIGN KEY (Dept_ID) REFERENCES dept_47(Dept_ID)
);


CREATE TABLE takes_47 (
    ID        INT,
    Course_ID INT,
    Sec_ID    INT,
    Semester  VARCHAR2(10),
    Year      INT,
    Grade     VARCHAR2(2),
    PRIMARY KEY (ID, Course_ID, Sec_ID, Semester, Year),
    FOREIGN KEY (ID) REFERENCES student_47(ID),
    FOREIGN KEY (Course_ID) REFERENCES course_47(Course_ID)
);

INSERT INTO dept_47 (Dept_ID, Dept_Name, Budget, Building)
VALUES (1, 'Computer Science', 500000, 'Engineering Building');

INSERT INTO dept_47 (Dept_ID, Dept_Name, Budget, Building)
VALUES (2, 'Mathematics', 300000, 'Science Hall');

INSERT INTO dept_47 (Dept_ID, Dept_Name, Budget, Building)
VALUES (3, 'Physics', 400000, 'Physics Center');

INSERT INTO dept_47 (Dept_ID, Dept_Name, Budget, Building)
VALUES (4, 'Chemistry', 350000, 'Chemistry Block');

INSERT INTO course_47 (Course_ID, Title, Dept_ID, Credits)
VALUES (101, 'Database Systems', 1, 4);

INSERT INTO course_47 (Course_ID, Title, Dept_ID, Credits)
VALUES (102, 'Algorithms', 1, 3);

INSERT INTO course_47 (Course_ID, Title, Dept_ID, Credits)
VALUES (201, 'Linear Algebra', 2, 3);

INSERT INTO course_47 (Course_ID, Title, Dept_ID, Credits)
VALUES (202, 'Probability', 2, 3);

INSERT INTO course_47 (Course_ID, Title, Dept_ID, Credits)
VALUES (301, 'Quantum Mechanics', 3, 4);

INSERT INTO course_47 (Course_ID, Title, Dept_ID, Credits)
VALUES (401, 'Organic Chemistry', 4, 4);

INSERT INTO instructor_47 (ID, Name, Dept_ID, Salary)
VALUES (1001, 'Dr. Smith', 1, 90000);

INSERT INTO instructor_47 (ID, Name, Dept_ID, Salary)
VALUES (1002, 'Dr. Allen', 2, 80000);

INSERT INTO instructor_47 (ID, Name, Dept_ID, Salary)
VALUES (1003, 'Dr. Johnson', 3, 85000);

INSERT INTO instructor_47 (ID, Name, Dept_ID, Salary)
VALUES (1004, 'Dr. Brown', 4, 75000);

INSERT INTO instructor_47 (ID, Name, Dept_ID, Salary)
VALUES (1005, 'Dr. Susan', 1, 95000);

INSERT INTO student_47 (ID, Name, Dept_ID, Tot_Cred)
VALUES (2001, 'Alice', 1, 30);

INSERT INTO student_47 (ID, Name, Dept_ID, Tot_Cred)
VALUES (2002, 'Bob', 2, 45);

INSERT INTO student_47 (ID, Name, Dept_ID, Tot_Cred)
VALUES (2003, 'Charlie', 3, 60);

INSERT INTO student_47 (ID, Name, Dept_ID, Tot_Cred)
VALUES (2004, 'Srinivasan', 1, 110);

INSERT INTO student_47 (ID, Name, Dept_ID, Tot_Cred)
VALUES (2005, 'Steven', 1, 95);

INSERT INTO student_47 (ID, Name, Dept_ID, Tot_Cred)
VALUES (2006, 'Sophian', 2, 70);

INSERT INTO takes_47 (ID, Course_ID, Sec_ID, Semester, Year, Grade)
VALUES (2001, 101, 1, 'Fall', 2022, 'A');

INSERT INTO takes_47 (ID, Course_ID, Sec_ID, Semester, Year, Grade)
VALUES (2001, 102, 1, 'Spring', 2023, 'B');

INSERT INTO takes_47 (ID, Course_ID, Sec_ID, Semester, Year, Grade)
VALUES (2002, 201, 1, 'Fall', 2022, 'A');

INSERT INTO takes_47 (ID, Course_ID, Sec_ID, Semester, Year, Grade)
VALUES (2003, 301, 1, 'Spring', 2023, 'B');

INSERT INTO takes_47 (ID, Course_ID, Sec_ID, Semester, Year, Grade)
VALUES (2004, 101, 1, 'Fall', 2025, 'A');

INSERT INTO takes_47 (ID, Course_ID, Sec_ID, Semester, Year, Grade)
VALUES (2004, 102, 1, 'Fall', 2025, 'A');

INSERT INTO takes_47 (ID, Course_ID, Sec_ID, Semester, Year, Grade)
VALUES (2004, 201, 1, 'Fall', 2025, 'B');

INSERT INTO takes_47 (ID, Course_ID, Sec_ID, Semester, Year, Grade)
VALUES (2005, 101, 1, 'Spring', 2026, 'A');

INSERT INTO takes_47 (ID, Course_ID, Sec_ID, Semester, Year, Grade)
VALUES (2006, 202, 1, 'Fall', 2025, 'A');

SELECT I.Name, I.Dept_ID, I.Salary
FROM instructor_47 I
WHERE I.Salary > (
    SELECT AVG(Salary)
    FROM instructor_47
    WHERE Dept_ID = I.Dept_ID
);


SELECT S.Name
FROM student_47 S
WHERE NOT EXISTS (
    SELECT C.Course_ID
    FROM course_47 C
    WHERE C.Dept_ID = (
        SELECT Dept_ID FROM dept_47 WHERE Dept_Name = 'Computer Science'
    )
    MINUS
    SELECT T.Course_ID
    FROM takes_47 T
    WHERE T.ID = S.ID
);

SELECT Name
FROM student_47
INTERSECT
SELECT Name
FROM instructor_47;

SELECT DISTINCT C.Title
FROM course_47 C
JOIN takes_47 T ON C.Course_ID = T.Course_ID
JOIN student_47 S ON T.ID = S.ID
WHERE S.Name LIKE 'S%n'
  AND T.Grade = 'A';

SELECT D.Dept_Name
FROM dept_47 D
JOIN instructor_47 I ON D.Dept_ID = I.Dept_ID
GROUP BY D.Dept_ID, D.Dept_Name
HAVING SUM(I.Salary) > (
    SELECT AVG(Total_Salary)
    FROM (
        SELECT SUM(Salary) AS Total_Salary
        FROM instructor_47
        GROUP BY Dept_ID
    )
);

SELECT D.Dept_Name,
       NVL(I.Name, 'No Instructor') AS Instructor_Name
FROM dept_47 D
LEFT JOIN instructor_47 I ON D.Dept_ID = I.Dept_ID;

SELECT MIN(Salary) AS Third_Highest_Salary
FROM (
    SELECT DISTINCT Salary
    FROM instructor_47
    ORDER BY Salary DESC
) 
WHERE ROWNUM <= 3;

SELECT Name,
       CASE
           WHEN Tot_Cred > 100 THEN 'Senior'
           WHEN Tot_Cred BETWEEN 60 AND 100 THEN 'Junior'
           ELSE 'Sophomore'
       END AS Category
FROM student_47;

SELECT DISTINCT I.ID, I.Name
FROM instructor_47 I
JOIN course_47 C ON I.Dept_ID = C.Dept_ID
JOIN takes_47 T ON C.Course_ID = T.Course_ID
WHERE T.Semester = 'Fall' AND T.Year = 2025
  AND I.ID NOT IN (
      SELECT I2.ID
      FROM instructor_47 I2
      JOIN course_47 C2 ON I2.Dept_ID = C2.Dept_ID
      JOIN takes_47 T2 ON C2.Course_ID = T2.Course_ID
      WHERE T2.Semester = 'Spring' AND T2.Year = 2026
  );

SELECT DISTINCT I.ID, I.Name
FROM instructor_47 I
JOIN course_47 C ON I.Dept_ID = C.Dept_ID
JOIN takes_47 T ON C.Course_ID = T.Course_ID
WHERE T.Semester = 'Fall' AND T.Year = 2025
  AND I.ID NOT IN (
      SELECT I2.ID
      FROM instructor_47 I2
      JOIN course_47 C2 ON I2.Dept_ID = C2.Dept_ID
      JOIN takes_47 T2 ON C2.Course_ID = T2.Course_ID
      WHERE T2.Semester = 'Spring' AND T2.Year = 2026
  );

