/*
	< SUB QUERY 서브 쿼리 > ★★
	
	하나의 메인 SQL(SLELCT, INSERT, UPDATE, DELETE, CREATE, ... ) 안에 포함된
	또 하나의 SELECT문
	
	MAIN SQL문의 보조역할을 하는 쿼리문
*/

-- 간단 서브쿼리 예시
SELECT * FROM EMPLOYEE;

-- 박세혁 사원과 부서가 같은 사원들의 사원명 조회

-- 1) 먼저 박세혁 사원의 부서코드 조회
SELECT
	   DEPT_CODE
 FROM 
  	   EMPLOYEE
 WHERE
       '박세혁' = EMP_NAME;
-- 2) 부서코드가 D5인 사원드르이 사원명 조회
SELECT 
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5';
-- 3) 위 두 단계를 하나의 쿼리문으로 합치기 WHY? 박세혁의 부서코드가 바뀔 때마다 D5를 변경해줘야 되기 때문이다.
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = (SELECT
	   					   DEPT_CODE
					 FROM 
					  	   EMPLOYEE
					 WHERE
					       '박세혁' = EMP_NAME);
-- 4) 서브 쿼리 : 메인 쿼리를 사용할 때 보조의 역할로 사용하는 쿼리
-- 서브쿼리 잘 다루는 것이 중요★
--------------------------------------- 예시)------------------------------------
-- 간단한 서브쿼리 예시 두 번째

-- 전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번, 사원명을 조회
-- 1) 전체 사원의 평균 급여 구하기
SELECT
       AVG(SALARY)
  FROM
       EMPLOYEE; -- 대략 3,131,140원
-- 2) 급여가 평균 : 3,131,140원 이상인 사람들의 사번, 사원명
SELECT
       EMP_ID
     , EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3131140;
-- 3) 위의 두 단계를 합치기
SELECT
       EMP_ID
     , EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       SALARY >= (SELECT
				         AVG(SALARY)
				    FROM
				         EMPLOYEE);
-------------------------------------------------------------------------------





























       
       
       
       
       
       
       