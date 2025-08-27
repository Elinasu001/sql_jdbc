/*
	함수 <FUNCTION>
	
	자바로 따지면 메소드
	전달된 값을 가지고 계산된 결과를 반환해준다
	
	- 단일행 함수 : N개의 값을 읽어서 N개의 결과를 반환(매 행마다 함수 결과 반환)
	- ★★★★그룹 함수★★★★ :: N개의 값을 읽어서 1개의 결과를 반환(그룹별로 함수 결과 반환)
	
*/
------------------------- <단일행 함수> -------------------------
SELECT
 	   SALARY
 	 , LENGTH(SALARY)
-- 	 , SUM(SALARY) -- LENGTH 랑 SUM 같이 사용 안됨, resultSet에 들어갈 수 없음.
  FROM
       EMPLOYEE;

-- 단일행 함수와 그룹함수는 함께 사용할 수 없음 : 결과 행의 개수가 다릑 떄문이다.★★★★ 




/*
	<문자열과 관련된 함수>
	LENGTH / LENGTHB
	
	STR : '문자열' // 문자열이 들어가 있는 컬럼
	
	EX) 자바 : "equals".length(); <-- 얘랑 똑같음
	
	- LENGTH(STR) : 전달된 문자열의 글자 수 반환
	- LENGTHB(STR) : 전달된 문자열의 바이트 수 반환
	
	결과는 NUMBER 타입 (오라클은 정수 실수 구분 없이 전부 NUMBER TYPE이다.)
	
	한글 : 'ㄱ', 'ㅣ', '강' => 한글자당 3Byte
	숫자, 영어, 특수문자 => 한글자당 1Byte
*/
-- 테이블 아닌
--SELECT 
--       LENGTH('오라클!')	
--     , LENGTHB('오라클!')
--  FROM 
--       EMPLOYEE;

-- 순수하게 내가 작성한 것만 출력 하고 싶을 경우
SELECT 
       LENGTH('오라클!')	
     , LENGTHB('오라클!')
  FROM 
       --EMPLOYEE;
       DUAL; --가상테이블(DUMMY TABLE)
       
       
 SELECT
         EMAIL
       , LENGTH(EMAIL)
   FROM
         EMPLOYEE;
 /*
   INSTR
   
  	- INSTR(STR) : 문자열로부터 특정 문자의 위치값 반환
  	
  	INSTR(STR, '특정 문자', 찾을 위치의 시작값, 순번)
  	
  	결과값은 NUMBER타입으로 반환
  	찾을 위치의 시작값과 순번은 생략이 가능
  	
  	
  	찾을 위치의 시작값
  	1 : 앞에서부터 찾겠다.(기본값)
  	-1 : 뒤에서부터 찾겠다.
  */
 
SELECT
       INSTR('AABAACAABBAA', 'CAA')
  FROM
       DUAL; -- 6
     
SELECT
       INSTR('AABAACAABBAA', 'B', -1)
  FROM
       DUAL; -- 뒤에서부터 첫 번째 'B'가 앞에서부터 몇 번째인지 --10

SELECT
       INSTR('AABAACAABBAA', 'B', 1, 3)
  FROM
       DUAL; -- 앞에서부터 세 번째 'B'가 앞에서부터 몇 번째 인지 -- 10
       
SELECT
       INSTR(EMAIL, '@') "@의위치"
  FROM
       EMPLOYEE;

 --------------------------------------------------------
/*
	SUBSTR
	
	- SUBSTR(STR, POSITION, LENGTH) : 문자열부터 특전 문자열을 추출해서 반환
	
	- STR : '문자열' 또는 문자티입 컬럼 값
	- POSITION : 문자열 추출 시작위치값(POSITION번째 문자부터 추출) -> 음수도 가능
	- LENGTH : 추출할 문자 개수(생략 시 끝까지라는 의미)

*/
SELECT
       SUBSTR('KH정보교육원', 3)
  FROM
   	   DUAL; -- 정보교육원
   	   
SELECT
       SUBSTR('KH정보교육원', 3, 2)
  FROM
       DUAL; -- 정보
SELECT
       SUBSTR('KH정보교육원', -3, 2)
  FROM 
       DUAL; -- 교육
       
 -- EMPOLOYEE 테이블로부터 사원명과 이메일컬럼과 EMAIL컬럼값 중 아이디값만 추출해서 조회
SELECT
       EMP_NAME
     , EMAIL
     , SUBSTR(EMAIL, INSTR(EMAIL, '@') - 1)
  FROM
       EMPLOYEE;
 
 SELECT 
        *
   FROM
        EMPLOYEE;
     
SELECT
        EMP_NAME
      , SUBSTR(EMP_NO, 8, 1) -- 남/녀
   FROM
        EMPLOYEE;

-- 남성 사원들만 이름을 조회
SELECT 
        EMP_NAME
   FROM
        EMPLOYEE
  WHERE
        SUBSTR(EMP_NO, 8, 1) = '1';

 --------------------------------------------------------
/*
 	LPAD(LEFTPADDING) / RPAD(RIGHTPADDING)
 	
 	- LPAD / RPAD( STR, 최종적으로 반환할 문자의 길이(바이트), 패딩할 문자)
 	: 인자로 전달한 문자열에 임의의문자를 왼쪽 또는 오른쪽에 덧붙여서 N길이만큼의 문자열 반환
 	
 	-> 결과 값은 CHARACTER 타입으로 변환
 	   덧붙이고자 하는 문자는 생략 가능
 */
        
SELECT
       EMAIL
  FROM
       EMPLOYEE;

SELECT
        LPAD(EMAIL, 25)
   FROM 
        EMPLOYEE;

SELECT
        LPAD(EMAIL, 25, '!')
   FROM 
        EMPLOYEE;

SELECT 
        EMP_NAME
      , EMP_NO
  FROM
        EMPLOYEE; 
        
-- 정보를 띄울 경우 이름 성, 주민등록번호는 뒤 앞자리 1자리만 보여준다.
-- EMPLOYEE 테이블에서 모든 직원의 사원명과 주민등록번호 뒤 6자리를 마스킹 처리해서 조회하기
-- 예시 => 이** 621335-1******

SELECT
       SUBSTR(EMP_NAME, 1, 1)
     , SUBSTR(EMP_NO, 1, 8)
  FROM
       EMPLOYEE;
        
        
SELECT
       RPAD(SUBSTR(EMP_NAME, 1, 1), 4, '*')
     , RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
  FROM
       EMPLOYEE;

 --------------------------------------------------------
 /*    
    LTRIM / RTRIM
    
    - LTRIM / RTRIM (STR, 제거하고자하는 문자)
    : 문자열의 왼쪽 또는 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환
    
    -> 결과값은 CHARACTER 타입으로 반환
 */   
SELECT
 	   LTRIM('     K H')
  FROM 
       DUAL;-- K H
 
 SELECT
 	   LTRIM('123123KH123', '123')
  FROM 
       DUAL; -- KH123
 
--------------------------------------------------------     
/* 
   TRIM
   - TRIM(BOTH / LEADING / TRAILRING '제거하고자하는문자' FROM STR)
   : 문자열의 앞 / 뒤 / 양쪽에 있는 문자를 제거한 나머지 문자열을 반환
   
   -> 결과값은 CHARACTER
   BOTH / LEADING / TRAILING 은 생략 가능 참고로 생략 시 기본값은 BOTH
*/   
 
SELECT
        TRIM('        K    H ')
  FROM
        DUAL; -- BOTH
        
SELECT 
       TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL; -- 뒤
SELECT
       TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL; -- 앞
--------------------------------------------------------     
/*
   LOWER / UPPER / INITCAP
   
   - LOWER(STR)
   : 다 소문자로
   
   - UPPER(STR)
   : 다 대문자로
   
   - INITCAP(STR)
   : 각 단어마다 앞글자만 대문자로 변경
   
   -> 결과값은 모두 CHARACTER 타입으로 반환
  
 */       
SELECT
        LOWER('HELLO WORLD')
   FROM
        DUAL; -- hello world


SELECT
       UPPER('hello world')
  FROM
       DUAL; -- HELLO WORLD


SELECT 
       INITCAP('hello world')
  FROM
       DUAL; -- Hello World
 
       
--------------------------------------------------------  
/*
   CONCAT
   
   - CONCAT(STR1, STR2)
   : 전달된 두 개의 인자를 하나로 합친 결과를 반환
 
   -> 반환타입은 CHARACTER
 
 */       
       
SELECT CONCAT('경실련 하이텔', '정보교육원') FROM DUAL; -- 경실련 하이텔정보교육원

-------------------------------------------------------- 
/*
	REPLACE
	
	- REPLACE(STR, 찾을문자, 바꿀문자)
	: STR로부터 찾을문자를 찾아서 바꿀문자로 바꾼 문자열을 반환
	
	-> 결과값은 CHARACTER 타입
 */   

SELECT
       REPLACE('서울시 중구 남대문로 120 대일빌딩', '대일빌딩', '그레이츠 청계')
  FROM  
       DUAL; -- 서울시 중구 남대문로 120 그레이츠 청계 -- 대일빌딩 -> 그레이츠 청계 변경
       
SELECT
 	   EMAIL
 	 , REPLACE(EMAIL, 'kh.or.kr', 'iei.co.kr')
  FROM 
       EMPLOYEE;

-- 문자열 함수 끝 !
--------------------------------------------------------
/*
   MOD
   
   - MOD(NUMBER1, NUMBER2) : 두 수를 나눈 나머지값을 반환
   
   %를 모듈로 연산자
   
   
	** 기본 실수 자료형을 가지고 연산하지 말기 **
	** 자바 API 중에 실수 처리하는 따로 있거나 보통 DB단에서 처리하는게 좋음
*/
SELECT
       MOD(10, 3) -- 1
     , MOD(-10, 3)  -- -1
     , MOD(10.8, 3) -- 1.8
  FROM   
       DUAL;
--------------------------------------------------------
/*
   ROUND
   
   - ROUND(NUMBER, 위치) : 반올림 
  	
  	생략도 가능, 생략 시 기본값은 0
 
 */
SELECT
       ROUND(123.456) -- 123
     , ROUND(123.456, 1) -- 123.5
     , ROUND(123.345, 2) -- 123.35
     , ROUND(123.456, -1) -- 120
     , ROUND(123.456, -2) -- 100
 FROM 
       DUAL;
--------------------------------------------------------
/*
  FLOOR
  - FLOOR(NUMBER) 소수점 아래의 수를 무조건 버림처리해주는 함수
	
	
  CEIL
  - CEIL(NUMBER) 소수점 아래의 수를 무조건 올림처리해주는 함수
*/

SELECT
       FLOOR(123.45)
  FROM
       DUAL; -- 123

SELECT CEIL(123.456) FROM DUAL; -- 124s

SELECT
       FLOOR(123.45 * 10) / 10
  FROM
       DUAL; -- 123.4 (소수점 한자리만 구하고 싶을 경우)

-- 각 직원별로 고용일로부터 오늘까지의 근무 일수 조회 + 이름조회
SELECT
       EMP_NAME
     , CONCAT(FLOOR(SYSDATE - HIRE_DATE), '일') "근무일자"
  FROM
       EMPLOYEE; -- 4584.440810185185185185185185185185185185 -> 4584

       
SELECT
       EMP_NAME
     , CONCAT(FLOOR(SYSDATE - HIRE_DATE), '일') "근무일자"
  FROM
       EMPLOYEE
 WHERE
       FLOOR(SYSDATE - HIRE_DATE) > 365 * 17;

--------------------------s------------------------------
/*
	TRUNC
	- TRUNC(NUMBER, 위치) : 위치지정이 가능한 절삭처리 함수
	
	** 연산 안하고 버리는 거라 속도가 빠르다
*/
SELECT
       TRUNC(123.456, 2)
  FROM
        DUAL; -- 123.45

--------------------------------------------------------
/*
	< 날짜  관련 함수 >
	
	DATE 타입 : 년, 월, 일, 시, 분 초를 모두 포함한 자료형 [일반적으로 많이 사용]
	TIMESTAMP <- 얘는 나중에 [비일반적]
*/

SELECT
       SYSDATE -- 2025-08-26 10:40:51.000
     , SYSTIMESTAMP -- 2025-08-26 10:40:51.787 +0900
  FROM 
       DUAL;   


-- MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜사이의 개월 수 반환(NUMBER)
-- DATE2를 너무 멀게 잡아 버리면 음수가 나올수 있음
-- EMPLOYEE 테이블로부터 각 사원 사원명, 고용일로부터 근무일수, 근무개월 수 조회
SELECT
       EMP_NAME
     , FLOOR(SYSDATE - HIRE_DATE) || '일' AS "근무일수"
     , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "개월수"
  FROM
       EMPLOYEE; -- 이승철 4584일 150개월


-- ADD_MONTHS(DATE, NUMBER) : 특정날짜에 해당 숫자만큼의 개월 수를 더한 날짜(DATE로 반환)
SELECT
       ADD_MONTHS(SYSDATE, 4)
  FROM
       DUAL;-- 2025-12-26 10:49:31.000

       
       
-- NEXT_DAY(DATE, 요일) : 특정날짜에서 가장 가까운 요일을 찾아 그 날짜를 반환
SELECT
       NEXT_DAY(SYSDATE, '금요일') --2025-08-29 11:04:14.000
     , NEXT_DAY(SYSDATE, '금') -- 2025-08-29 11:05:37.000
     , NEXT_DAY(SYSDATE, 6) -- 1 : 일요일, 2: 월요일, 3 : 화요일 ,,, 7 : 토요일
  FROM
       DUAL; --2025-08-29 11:04:14.000
            
             
       
       
       
       
-- 언어 변경 ALTER SESSION SET NLS_LANGUAGE = AMERICAL // KOREAN

           
       
-- LAST_DATY(DATE) 날짜를 받아서 해당 날짜가 있는 달의 마지막날짜를 반환
SELECT
       LAST_DAY(SYSDATE) -- 2025-08-31 11:07:04.000
  FROM
       DUAL;


--------------------------------------------------------
/*
   ★★★★★ 활용도가 높다 ★★★★★
	EXTRACT : 년도 또는 월 또는 일정보를 추출해서 반환(NUMBER타입)
	- EXTRACT(YEAR FROM DATE) : 년도만 추출
	- EXTRACT(MONTH FROM DATE) : 월만 추출
	- EXTRACT(DAY FROM DATE) : 일만 추출
*/

-- EMPLOYEE 테이블에서 사원명 입사년도 입사월 입사일
SELECT 
       EMP_NAME
     , EXTRACT(YEAR FROM HIRE_DATE) AS "년도"
     , EXTRACT(MONTH FROM HIRE_DATE) AS "월"
     , EXTRACT(DAY FROM HIRE_DATE) AS "일"
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) -- 현재날짜 - 고용날짜
  FROM
       EMPLOYEE
 ORDER 
    BY
       "년도", "월", "일";
--------------------------------------------------------
/*
	< 형변환 함수>
	
	NUMBER / DATE => CHARACTER
	
	- TO_CHAR(NUMBER/DATE, 포맷) : 숫자 또는 날짜 데이터를 문자데이터타입으로 반환
*/
SELECT
       1234 -- 1,234
     , TO_CHAR(1234) -- 1234
     , TO_CHAR(1234, '00000') -- 자리수보다 큰 공간을 0으로 채움 -- 01234
     , TO_CHAR(1234, '99999') -- 자리수보다 큰 공간을 공백문자로 채움 -- 1234
     , TO_CHAR(1234, 'L00000') -- 설정된 나라 (LOCAL)의 화폐단위 -- ￦01234
     , TO_CHAR(1234, '$99999') --  $1234
     , TO_CHAR(12341234, 'L999,999,999,999,999') -- 쉼표 넣고 싶을 경우 -- ￦12,341,234
  FROM
       DUAL;
--------------------------------------------------------
-- DATE(년월일시분초) => CHARACTER -- 게시글 작성 때 많이 사용
SELECT
       SYSDATE -- 2025-08-26 11:19:25.000
     , TO_CHAR(SYSDATE) -- 25/08/26
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD') -- == JAVA SIMPLEDATEFORMAT -- 2025-08-26
     , TO_CHAR(SYSDATE, 'PM HH:MI:SS') -- PM 오전 / 오후 출력 -- 오전 11:20:34
     , TO_CHAR(SYSDATE, 'HH24:MI:SS') -- 24시간 표기형식 -- 11:21:18
     , TO_CHAR(SYSDATE, 'MON DY, YYYY') -- 월 요일 년도 --8월  화, 2025 
  FROM
       DUAL;
--------------------------------------------------------
-- 년도로 쓸 수 있느 포맷 Y2K문제
-- RR표기 은 0 ~49 : 2000년대, 50 ~99 : 1900년대
SELECT 
	   TO_CHAR(SYSDATE, 'YYYY') -- 2025
	 , TO_CHAR(SYSDATE, 'RRRR') -- 2025
	 , TO_CHAR(TO_DATE('26-95', 'DD-YY'), 'YYYY') -- 2095
	 , TO_CHAR(TO_DATE('26-95', 'DD-RR'), 'YYYY') -- 1995
	 , TO_CHAR(SYSDATE, 'YEAR') -- TWENTY TWENTY-FIVE
  FROM
       DUAL;

-- 월에 쓸수이는 포맷
SELECT
       TO_CHAR(SYSDATE, 'MM') -- 08
     , TO_CHAR(SYSDATE, 'MON') -- 8월
     , TO_CHAR(SYSDATE, 'MONTH') -- 8월 
     , TO_CHAR(SYSDATE, 'RM') -- VIII
  FROM
       DUAL;

-- 일에 쓸 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'DD') -- 26
     , TO_CHAR(SYSDATE, 'D') -- 3 (화요일)
     , TO_CHAR(SYSDATE, 'DDD') -- 238 (1월 1일로부터 며칠이 지났는지)
  FROM 
       DUAL;
-- DD : 한달기준
-- D : 일주일기준(일요일부터)
-- DDD : 일년 기준(1월 1일부터)

SELECT
       TO_CHAR(SYSDATE, 'DAY') -- 화요일
     , TO_CHAR(SYSDATE, 'DY') -- 화
  FROM      
       DUAL;
-- 날짜 예쁘게 넣고 싶을 경우
SELECT 
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY MM DD DY') -- 2013 02 06 수
     , TO_CHAR(HIRE_DATE , 'YYYY"년" MM"월" DD"일" (DY)') -- 2013년 02월 06일 (수)
  FROM 
       EMPLOYEE;
--------------------------------------------------------
/*
	NUMBER / CHARACTER => DATE
	
	-- 전달할 때 숫자 또는 문자인데 받을 때는 DATE로 변화해서 저장해줘야 한다.
	- TO_DATE(NUMBER, CHARACTER, 포맷) : 숫자/문자를 날짜로 변환(DATE로 변환)

*/
SELECT 
       20250826 -- 20250826
     , TO_DATE(20250826) -- 2025-08-26 00:00:00.000
     , TO_DATE('001212') -- 2000-12-12 00:00:00.000
     , TO_DATE('980607') -- 1998-06-07 00:00:00.000
     , TO_DATE('980607', 'YYMMDD') -- 2000-12-12 00:00:00.000
  FROM   
       DUAL;

--------------------------------------------------------
/*
	CHARACTER => NUMBER
	
	- TO_NUMBER(CHARACTER, 포맷) : 문자를 숫자형으로 변환(NUMBER로 변환)
*/
SELECT
       '01234' -- 01234
	 , TO_NUMBER('01234') -- 1,234
  FROM
		DUAL;

SELECT 
       123 + 456 -- 579
       --'123' + '456' -- ERROR
  FROM
       DUAL;

SELECT 
       --'11,000' + '20,000' --불가능
        TO_NUMBER('44,000', '99,999') + TO_NUMBER('20,000', '99,999') -- 64000
  FROM
        DUAL;
--------------------------------------------------------
/*
	<NULL 처리 함수>
	
	NVL(컬럼명, 해당 컬럼값이 NULL 값일 경우 반환할 결과값)
*/
-- EMPLOYEE 테이블로부터 사원명, 보너스
SELECT
       EMP_NAME
     , BONUS
     , NVL(BONUS, 0) -- NUL 이면 0으로 치환
  FROM
       EMPLOYEE;

-- 보너스 포함 연봉조회
SELECT
       EMP_NAME
     , (SALARY + SALARY * NVL(BONUS, 0)) * 12
     , NVL(DEPT_CODE, '부서 없음') --  D8 / 부서 없음
  FROM 
       EMPLOYEE;

-- NVL2(컬럼명, 결과값1, 결과값2)
-- 해당 컬럼에 값이 존재할 경우 결과값 1을 반환
-- 해당 컬럼에 값이 NULL 값일 경우 결과값 2를 반환
SELECT
       EMP_NAME
     , DEPT_CODE
     , NVL2(DEPT_CODE, '부서 배치 완료', '부서 없음') -- 부서 배치 완료 / 부서 없음
  FROM 
       EMPLOYEE;

-- NULLIF(비교대상1, 비교대상2)
-- 두 개의 값이 동일할 경우 NULL을 반환
-- 두 개의 값이 동일하지 않을 경우 비교대상 1을 반환
SELECT
       NULLIF('1', '1') -- NULL
     , NULLIF('1', '2') -- 1
  FROM 
       DUAL;
--------------------------------------------------------
/*
	< 선택함수 >
	
	DECODE(비교대상(컬럼명/산술연산/함수식), 조건값1, 결과값1, 조건값2, 결과값3,,,결과값(java == default));
	
	- 자바에서의 switch문과 유사
	switch(비교대상){
	case 조건값1 : 결과값;
	case 조건값2 : 결과값;
	default : 결과값;	
	}
*/

--EMPLOYEE 테이블 사원명, 성별 __ 한줄로 쓰기 이건 보기용
SELECT
       EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1),
       1, '남성',
  	   2, '여성',
  	   '성별 선택 안함'
       ) AS "성별"
  FROM
       EMPLOYEE;


-- 직원들의 급여를 인상시켜서 조회
-- 직급코드(JOB_CODE)가 'J7'인 사원들의 급여는 15%인상해서 조회 -- 1.
-- 직급코드가 'J6'인 사원들의 급여는 20% 인상해서 조회 -- 2.
-- 직급코드가 'J5'인 사원들의 급여는 30% 인상해서 조회
-- 나머지 직급인 사원들의 급여는 5% 인상해서 조회
SELECT
        EMP_NAME
      , SALARY
      , JOB_CODE
      , DECODE(JOB_CODE, 'J7', (SALARY + SALARY * 0.15)
					   , 'J6', (SALARY + SALARY * 0.2)
					   , 'J5', (SALARY + SALARY * 0.3)
					   , (SALARY + SALARY * 0.05)) "인상 후 급여" 
   FROM
		EMPLOYEE;

--------------------------------------------------------
/*
	CASE WHEN THEN 구문
	
	- DECODE랑 비교했을 때 DECODE는 동등비교만 수행
	  CASE WHEN THEN 다양한 조건식을 기술 가능
	  
	[표현법]
	CASE
		WHEN 조건식1 THEN 결과값1
		WHEN 조건식2 THEN 결과값2
		...
		ELSE 결과값
	END
*/

SELECT
       EMP_NAME
     , CASE
     	WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '남성'
     	WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '여성'
     	ELSE '성별선택안함'
       END "성별"
  FROM
	   EMPLOYEE;  
 
--------------------------------------------------------
------------------------★★★★<그룹 함수>★★★★--------------------------------
/*
	이건 5개 나오는데 무조건 외우기 !!!!!!
	N개의 값을 읽어서 1개의 결과를 반환(하나의 그룹별로 함수 실행결과를 반환)
	
	1. SUM(숫자타입)
	2. AVG(숫자타입)
	3. MIN(ANY)
	4. MAX(ANY)
	5. COUNT(*'/ 컬럼명 / DISTINCT 컬럼명)
	
*/

SELECT 
       SALARY
  FROM
       EMPLOYEE;

-- 1. SUM(숫자타입) : 해당 컬럼값들의 총 합계를 반환해주는 함수
-- 전체 사원의 총 급여합계
SELECT
       SUM(SALARY)
  FROM
       EMPLOYEE;



SELECT
       EMP_NAME
     , EMAIL
  FROM
       EMPLOYEE;
-- 이메일에 0이 들어가는 사원들의 총 급여합
-- 부서코드가 D5인 친구들만
SELECT
	   SUM(SALARY)
  FROM
       EMPLOYEE
 WHERE
       EMAIL LIKE '%0%'
   AND
       DEPT_CODE = 'D5';

--------------------------------------------------------
-- 2. AVG(숫자타입) : 해당 컬럼값들의 평균값을 구해서 반환
-- 전체사원들의 그여 평균구하기
SELECT
  	   AVG(SALARY) -- 3131140.86956521739130434782608695652174
  	 , ROUND(AVG(SALARY)) -- 3,131,141
  FROM 
       EMPLOYEE;

--3. MIN(ANY) : 해당 컬럼값들 중 작은 값 반환
SELECT
	    MIN(SALARY) "제일 작은 급여" -- 0
	  , MIN(EMP_NAME) "제일 이름이 빠른사람" -- 강병준
	  , MIN(HIRE_DATE) "제일 빠른 입사일" -- 2000-12-29 00:00:00.000
  FROM
        EMPLOYEE;

--4. MAX(ANY) : 해당 컬럼값들 중 가장 큰 값 반환
SELECT
  	   MAX(SALARY) "가장 높은 급여"
  	 , MAX(EMP_NAME) "가장 느린 이름"
  	 , MAX(HIRE_DATE) "가장 늦은 입사일"
  FROM
 	   EMPLOYEE;


-- 5. COUNT(*/ 컬럼명 / DISTINCT 컬럼명) : 행 개수 세서 반환
SELECT * FROM EMPLOYEE;
-- COUNT(*) :조회 결과에 해당하는 모든 행 개수를 다 세서 반환
SELECT
       COUNT(*) -- 23
  FROM
  	   EMPLOYEE;

-- 보너스를 받는 사원의 수
-- COUNT(컬럼명) : 제시한 컬럼값이 NULL이 아닌 행만 개수를 세서 반환
SELECT 
       COUNT(BONUS)
  FROM
       EMPLOYEE; --9


SELECT
       COUNT(*)
  FROM    
       EMPLOYEE
 WHERE
       BONUS IS NOT NULL;--9
       
-- 현재 사원들이 속해있는 부서 개수
-- COUNT(DISTINCT 컬럼명) : 제시한 해당 컬럼값이 중복값이 존재할 경우 하나로만 세서 반환
SELECT
  	   COUNT(DISTINCT DEPT_CODE)
  FROM
  	   EMPLOYEE; --6
  	   
 

