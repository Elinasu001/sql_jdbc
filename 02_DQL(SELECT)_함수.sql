/*
	함수 <FUNCTION>
	
	자바로 따지면 메소드
	전달된 값을 가지고 계산된 결과를 반환해준다
	
	- 단일행 함수
	- 그룹 함수
	
*/
------------------------- <단일행 함수> -------------------------
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
        EMPLOYEE; -- 정보를 띄울 경우 이름 성, 주민등록번호는 뒤 앞자리 1자리만 보여준다.

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
   
   - MOD(NUMBER1, NUMBER2)
   
   %를 모듈로 연산자
   
   
	** 기본 실수 자료형을 가지고 연산하지 말기 **
	** 자바 API 중에 실수 처리하는 따로 있거나 보통 DB단에서 처리하는게 좋음
*/
SELECT
       MOD(10, 3)
     , MOD(-10, 3)
     , MOD(10.8, 3)
  FROM   
       DUAL;
--------------------------------------------------------
/*
   ROUND
   
   - ROUND(NUMBER, 위치) : 반올림 
  	
  	생략도 가능, 생략 시 기본값은 0
 
 */
SELECT
       ROUND(123.456)
     , ROUND(123.456, 1)
     , ROUND(123.345, 2)
     , ROUND(123.456, -1)
     , ROUND(123.456, -2)
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

SELECT CEIL(123.456) FROM DUAL; -- 124

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

--------------------------------------------------------
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
--------------------------------------------------------
/*
	

*/