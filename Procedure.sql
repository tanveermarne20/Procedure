--Q1 .. pass joining_year along with exp 
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE EMP_EXPER(HIRE_YEAR NUMBER)
IS
 CURSOR EMP_CONTEXT
 IS
 SELECT 
 FIRST_NAME,
 LAST_NAME,
 ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12,2) AS TOTAL_EXPER
 FROM EMPLOYEES
 WHERE EXTRACT (YEAR FROM HIRE_DATE)=HIRE_YEAR;
 
 BEGIN
 FOR I IN EMP_CONTEXT
 LOOP
  DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.LAST_NAME||' '||I.TOTAL_EXPER);
 END LOOP;
 END;

EXECUTE EMP_EXPER(2005);

--=====================================================================================
SET SERVEROUTPUT ON
 CREATE OR REPLACE PROCEDURE PRO_1(HIRE_YEAR NUMBER) 
 IS
 CURSOR EMP_CUR 
 IS
 SELECT 
 FIRST_NAME,
 LAST_NAME,
 ROUND(MONTH_BETWEEN(HIRE_DATE)/12,2) AS TOTAL_EXPERIENCE
 FROM EMPLOYEES
 WHERE EXTRACT(YEAR FROM HIRE_DATE)=HIRE_YEAR;
BEGIN
  FOR I IN EMP_CUR
 LOOP
 DMBS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.LAST_NAME||' '||I.TOTAL_EXPERIENCE);
END LOOP
 END;

EXECUTE PRO_1(2006);


--Q2.. pass job_id , print manager details
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE EMP_JOB(JOBID VARCHAR2)
IS
CURSOR EMP_JOB_DET
IS
SELECT 
E.FIRST_NAME AS MANAGER_NAME,
COUNT(*) AS TOTAL_COUNT
FROM EMPLOYEES E JOIN EMPLOYEES M
ON(E.EMPLOYEE_ID=M.MANAGER_ID)
WHERE E.JOB_ID=JOBID
GROUP BY E.FIRST_NAME;

BEGIN
FOR I IN EMP_JOB_DET
LOOP
 DBMS_OUTPUT.PUT_LINE(I.MANAGER_NAME||' '||I.TOTAL_COUNT);
END LOOP;
END;

EXECUTE EMP_JOB('FI_MGR');



-- Q3.. pass department_id and year_of_joining , calculate their experiecne, print salary hike
