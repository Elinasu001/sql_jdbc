-- 주석문 : 한 줄 주석적을 때는 이렇게 씁니다.
/*
	여러 줄 주석을 사용할 땐 이렇게 씁니다.
*/

/*
 * <SELECT>
 * 데이터를 조회하거나 검색할 때 사용하는 명령어
 * 
 * [표현법]
 * 
 * SELECT 
 * 	       조회하고자 하는 컬럼
 * 		 , 조회하고자 하는 컬럼 
 * 		 , 조회하고자 하는 컬럼
 * 	  FROM
 * 		   테이블명;
 * 
 * SELECT 문의 결과는 행 단위로 조회됨
 * 
 * - ResultSet : 조회된 행들의 집합 // SELECT문을 통해 조회된 데이터 결과물을 의미함
 * 
 */
-- EMPLOYEE 테이블에서 모든 컬럼을 전부 다 조회하겠다.
SELECT * FROM EMPLOYEE; -- 이 방법은 사용해선 안됨
-- * 사용 시 성능에 영향을 끼침

-- ResultSet 웬만하면 이렇게 사용하는 걸 권장합니다.[v] _ 키워드는 왼쪽으로 !
SELECT 
	    EMP_NAME
	  , EMAIL
	  , SALARY
  FROM
	    EMPLOYEE;
-- ResultSet
SELECT emp_name, email, salary FROM employee; 

-- 명령어, 키워드, 테이블명, 컬럼명은 대/소문자를 가리지않음
-- 소문자로 작성을 해도 잘 독장을 하지만 대문자로 작성하는 습관을 들이는 것이 좋음

-- 실습문제
-- 1. JOB 테이블에서 JOB_CODE, JOB_NAME 컬럼을 조회하세요.
SELECT
		JOB_CODE
	  , JOB_NAME
   FROM 
		JOB;

-- 2. JOB 테이블에서 직급명만 조회되게 SELECT문을 작성해보세요.
SELECT
	    JOB_NAME
   FROM 
		JOB;
-- 3. DEPARTMENT 테이블에서 DEPT_ID, DEPT_TITLE, LOCATION_ID 컬럼을 조회하세요.
SELECT
       DEPT_ID
     , DEPT_TITLE
     , LOCATION_ID
  FROM
       DEPARTMENT;
-- 4. EMPLOYEE 테이블에서 EMP_NAME, EMAIL, PHONE 컬럼을 조회하세요.
SELECT
       EMP_NAME
     , EMAIL
     , PHONE
  FROM
       EMPLOYEE;
-- 5. EMPLOYEE 테이블에서 HIRE_DATE, EMP_NAME, SALARY 컬럼을 조회하세요.
SELECT
       HIRE_DATE
     , EMP_NAME
     , SALARY
  FROM
       EMPLOYEE;
-------------------------------------------------------------------------
/*
 * < 컬럼의 조회된 값을 통한 산술연산>
 * 컬럼들을 나열해서 조회를 할 때 산술연산(+, -, *, /)을 기술해서 결과를 조회할 수 있음
 */
-- EMPLOYEE 테이블로부터 직원명, 월급, 연봉(== 울급 X 12) 조회
-- 1. resultSet 2. 연산
SELECT
	   EMP_NAME
	 , SALARY
	 , SALARY * 12 + 400000
  FROM
  	   EMPLOYEE;

-- EMPOLYEE 테이블로부터 사원명, 월급, 보너스, 보너스를 포함한 연봉((월급 * 보너스 + 보너스) * 12) 조회
SELECT
       EMP_NAME
     , SALARY
     , BONUS
     , ((SALARY * BONUS + BONUS) * 12)
  FROM
       EMPLOYEE;
--> 산술연산 과정에서 NULL 값이 존재할 경우 산술연산의 결과도 NULL이 된다.

-- DATE => 년, 월, 일, 시, 분, 초
-- DATE 타입끼리의 연산 --> 근무 일수 (오늘날짜 입사일)
-- 현재 지금 시점의 날짜값 : SYSDATE

SELECT
       EMP_NAME
     , HIRE_DATE
     , SYSDATE - HIRE_DATE
  FROM
	   EMPLOYEE;
-- 결과값은 일 단위 --> 값이 지저분한 이유는 DATE 안에는 시/분/초가 포함되어있으므로
-- 시/분/초까지 연산을 수행해서 지저분하게 나옴
-------------------------------------------------------------------------
/*
 * <컬럼명에 별칭 부여하기>
 * [표현법] - 4가지 방법
 * 컬럼명 AS 별칭, 컬럼명 AS "별칭", 컬럼명 "별칭", 컬럼명 별칭
 * 
 * 별칭에 특수문자 또는 공백문자가 포함될 경우 반드시 "" 로 묶어줘야함.
 * AS 키워드는 달아도 되고 안달아도 됨.
 */
SELECT
	    EMP_NAME AS 사원명
	  , SALARY "급여 (월)"
   FROM
   	    EMPLOYEE;
-------------------------------------------------------------------------
/*
 * <리터럴>
 * 
 * 임의로 지정한 문자열('')을 SELECT 절에 기술하게 되면
 * ResultSet을 반환 받을 때 데이터를 붙여서 조회할 수 있음
 * 
 */
-- EMPOLYEE 테이블로부터 사원명, 급여
SELECT
       EMP_NAME
     , SALARY
     , '원' 단위
   FROM
        EMPLOYEE;

-------------------------------------------------------------------------
/*
 * <DISTINCT>
 * 
 * 조회하고자하는 컬럼 앞에 작성하여 중복된 값을 딱 한번만 조회하는 용도
 * 
 * 주의) SELECT에 DISTINCT 구문은 한 개만 사용이 가능
 */

SELECT
	    DEPT_CODE
   FROM 
   		EMPLOYEE;






