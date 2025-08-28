-- QUIZ --

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 직급명, 근무 국가명을 조회해주세요!
SELECT * FROM EMPLOYEE; --														DEPT_CODE(D)	JOB_CODE(J)		
SELECT * FROM LOCATION; -- NATIONAL_CODE(KO)	LOCAL_CODE(L) 
SELECT * FROM NATIONAL; -- NATIONAL_CODE(KO)					=> NATIONAL_NAME
SELECT * FROM DEPARTMENT; -- 				 	LOCATION_ID(L)					DEPT_ID(D)
SELECT * FROM JOB;--																			JOB_CODE(J)

SELECT
	   EMP_NO			--EMP
     , EMP_NAME
     , DEPT_TITLE		--DE
     , JOB_NAME			--JOB
     , NATIONAL_NAME	--NA
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING(JOB_CODE)
  JOIN
       LOCATION ON(LOCATION_ID = LOCAL_CODE)
  JOIN 
       NATIONAL USING(NATIONAL_CODE)
 WHERE
	   NATIONAL_NAME = '한국';

------------------------------------------------------------------------------------
/*
   - 동일한 기능에 한국 / 일본 / 중국 등 값만 바꿀 경우 뷰를 고려 해보기
	< VIEW 뷰 > --> 논리적인 가상테이블
	
	SELECT문 저장하는 객체
*/

/*
 	1. VIEW 생성
 	
 	 [ 표현법 ]
 	 CREATE VIEW 뷰이름 (테이블인지 모르니 VW_이름)
 	     AS 서브쿼리;
 */

CREATE OR REPLACE VIEW VW_EMPLOYEE -- OR REPLACE란? 만약 기존 쿼리문에 SALARY을 추가 하고 싶다면? 굳이 DROP 필요 없이 갱신 할 수 있다.
    AS SELECT  
	      	   EMP_NO			--EMP
		     , EMP_NAME
		     , SALARY			-- 나중 추가 : OR REPLACE적용해주기
		     , DEPT_TITLE		--DE
		     , JOB_NAME			--JOB
		     , NATIONAL_NAME	--NA
		  FROM
		       EMPLOYEE
		  JOIN
		       DEPARTMENT ON(DEPT_CODE = DEPT_ID)
		  JOIN
		       JOB USING(JOB_CODE)
		  JOIN
		       LOCATION ON(LOCATION_ID = LOCAL_CODE)
		  JOIN 
		       NATIONAL USING(NATIONAL_CODE);

SELECT * FROM VW_EMPLOYEE;

-- 한국에서 근무하는 사원 조회
SELECT 
  	   *
  FROM
       VW_EMPLOYEE
 WHERE   
       NATIONAL_NAME = '한국';
-- 일본에서 근무하는 사원 조회
SELECT 
  	   *
  FROM
       VW_EMPLOYEE
 WHERE   
       NATIONAL_NAME = '일본';
-- 중국에서 근무하는 사원 조회
SELECT 
  	   *
  FROM
       VW_EMPLOYEE
 WHERE   
       NATIONAL_NAME = '중국';
-- 뷰의 장점 : 쿼리문이 엄청 긴게 필요할 때 그때그때 작성하면 힘들다...
-- 			 딱 한번 뷰로 만들어주면 그때부터는 뷰를 사용해서 간단하게 조회할 수 있다. => 생산성 향상!


-- 해당 게정이 가지고 있는 VIEW에 대한 정보를 조회할 수 있는 데이터 딕셔너리
SELECT * FROM USER_VIEWS; --> TEXT 컬럼 보면 VIEW 만들때 서브쿼리를 들고 있는 걸 볼 수 있다. 즉, 실제 결과를 저장한게 아니라 쿼리문만 ! 호출 하면 이 쿼리문을 돌려준다.
						  --> 근데, 이론적으로 얘기하자면 "논리적인 가상테이블"!! => SELECT문 저장하는 객체
-- 정리정리~
-- 뷰는 논리적인 가상테이블이다. 즉, 실질적으로 데이터를 저장하고 있지 않지만 ,
--							쿼리문을 TEXT 형태로 저장해놓는다.

-------------------------------------------------------------------------------------------------------
/*
   *상단 쿼리문 참고*
	CREATE OR REPLACE VIEW 뷰이름
	    AS 서브쿼리;
	   
	뷰 생성 시 기존에 중복된 이름의 뷰가 존재한다면 갱신(변경)해주고
	없다면 새로운 뷰를 생성해줌
*/
      
-- 사원의 사원명, 연봉, 근무년수를 조회할 수 있는 SELECT문 정의
SELECT
       EMP_NAME
     , SALARY * 12
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) -- 이것도 실수 할 수 있으니 뷰로 만들어 놓자!
 FROM
       EMPLOYEE;

/*   
	뷰 생성 시 SELECT 절에 함수 또는 산술 연산식이 기술되어있는 경우 뷰 생성이 불가능하기 때문에
	반드시 '별칭을' 작성해주어야 함
*/ 
-- ERROR 쿼리문
CREATE OR REPLACE VIEW VW_EMP -- (ERROR)안됨 WHY?
    AS (SELECT
		       EMP_NAME
		     , SALARY * 12
		     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) -- 산술식은 조회할 때 컬럼명으로 들어갈 수 없다.
		 FROM															 -- 이럴경우는 반드시 별칭을 지어줘야 한다.
		       EMPLOYEE);
-- 올바른 쿼리문
CREATE OR REPLACE VIEW VW_EMP
    AS (SELECT
		       EMP_NAME
		     , SALARY * 12 AS "연봉"
		     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
		 FROM															
		       EMPLOYEE);


SELECT * FROM VW_EMP;

--별칭 부여 방법 두 번째! (모든 컬럼에다가 별칭을 지어주어야함 아니면 안돌아감)
CREATE OR REPLACE VIEW VW_EMP(사원명, 연봉, 근무년수)
    AS
SELECT
       EMP_NAME
     , SALARY * 12 AS "연봉"
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
 FROM															
       EMPLOYEE;

SELECT * FROM VW_EMP;

-- 뷰 삭제하기
DROP VIEW VW_EMP;
-----------------------------------------------------------------------------------------





      