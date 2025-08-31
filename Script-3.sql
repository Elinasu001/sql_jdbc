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
-------------------------------------------------------------
---HOMEWORK2---
CREATE SEQUENCE SEQ_PLANT
 START WITH 1;

CREATE TABLE TB_PLANT(
	PLANT_ID NUMBER PRIMARY KEY,
    PLANT_NAME NVARCHAR2(30) NOT NULL,
    PLANT_TYPE NVARCHAR2(30) NOT NULL
);

INSERT
  INTO
       TB_PLANT
VALUES
       (
       SEQ_PLANT.NEXTVAL
     , '몬스테라'
     , '열대관엽식물'
       );
SELECT * FROM TB_PLANT;
----------------------------------------------------
SELECT
       PLANT_ID
     , PLANT_NAME
     , PLANT_TYPE
 FROM
      TB_PLANT
ORDER
   BY 
      PLANT_ID;

----------------------------------------------------
---HOMEWORK3---
CREATE TABLE TB_EVENT(
	EVENT_ID NUMBER PRIMARY KEY,
	TITLE VARCHAR2(255) NOT NULL,
	DESCRIPTION CLOB,
	START_DATE DATE NOT NULL,
	END_DATE DATE NOT NULL,
	REWARD_POINT NUMBER NOT NULL
);

CREATE SEQUENCE SEQ_EVENT START WITH 1;

INSERT
  INTO
       TB_EVENT
VALUES
       (
       SEQ_EVENT.NEXTVAL
     , '아침 6시 기상하고 인증하기!'
     , '매일 아침에 함꼐 일찍 기상하고 더 의미있는 하루를 시작을 같이 만들어가요!'
     , TO_DATE('2025-09-01','YYYY-MM-DD')
     , TO_DATE('2025-09-07','YYYY-MM-DD')
     , 500
       );
SELECT * FROM TB_EVENT;
----------------------
SELECT
       EVENT_ID
     , TITLE
     , DESCRIPTION
     , START_DATE
     , END_DATE
     , REWARD_POINT
  FROM
       TB_EVENT
 ORDER
    BY
       START_DATE;
COMMIT;
SELECT * FROM TB_EVENT;