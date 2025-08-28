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

CREATE VIEW VW_EMPLOYEE
    AS SELECT  
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























      