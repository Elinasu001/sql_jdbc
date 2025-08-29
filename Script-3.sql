---HOMEWORK1---
CREATE SEQUENCE EMPLOYEE
 START WITH 230;

INSERT
  INTO
  	   EMPLOYEE
       (
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , EMAIL
     , PHONE
     , DEPT_CODE
     , JOB_CODE
     , SAL_LEVEL
     , SALARY
     , BONUS
     , HIRE_DATE  
       )
VALUES
 	   (
	   SEQ_EID.NEXTVAL
	 , '홍길길'
	 , '631010-2653546'
	 , 'kth04@kh.or.kr'
	 , '01077607879'
	 , 'D9'
	 , 'J5'
	 , 'S4'
	 , 5000000
	 , 100
	 , SYSDATE
 	   );
COMMIT;
--DROP TABLE EMPLOYEE;
SELECT * FROM EMPLOYEE;