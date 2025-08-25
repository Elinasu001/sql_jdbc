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
       DUAL;
     
SELECT
       INSTR('AABAACAABBAA', 'B', -1)
  FROM
       DUAL; -- 뒤에서부터 첫 번째 'B'가 앞에서부터 몇 번째인지

SELECT
       INSTR('AABAACAABBAA', 'B', 1, 3)
  FROM
       DUAL; -- 앞에서부터 세 번째 'B'가 앞에서부터 몇 번째 인지
       
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

