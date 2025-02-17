SELECT * FROM emp;
SELECT * FROM dept;
SELECT 10+10 from emp;      -- 튜플 개수만큼 출력
DESC dual;
SELECT 10+10 from DUAL;     -- 테스트하기에 좋음

SELECT hiredate FROM emp;
--SUBSTR 사용예시
SELECT hiredate, SUBSTR(hiredate, 1, 2) as "연도", SUBSTR(hiredate, 4, 2) as "월", SUBSTR(hiredate,7, 2) as "일" FROM emp; -- 원본데이터를 앞에 뿌리면 확인이 용이

SELECT SYSDATE FROM dual;       -- 시스템시간 출력, 인서트에서 많이 쓰임;
SELECT ename, deptno, DECODE(deptno, 10, 'ACCOUNTING',
                                    20, 'RESEARCH',
                                    30, 'SALES',
                                    40, 'OPERATIONS')
                                    as dname FROM emp;  -- java의 case문 과 비슷
SELECT ename, deptno, CASE 
WHEN deptno=10 THEN 'ACCOUNTING'
WHEN deptno=20 THEN 'RESEARCH'
WHEN deptno=30 THEN 'SALES'
WHEN deptno=40 THEN 'OPERATIONS'
END as dname FROM emp;

-- 문제 1)
SELECT * FROM emp WHERE SUBSTR(hiredate,4,2)='10';      -- '10'이 아닌 10이라고 써도 된다. 단 03인 경우에는 '03'으로 하는게 안전

-- 문제 2)
SELECT * FROM emp WHERE SUBSTR(hiredate,1,2)='03';

-- 문제 3)
SELECT * FROM emp WHERE SUBSTR(ename,-1, 1)='기';        -- 음수 사용시 뒤에서부터 인덱싱, SUBSTR(ename, -1)만 해도 됨

-- 문제 4)
SELECT empno, ename, job, sal, DECODE(job, '부장', NVL(sal,0)*105/100,
                                            '과장', NVL(sal,0)*110/100,
                                            '대리', NVL(sal,0)*115/100,
                                            '사원', NVL(sal,0)*120/100)
                                            as "UPSAL" FROM emp;

-- 문제 5)
SELECT hiredate, TO_CHAR(hiredate,'YYYY/MON/DD') as CDATE FROM emp;

SELECT SUM(sal) FROM emp;                   
SELECT SUM(sal) FROM emp WHERE SAL>=500;        -- 그룹함수의 수행 범위를 조절해 줄 수 있음;

SELECT COUNT(job) FROM emp;
SELECT COUNT(DISTINCT job) FROM emp;        -- 중복제거

SELECT job FROM emp GROUP BY job;       
SELECT DISTINCT job FROM emp;           -- 둘은 다르다. 전자에는 각 그룹별 데이터들이 압축돼 있다.

SELECT deptno FROM emp GROUP BY deptno;     -- 그룹의 기준은 출력해줘야함.

-- 문제 1)
SELECT MAX(sal) as "Maximum", MIN(sal) as "Minimum", SUM(sal) as "Sum", ROUND(AVG(sal)) as "Average" FROM emp;

-- 문제 2)
SELECT job, MAX(sal) as "Maximum", MIN(sal) as "Minimum", SUM(sal) as "Sum", ROUND(AVG(sal)) as "Average" FROM emp GROUP BY job;

-- 문제 3)
SELECT job, COUNT(*) as "직원수" FROM emp GROUP BY job;

-- 문제 4)
SELECT COUNT(*) FROM emp WHERE mgr is not null;
--SELECT COUNT(MGR) FROM EMP;

-- 문제 5)
SELECT MAX(sal) - MIN(sal) as "차액" FROM emp;

-- 문제 6)
SELECT job, MIN(sal) as "최저급여" FROM emp GROUP BY job HAVING MIN(sal)>=500 ORDER BY MIN(sal) DESC;      -- WHERE절에서는 그룹함수 사용 불가

-- 문제 7)
SELECT deptno, COUNT(*) as "Number Of People", ROUND(AVG(sal),2) as "Sal" FROM emp 
GROUP BY deptno ORDER BY deptno ASC;

-- 문제8)
-- SELECT deptno, dept.dname, dept.loc, COUNT(*) as "Number Of People", ROUND(AVG(sal),2) as "Sal" FROM emp GROUP BY deptno;
-- 이렇게는 못 쓴다.
SELECT DECODE(deptno, 10, '경리부',
                            20, '인사부',
                            30, '영업부',
                            40, '전산부') as "Dname"
,DECODE(deptno, 10, '서울',
                20, '인천',
                30, '용인',
                40, '수원') as "Location", 
COUNT(*) as "Number Of People", ROUND(AVG(sal),2) as "Sal" FROM emp GROUP BY deptno; --HAVING COUNT(*)>=1;

SELECT e.ename, deptno
FROM emp e, dept d
WHERE e.deptno=d.deptno
AND e.ename='김사랑';      -- deptno가 어느 테이블 멤버인지 모호하여 오류

SELECT e.*, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno=d.deptno
AND e.ename='김사랑';

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

SELECT *                                -- 두 테이블의 모든 컬럼 표기
FROM dept01 LEFT OUTER JOIN DEPT02     -- outer은 생략 가능
ON dept01.deptno = dept02.deptno;

SELECT * 
FROM dept01 RIGHT OUTER JOIN DEPT02     -- LEFT JOIN과 차이 : LEFT JOIN은 DEPT01이 기준, RIGHT는 DEPT02가 기준
ON dept01.deptno = dept02.deptno;

SELECT * 
FROM dept01 FULL OUTER JOIN DEPT02    
ON dept01.deptno = dept02.deptno;

SELECT * 
FROM dept01 INNER JOIN DEPT02    
ON dept01.deptno = dept02.deptno;

SELECT * FROM dept01 d1, dept02 d2 WHERE d1.deptno = d2.deptno;     -- 위의 것과 결과가 같다

SELECT ename, dname
FROM emp Natural Join dept;     -- 내추럴 조인, 두 테이블에 동일한 형식을 갖는 컬럼이 반드시 하나만 존재해야함

SELECT E1.EMPNO AS "사원 코드", E1.ENAME AS "사원 이름",
E1.MGR AS "관리자 코드", E2.ENAME AS "관리자 이름", E2.mgr
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO
ORDER BY E2.MGR DESC, E1.MGR, E1.EMPNO;

-- 문제 1)
SELECT ename, hiredate FROM emp e, dept d
WHERE  e.deptno = d.deptno AND d.dname = '경리부';

SELECT ename, hiredate FROM EMP e INNER JOIN DEPT d
ON e.deptno = d.deptno WHERE d.dname = '경리부';

-- 문제 2)
SELECT ename, sal FROM emp e, dept d
WHERE  e.deptno = d.deptno AND d.loc = '인천';

SELECT ename, sal FROM EMP e INNER JOIN DEPT d
ON e.deptno = d.deptno WHERE d.loc = '인천';

-- 문제 1)
SELECT * FROM EMP WHERE job = (SELECT job FROM EMP WHERE ename = '김사랑');

-- 문제 2)
SELECT ename, sal FROM EMP WHERE sal>= (SELECT sal FROM EMP WHERE ename = '김사랑');

-- 문제 3)
SELECT ename, sal FROM EMP WHERE deptno = (SELECT deptno FROM dept WHERE dept.loc = '용인');

-- 문제 4)
SELECT ename, sal FROM EMP WHERE mgr = (SELECT empno FROM EMP WHERE emp.ename = '장동건');

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
WHERE deptno=30);           -- 위와동일

-- 문제 5)
SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp e2 WHERE e2.deptno = emp.deptno);             -- 상관 서브쿼리

SELECT e1.*
FROM emp e1
JOIN (
    SELECT deptno, MAX(sal) AS max_sal
    FROM emp
    GROUP BY deptno
) e2 ON e1.deptno = e2.deptno AND e1.sal = e2.max_sal;

SELECT * FROM EMP WHERE sal IN(SELECT MAX(SAL) FROM emp GROUP BY deptno);

-- 문제 6)
SELECT deptno, dname, loc FROM dept d WHERE d.deptno IN 
(SELECT e.deptno FROM EMP e WHERE job = '과장');

-- 문제 7)
SELECT ename, sal, job FROM EMP WHERE sal>ALL(SELECT sal FROM emp WHERE job = '과장');

-- 문제 8)
SELECT ename, sal, job FROM EMP WHERE sal>ANY(SELECT sal FROM emp WHERE job = '과장');

CREATE TABLE EMP01(EMPNO NUMBER(4), ENAME VARCHAR2(20), HEIGHT NUMBER(4,1), ADDRESS VARCHAR2(200), PHONE VARCHAR2(20));


