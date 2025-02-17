SELECT * FROM emp;
SELECT * FROM dept;
SELECT 10+10 from emp;      -- Ʃ�� ������ŭ ���
DESC dual;
SELECT 10+10 from DUAL;     -- �׽�Ʈ�ϱ⿡ ����

SELECT hiredate FROM emp;
--SUBSTR ��뿹��
SELECT hiredate, SUBSTR(hiredate, 1, 2) as "����", SUBSTR(hiredate, 4, 2) as "��", SUBSTR(hiredate,7, 2) as "��" FROM emp; -- ���������͸� �տ� �Ѹ��� Ȯ���� ����

SELECT SYSDATE FROM dual;       -- �ý��۽ð� ���, �μ�Ʈ���� ���� ����;
SELECT ename, deptno, DECODE(deptno, 10, 'ACCOUNTING',
                                    20, 'RESEARCH',
                                    30, 'SALES',
                                    40, 'OPERATIONS')
                                    as dname FROM emp;  -- java�� case�� �� ���
SELECT ename, deptno, CASE 
WHEN deptno=10 THEN 'ACCOUNTING'
WHEN deptno=20 THEN 'RESEARCH'
WHEN deptno=30 THEN 'SALES'
WHEN deptno=40 THEN 'OPERATIONS'
END as dname FROM emp;

-- ���� 1)
SELECT * FROM emp WHERE SUBSTR(hiredate,4,2)='10';      -- '10'�� �ƴ� 10�̶�� �ᵵ �ȴ�. �� 03�� ��쿡�� '03'���� �ϴ°� ����

-- ���� 2)
SELECT * FROM emp WHERE SUBSTR(hiredate,1,2)='03';

-- ���� 3)
SELECT * FROM emp WHERE SUBSTR(ename,-1, 1)='��';        -- ���� ���� �ڿ������� �ε���, SUBSTR(ename, -1)�� �ص� ��

-- ���� 4)
SELECT empno, ename, job, sal, DECODE(job, '����', NVL(sal,0)*105/100,
                                            '����', NVL(sal,0)*110/100,
                                            '�븮', NVL(sal,0)*115/100,
                                            '���', NVL(sal,0)*120/100)
                                            as "UPSAL" FROM emp;

-- ���� 5)
SELECT hiredate, TO_CHAR(hiredate,'YYYY/MON/DD') as CDATE FROM emp;

SELECT SUM(sal) FROM emp;                   
SELECT SUM(sal) FROM emp WHERE SAL>=500;        -- �׷��Լ��� ���� ������ ������ �� �� ����;

SELECT COUNT(job) FROM emp;
SELECT COUNT(DISTINCT job) FROM emp;        -- �ߺ�����

SELECT job FROM emp GROUP BY job;       
SELECT DISTINCT job FROM emp;           -- ���� �ٸ���. ���ڿ��� �� �׷캰 �����͵��� ����� �ִ�.

SELECT deptno FROM emp GROUP BY deptno;     -- �׷��� ������ ����������.

-- ���� 1)
SELECT MAX(sal) as "Maximum", MIN(sal) as "Minimum", SUM(sal) as "Sum", ROUND(AVG(sal)) as "Average" FROM emp;

-- ���� 2)
SELECT job, MAX(sal) as "Maximum", MIN(sal) as "Minimum", SUM(sal) as "Sum", ROUND(AVG(sal)) as "Average" FROM emp GROUP BY job;

-- ���� 3)
SELECT job, COUNT(*) as "������" FROM emp GROUP BY job;

-- ���� 4)
SELECT COUNT(*) FROM emp WHERE mgr is not null;
--SELECT COUNT(MGR) FROM EMP;

-- ���� 5)
SELECT MAX(sal) - MIN(sal) as "����" FROM emp;

-- ���� 6)
SELECT job, MIN(sal) as "�����޿�" FROM emp GROUP BY job HAVING MIN(sal)>=500 ORDER BY MIN(sal) DESC;      -- WHERE�������� �׷��Լ� ��� �Ұ�

-- ���� 7)
SELECT deptno, COUNT(*) as "Number Of People", ROUND(AVG(sal),2) as "Sal" FROM emp 
GROUP BY deptno ORDER BY deptno ASC;

-- ����8)
-- SELECT deptno, dept.dname, dept.loc, COUNT(*) as "Number Of People", ROUND(AVG(sal),2) as "Sal" FROM emp GROUP BY deptno;
-- �̷��Դ� �� ����.
SELECT DECODE(deptno, 10, '�渮��',
                            20, '�λ��',
                            30, '������',
                            40, '�����') as "Dname"
,DECODE(deptno, 10, '����',
                20, '��õ',
                30, '����',
                40, '����') as "Location", 
COUNT(*) as "Number Of People", ROUND(AVG(sal),2) as "Sal" FROM emp GROUP BY deptno; --HAVING COUNT(*)>=1;

SELECT e.ename, deptno
FROM emp e, dept d
WHERE e.deptno=d.deptno
AND e.ename='����';      -- deptno�� ��� ���̺� ������� ��ȣ�Ͽ� ����

SELECT e.*, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno=d.deptno
AND e.ename='����';

CREATE TABLE DEPT01(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14));

INSERT INTO DEPT01 VALUES(10,'ACCOUNTING');
INSERT INTO DEPT01 VALUES(20,'RESEARCH');

CREATE TABLE DEPT02(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14));

INSERT INTO DEPT02 VALUES(10,'ACCOUNTING');
INSERT INTO DEPT02 VALUES(30,'SALES');

SELECT * FROM dept01;

SELECT * FROM dept02;

SELECT *                                -- �� ���̺��� ��� �÷� ǥ��
FROM dept01 LEFT OUTER JOIN DEPT02     -- outer�� ���� ����
ON dept01.deptno = dept02.deptno;

SELECT * 
FROM dept01 RIGHT OUTER JOIN DEPT02     -- LEFT JOIN�� ���� : LEFT JOIN�� DEPT01�� ����, RIGHT�� DEPT02�� ����
ON dept01.deptno = dept02.deptno;

SELECT * 
FROM dept01 FULL OUTER JOIN DEPT02    
ON dept01.deptno = dept02.deptno;

SELECT * 
FROM dept01 INNER JOIN DEPT02    
ON dept01.deptno = dept02.deptno;

SELECT * FROM dept01 d1, dept02 d2 WHERE d1.deptno = d2.deptno;     -- ���� �Ͱ� ����� ����

SELECT ename, dname
FROM emp Natural Join dept;     -- ���߷� ����, �� ���̺� ������ ������ ���� �÷��� �ݵ�� �ϳ��� �����ؾ���

SELECT E1.EMPNO AS "��� �ڵ�", E1.ENAME AS "��� �̸�",
E1.MGR AS "������ �ڵ�", E2.ENAME AS "������ �̸�", E2.mgr
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO
ORDER BY E2.MGR DESC, E1.MGR, E1.EMPNO;

-- ���� 1)
SELECT ename, hiredate FROM emp e, dept d
WHERE  e.deptno = d.deptno AND d.dname = '�渮��';

SELECT ename, hiredate FROM EMP e INNER JOIN DEPT d
ON e.deptno = d.deptno WHERE d.dname = '�渮��';

-- ���� 2)
SELECT ename, sal FROM emp e, dept d
WHERE  e.deptno = d.deptno AND d.loc = '��õ';

SELECT ename, sal FROM EMP e INNER JOIN DEPT d
ON e.deptno = d.deptno WHERE d.loc = '��õ';

-- ���� 1)
SELECT * FROM EMP WHERE job = (SELECT job FROM EMP WHERE ename = '����');

-- ���� 2)
SELECT ename, sal FROM EMP WHERE sal>= (SELECT sal FROM EMP WHERE ename = '����');

-- ���� 3)
SELECT ename, sal FROM EMP WHERE deptno = (SELECT deptno FROM dept WHERE dept.loc = '����');

-- ���� 4)
SELECT ename, sal FROM EMP WHERE mgr = (SELECT empno FROM EMP WHERE emp.ename = '�嵿��');

SELECT ename, sal, deptno FROM emp WHERE deptno IN(SELECT DISTINCT deptno FROM emp WHERE sal>=400);

SELECT ename, sal
FROM emp
WHERE sal > ALL (SELECT sal
FROM emp
WHERE deptno=30);

SELECT ename, sal
FROM emp
WHERE sal > (SELECT MAX(sal)
FROM emp
WHERE deptno=30);           -- ���͵���

-- ���� 5)
SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp e2 WHERE e2.deptno = emp.deptno);             -- ��� ��������

SELECT e1.*
FROM emp e1
JOIN (
    SELECT deptno, MAX(sal) AS max_sal
    FROM emp
    GROUP BY deptno
) e2 ON e1.deptno = e2.deptno AND e1.sal = e2.max_sal;

SELECT * FROM EMP WHERE sal IN(SELECT MAX(SAL) FROM emp GROUP BY deptno);

-- ���� 6)
SELECT deptno, dname, loc FROM dept d WHERE d.deptno IN 
(SELECT e.deptno FROM EMP e WHERE job = '����');

-- ���� 7)
SELECT ename, sal, job FROM EMP WHERE sal>ALL(SELECT sal FROM emp WHERE job = '����');

-- ���� 8)
SELECT ename, sal, job FROM EMP WHERE sal>ANY(SELECT sal FROM emp WHERE job = '����');

CREATE TABLE EMP01(EMPNO NUMBER(4), ENAME VARCHAR2(20), HEIGHT NUMBER(4,1), ADDRESS VARCHAR2(200), PHONE VARCHAR2(20));


