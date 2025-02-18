SELECT * FROM EMP;
SELECT * FROM dept;
DROP TABLE EMP01;
CREATE TABLE EMP01(EMPNO NUMBER(4), ENAME VARCHAR2(20), HEIGHT NUMBER(5,2), ADDRESS VARCHAR2(200), PHONE VARCHAR2(20));

CREATE TABLE EMP02 AS SELECT * FROM EMP;    -- ���̺� ����
CREATE TABLE EMP03 AS SELECT EMPNO, ENAME FROM EMP;     -- ���ϴ� �÷��� ���������� ���� ����
CREATE TABLE EMP04 AS SELECT * FROM EMP WHERE DEPTNO=10;    -- ���ϴ� �ุ ����
CREATE TABLE EMP05 AS SELECT * FROM EMP WHERE 1=0;  -- ������ ������ ���̺��� ������ ������. 1=0�� false �̹Ƿ�

SELECT * FROM EMP01;
SELECT * FROM EMP02;
SELECT * FROM EMP03;
SELECT * FROM EMP04;

-- ���� 2)
CREATE TABLE EMP06 AS SELECT EMPNO, ENAME, SAL FROM EMP;
SELECT * FROM EMP06;

-- ���� 3)
ALTER TABLE EMP01 ADD JOB VARCHAR2(9);
DESC EMP01;

-- ���� 4)
ALTER TABLE EMP01 MODIFY JOB VARCHAR2(30);
DESC EMP01;

-- ���� 5)
ALTER TABLE EMP01 DROP COLUMN JOB;  -- column�� �������
DESC EMP01;

DROP TABLE EMP02;
CREATE TABLE EMP02 AS SELECT *FROM EMP;

ALTER TABLE EMP02 SET UNUSED(JOB);

-- ���� 6)
DROP TABLE EMP01;

-- ���� 7)
TRUNCATE TABLE EMP06;
SELECT * FROM EMP06;

-- ���� 8)
RENAME EMP06 TO TEST;

DESC USER_TABLES;

SHOW USER;

SELECT TABLE_NAME FROM USER_TABLES ORDER BY TABLE_NAME DESC;

DESC ALL_TABLES;

SELECT OWNER , TABLE_NAME FROM ALL_TABLES;

-- ���� 9)
CREATE TABLE DEPT_MISSION (DNO NUMBER(2), DNAME VARCHAR2(14), LOC VARCHAR2(13));

-- ���� 10)
CREATE TABLE EMP_MISSION (ENO NUMBER(4), ENAME VARCHAR2(10), DNO NUMBER(2));

-- ���� 11)
ALTER TABLE EMP_MISSION MODIFY(ENAME VARCHAR2(25));

-- ���� 12)
DROP TABLE EMP_MISSION;

-- ���� 13)
ALTER TABLE DEPT_MISSION DROP COLUMN DNAME;

-- ���� 14)
ALTER TABLE DEPT_MISSION SET UNUSED(LOC);

-- ���� 15)
ALTER TABLE DEPT_MISSION DROP UNUSED COLUMNS;


DROP TABLE DEPT01;

CREATE TABLE DEPT01 AS SELECT * FROM DEPT WHERE 1=0;

INSERT INTO DEPT01(DEPTNO, DNAME, LOC) VALUES(10, '������', '�λ�');
-- INSERT INTO DEPT01 VALUES(10, '������', '�λ�'); -- �̷��Ե� ����. ������ �����ÿ��� ��� �����͸� �־���Ѵ�. �ƴϸ� null�� �־������
SELECT*FROM DEPT01;
INSERT INTO DEPT01(DEPTNO, DNAME) VALUES(20, '�ѹ���');

-- ���� 1)
CREATE TABLE SAM01(EMPNO NUMBER(4), ENAME VARCHAR2(10), JOB VARCHAR2(9), SAL NUMBER(7,2));
DROP TABLE SAM01;
INSERT INTO SAM01 VALUES(1000, '���', '����', 1000);
INSERT INTO SAM01 VALUES(1010, '�ٳ���', '��ȣ��', 1500);
INSERT INTO SAM01 VALUES(1020, '������', '�ǻ�', 2000);

SELECT * FROM sam01;

-- ���� 2)
INSERT INTO SAM01 VALUES(1030, '����','', 2500);      -- �� ���ڿ��� �־ null�� ��
INSERT INTO SAM01(EMPNO, ENAME, JOB, SAL) VALUES(1040, '����', null, 25000);

DROP TABLE DEPT02;

CREATE TABLE DEPT02 AS SELECT* FROM DEPT WHERE 1 =0;
INSERT INTO DEPT02 SELECT * FROM DEPT;          
SELECT * FROM DEPT02;

SELECT TABLE_NAME FROM USER_TABLES;

-- ���� 3)
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE DEPTNO=10;
INSERT INTO SAM01 SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE DEPTNO=10;
SELECT * FROM SAM01;

CREATE TABLE EMP01 AS SELECT * FROM EMP;
SELECT * FROM EMP01;

-- ���� 4)
UPDATE EMP01 SET DEPTNO = 30 WHERE DEPTNO = 10;

-- ���� 5)
UPDATE EMP01 SET SAL = 1.1*SAL WHERE SAL>=400;

-- ���� 6)
UPDATE SAM01 SET SAL = SAL-5000 WHERE SAL>=10000;
SELECT * FROM SAM01;

-- ���� 7)
CREATE TABLE SAM02 AS SELECT ENAME, SAL, HIREDATE, DEPTNO FROM EMP;

-- ���� 8)
UPDATE SAM02 SET SAL = SAL +100 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = '��õ');
SELECT * FROM SAM02;

-- ���� 9)
DELETE FROM SAM01 WHERE JOB IS NULL;
SELECT * FROM SAM01;

-- ���� 10)
DELETE FROM SAM02 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = '������');
SELECT * FROM SAM02;
-- <���� 1>
DROP TABLE DEPT01;
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;
SELECT * FROM DEPT01;

DELETE FROM DEPT01 WHERE DEPTNO = 40;
COMMIT;
DELETE FROM DEPT01 WHERE DEPTNO = 30;
SAVEPOINT C1;
DELETE FROM DEPT01 WHERE DEPTNO = 20;
SAVEPOINT C2;
DELETE FROM DEPT01 WHERE DEPTNO = 10;

ROLLBACK TO C2;
ROLLBACK TO C1;
ROLLBACK;

DESC DEPT;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;      -- ���� ���� ǥ��
-- � �÷����� specific�ϰ� �˰� ������
SELECT * FROM USER_CONS_COLUMNS;

DROP TABLE EMP04;
CREATE TABLE EMP04(
EMPNO NUMBER(4) NOT NULL,
ENAME VARCHAR2(10) NOT NULL,
JOB VARCHAR2(9),
DEPTNO NUMBER(2));

DESC EMP04;

INSERT INTO EMP04 VALUES(NULL, NULL, '������', 30);

-- ���� 1)
CREATE TABLE userTABLE (
userNo NUMBER(5) PRIMARY KEY,
userId VARCHAR2(20) UNIQUE NOT NULL,
userPw NUMBER(20) NOT NULL,
userTel VARCHAR2(20) UNIQUE,
userMembership VARCHAR2(10) CHECK(userMembership IN ('gold', 'silver', 'bronze')),
userEmail VARCHAR2(20) UNIQUE,
userPoint NUMBER(8) DEFAULT 1000,
joinDate DATE DEFAULT SYSDATE);
SELECT * FROM USERTABLE;
DROP TABLE USERTABLE;
-- ���� 2)
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (1, 'id01', '1111', '010-1111-1111', 'gold', 'id01@aa.com');
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (2, 'id02', '1111', '010-1111-2222', 'silver', 'id02@aa.com');
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (3, 'id03', '1111', '010-1111-3333', 'bronze', 'id03@aa.com');
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (4, 'id04', '1111', '010-1111-4444', 'gold', 'id04@aa.com');
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (5, 'id05', '1111', '010-1111-5555', 'silver', 'id05@aa.com');
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (6, 'id06', '1111', '010-1111-6666', 'bronze', 'id06@aa.com');
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (7, 'id07', '1111', '010-1111-7777', 'gold', 'id07@aa.com');
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (8, 'id08', '1111', '010-1111-8888', 'silver', 'id08@aa.com');
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (9, 'id09', '1111', '010-1111-9999', 'bronze', 'id09@aa.com');
insert into userTable (userNo, userId, userPw, userTel, userMembership, userEmail) values (10, 'id10', '1111', '010-1111-0000', 'gold', 'id10@aa.com');
commit;

-- ���� 3)
-- 3-1)
SELECT * FROM USERTABLE WHERE userNO>=5;

-- 3-2)
SELECT * FROM USERTABLE WHERE userNO BETWEEN 3 and 7;

-- 3-3)
SELECT * FROM USERTABLE WHERE userTEL LIKE ('%5555');

-- 3-4)
SELECT AVG(USERPOINT) FROM USERTABLE GROUP BY USERMEMBERSHIP HAVING USERMEMBERSHIP = 'gold';

-- 3-5)
UPDATE USERTABLE SET JOINDATE = TO_DATE('2019/10/28/','yyyy/mm/dd/') WHERE USERID = 'id03';

-- 3-6)
UPDATE USERTABLE SET USERPOINT = USERPOINT*3 WHERE USERMEMBERSHIP = 'gold';

-- 3-7)
UPDATE USERTABLE SET USERPW = '2222' WHERE USERID = 'id08';

-- 3-8)
UPDATE USERTABLE SET USERMEMBERSHIP = 'silver' WHERE USERPOINT >=1000 and USERMEMBERSHIP = 'bronze';

-- 3-9)
DELETE FROM USERTABLE WHERE USERNO = 5;

-- ���� 1)
CREATE TABLE BOOK (
BOOKID NUMBER(5) PRIMARY KEY,
BOOKNAME VARCHAR2(50),
PUBLISHER VARCHAR2(50),
PRICE NUMBER(10));

-- ���� 2)
CREATE TABLE CUSTOMER(
CUSTOMERID NUMBER(5) PRIMARY KEY,
NAME VARCHAR2(20),
ADDRESS VARCHAR2(50),
PHONE VARCHAR(20));

-- ���� 3)
CREATE TABLE ORDERS(
ORDERID NUMBER(5) PRIMARY KEY,
CUSTOMERID NUMBER(5) REFERENCES CUSTOMER(CUSTOMERID),
BOOKID NUMBER(5) REFERENCES BOOK(BOOKID),
SALEPRICE NUMBER(10),
ORDERDATE DATE);

-- ������ �Է�

insert into book values (1, '�౸�ǿ���', '�½�����', 7000);
insert into book values (2, '�౸�ƴ¿���', '������', 13000);
insert into book values (3, '�౸������', '���ѹ̵��', 22000);
insert into book values (4, '�������̺�', '���ѹ̵��', 35000);
insert into book values (5, '�ǰܱ���', '�½�����', 6000);
insert into book values (6, '�����ܰ躰���', '�½�����', 6000);
insert into book values (7, '�߱����߾�', '�̻�̵��', 20000);
insert into book values (8, '�߱�����Ź��', '�̻�̵��', 13000);
insert into book values (9, '�ø����̾߱�', '�Ｚ��', 7500);
insert into book values (10, '�ø���è�Ǿ�', '�Ǿ', 13000);

insert into customer values (1, '������', '���� ��ü����', '010-0000-0000');
insert into customer values (2, '�迬��', '���ѹα� ����', '010-1111-1111');
insert into customer values (3, '��̶�', '���ѹα� ������', '010-2222-2222');
insert into customer values (4, '�߽ż�', '�̱� �ػ罺', '010-4444-4444');
insert into customer values (5, '�ڼ���', '���ѹα� ����', '010-5555-5555');

insert into orders values (1, 1, 1, 6000, '2014-07-01');
insert into orders values (2, 1, 3, 21000, '2014-07-03');
insert into orders values (3, 2, 5, 8000, '2014-07-03');
insert into orders values (4, 3, 6, 6000, '2014-07-04');
insert into orders values (5, 4, 7, 20000, '2014-07-07');
insert into orders values (6, 1, 2, 12000, '2014-07-07');
insert into orders values (7, 4, 8, 13000, '2014-07-07');
insert into orders values (8, 3, 10, 12000, '2014-07-08');
insert into orders values (9, 2, 10, 7000, '2014-07-09');
insert into orders values (10, 3, 8, 13000, '2014-07-10');

commit;
SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

-- ���� 4)
SELECT BOOKNAME FROM BOOK WHERE BOOKID =1;

-- ���� 5)
SELECT BOOKNAME FROM BOOK WHERE PRICE >= 20000;

-- ���� 6)
SELECT DISTINCT PUBLISHER FROM BOOK;
SELECT PUBLISHER FROM BOOK GROUP BY PUBLISHER;

-- ���� 7)
SELECT SUM(SALEPRICE) "���Ǹž�" FROM ORDERS;

-- ���� 8)
SELECT SUM(SALEPRICE) FROM ORDERS WHERE CUSTOMERID = (SELECT CUSTOMERID FROM CUSTOMER WHERE NAME = '������'); 

SELECT SUM(SALEPRICE) FROM ORDERS GROUP BY CUSTOMERID HAVING CUSTOMERID = (SELECT CUSTOMERID FROM CUSTOMER WHERE NAME = '������'); 

SELECT SUM(SALEPRICE)
FROM customer c
JOIN orders o ON c.customerid = o.customerid WHERE c.NAME = '������';

-- ���� 9)
SELECT COUNT(*) "���� ���� ��"
FROM customer c
JOIN orders o ON c.customerid = o.customerid WHERE c.NAME = '������';

-- ���� 10)
SELECT ORDERID, CUSTOMERID, BOOKID, SALEPRICE FROM ORDERS WHERE ORDERDATE 
BETWEEN TO_DATE('2014/07/04','yyyy/mm/dd') and 
TO_DATE('2014/07/07','yyyy/mm/dd');

-- ���� 11)
SELECT c.NAME FROM CUSTOMER c LEFT OUTER JOIN ORDERS USING(CUSTOMERID) WHERE ORDERID IS NULL; 

SELECT NAME FROM CUSTOMER
WHERE CUSTOMERID
NOT IN (SELECT DISTINCT CUSTOMERID FROM ORDERS); 

-- ���� 12)
SELECT COUNT(DISTINCT PUBLISHER) "���ǻ� ��" FROM BOOK WHERE BOOKID IN
(SELECT BOOKID
FROM customer c
JOIN orders o ON c.customerid = o.customerid WHERE c.NAME = '������'); 

SELECT COUNT(DISTINCT PUBLISHER) "���ǻ� ��" FROM BOOK b JOIN (SELECT *
FROM customer c
JOIN orders o ON c.customerid = o.customerid WHERE c.NAME = '������') USING(BOOKID);

-- ���� 13)
SELECT * FROM ORDERS o JOIN CUSTOMER c USING(CUSTOMERID);
SELECT NAME, SUM(SALEPRICE) FROM ORDERS o JOIN CUSTOMER c USING(CUSTOMERID) GROUP BY NAME;
SELECT name, SUM(SALEPRICE) FROM ORDERS o JOIN CUSTOMER c USING(CUSTOMERID) GROUP BY CUSTOMERID, name; 
-- �׷���̸� �ΰ��� �÷��� �������� ���´ٸ� �ΰ��� �÷��� �׷��� �������μ� �����Ѵ�. �������� ����!

select * from CUSTOMER;

-- ����13-1)
SELECT NAME, SUM(SALEPRICE) FROM ORDERS o JOIN CUSTOMER c USING(CUSTOMERID) GROUP BY NAME;

-- ����13-2)
SELECT NAME, NVL(SUM(SALEPRICE), 0) FROM ORDERS o FULL OUTER JOIN CUSTOMER c USING(CUSTOMERID) GROUP BY NAME;
