CREATE TABLE EMP_CS2_47(
	EMPNO number(4) PRIMARY KEY,
	ENAME varchar(30) NOT NULL,
	JOB char(20),
	MGR number(4),
	HIREDATE date,
	SAL number(4),
	COMM number(4),
	DEPTNO number(2));


CREATE TABLE DEPT_CS2_47(
	DEPTNO number(2) PRIMARY KEY,
	DNAME varchar(15) NOT NULL,
	LOD varchar(15) NOT NULL);


INSERT INTO EMP_CS2_47 VALUES(&eno,'&ename','&job',&mgr,TO_DATE	('&hd','DD/MM/YY'),&sal,&com,&dno);

INSERT INTO DEPT_CS2_47 VALUES(&deptno,'&dname','&loc');
	
