/*
	DDL(DATA DEFITION LANGUAGE) : 데이터 정의 언어
	
	구조자체를 정의하는 언어로 주로 DB관리자, 설계자가 사용함
	
	오라클에서 제공하는 객체(OBJECT)를 
	새롭게 만들고(CREATE), 구조를 변경하고(ALTER), 구조를 삭제하고(DROP)하는 명령어
	
	DDL : CREATE, ALTER, DROP
	
	오라클의 객체(구조) : 테이블(TABLE), 사용자(USER), 뷰(VIEW), 시퀀스(SEQUENCE)
	 			   , 인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER)
	 			   , 프로시저(PROCEDURE), 함수(FUNCTION), 동의어(SYNONYM)...

	
	DQL : SELECT => 질의
	DML : INSERT / UPDATE /DELETE => 데이터 조작
	DDL : CREATE / ALTER / DROP => 구조 조작	
*/

/*
	< CREATE TABLE >
	
	테이블이란? : 행(ROW), 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
	관계형 데이터베이스는 "모든" 데이터를 테이블 형태로 저장함
	(데이터를 보관하고자 하면 반드시 테이블이 존재해야함!!)
	
	[ 표현법 ]
	CREATE TABLE TB_테이블명 (
		컬럼명 자료형,
		컬럼명 자료형,
		컬럼명 자료형,
		컬럼명 자료형,
		...
	);
	
	< 자료형 >
	
	- 문자(CHAR(크기) /  VARCHAR2(크기) / NVARCHAR2(크기)) : 크기는 BYTE단위
														(NVARCHAR는 예외)
														
									 숫자, 영문자, 특수문자 => 1글자당 1BYTE
									 한글, 일본어, 중국어  => 1글자당 3BYTE
									 
	- CHAR(바이트 크기) : 최대 2000BYTE 까지 지정가능
				       '고정'길이 (아무리 작은 값이 들어와도 공백으로 채워서 크기 유지 -> 만약 2000BYTE인데 1BYTE를 사용한다? 그럼 나머지 1999BYTE 낭비가 된다) 예) '김철수' → [김철수                                           ] -- 47바이트 낭비
				       주로 들어올 값의 글자수가 정해져 있을 경우 
				       예) 성별 M/F
				       
    - VARCHAR2(바이트 크기) : VAR는 '가변'을 의미, 2는 '2배'를 의미
    					   최대 4000BYTE까지 지정 가능
    					   가변길이 (적은 값이 들어오면 맞춰서 크기가 줄어듬)
    					   --> CLOB, BLOB
    					   
    ★알찬 친구 WHY? 우리나라는 영어보다 한글을 많이 사용하는데 위 두개는 다국어 지원이 안될 수 있기 때문이다
    - NVARCHAR2(N) : 가변길이, 선언방식(N) --> N : 최대 문자 수
					 다국어 지원 아주 화끈함 완전 지원
					 VARCHAR2보다 성능이 떨어질 수 있음
					 
	- 숫자(NUMBER) : 정수 / 실수 상관없이 NUMBER
	
	- 날짜(DATE)
*/

--> 회원의 정보(아이디, 비밀번호, 이름, 회원가입일)를 담기위한 테이블 만들기
-- 키워드는 식별자로 사용할 수 없음
-- USER_ID VARCHAR2(20) : 컬럼명(상수처럼작성, 단어 구분은 '_' 사용) 자료형(VARCHAR2 : 보통 아이디는 영어, 숫자, 특수문자)

CREATE TABLE TB_USER(
	USER_ID VARCHAR2(20),
 	USER_PWD VARCHAR2(20),
 	USER_NAME NVARCHAR2(30),
 	ENROLL_DATE DATE			-- 가입날짜
);

SELECT * FROM TB_USER;
/*
	컬럼에 주석 달기 == 설명 다는 법
	
	COMMENT ON COLUMN 테이믈명.컬럼명 IS '설명'
*/

COMMENT ON COLUMN TB_USER.USER_ID IS '회원아이디';
-- COMMENT ON COLUMN TB_USER.USER_PWD IS '회원비밀번호';
-- COMMENT ON COLUMN TB_USER.USER_NAME IS '회원명';
-- COMMENT ON COLUMN TB_USER.ENROLL_DATE IS '가입날짜';
SELECT * FROM USER_TABLES;
--> 현재 이 계정이 가지고 있는 테이블들의 전반적인 구조를 확인 할 수 있음
SELECT * FROM USER_TAB_COLUMNS;
--> 현재 이 계정이 가지고 있는 테이블들의 모든 컬럼의 정보를 조회할 수 있음

-- 데이터 딕셔너리 : 객체들의 정보를 저장하고 있는 시스템 테이블

-- 테이블에 데이터를 추가 
-- INSERT
INSERT
  INTO
       TB_USER
VALUES
       (
     'user01'
     , '1234'
     , '관리자'
     , '2025-08-27'
       );

INSERT INTO TB_USER VALUES('user01', 'pass01', '이승철', '25/08/27');
INSERT INTO TB_USER VALUES('user02', 'pass02', '홍길동', SYSDATE);
 
SELECT * FROM TB_USER;
-------------------------------------------------------------------------------------
INSERT INTO TB_USER VALUES(NULL, NULL, NULL, SYSDATE);
--> 아이디와 비밀번호 컬럼에는 NULL값이 들어가선 안됨!
INSERT INTO TB_USER VALUES('user02', 'pass03', '고길동', SYSDATE);
--> 중복된 아이디값은 존재해선 안됨!

--> NULL 값이나 중복된 아이디값은 유효하지 않은 값들
--> 유효한 데이터값을 유지하기 위해서는 제약조건을 걸어줘야함
SELECT * FROM TB_USER;

/*
	< 제약 조건 CONSTRAINT >
	
	- 테이블에 유요한 데이터값만 유지하기 위해서 특정 컬럼마다 제약 == 데이터 무결성 보장
	- 제약조건을 부여하면 데이터를 INSERT / UPDATE 할 때마다 제약조건에 위배되지 않는지 검사
	
	- 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
	
	- 제약조건을 부여하는 방법 : 컬럼 레벨 / 테이블 레벨
*/

/*
	1. NOT NULL 제약조건
	해당 컬럼에 반드시 값이 존재해야 할 경우 사용(NULL 값을 막는다)
	INSERT / UPDATE 시 NULL 값을 허용하지 않도록 제한
	
	NOT NULL 제약조건은 "컬럼레벨" 방식으로만 부여할 수 있음
*/

-- 새로운 테이블을 만들면서 NUT NULL 제약조건 달아보기
-- 컬럼레벨 방식 : 컬럼명 자료형 제약조건
CREATE TABLE TB_USER_NOT_NULL(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL,
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME NVARCHAR2(30),
	GENDER CHAR(3)
);
SELECT * FROM TB_USER_NOT_NULL;
INSERT INTO TB_USER_NOT_NULL VALUES(1, 'admin', '1234', '관리자', '남');
-- INSERT INTO TB_USER_NOT_NULL VALUES(NULL, NULL, NULL, NULL, NULL);
--> NULL을 ("PSH08"."TB_USER_NOT_NULL"."USER_NO") 안에 삽입할 수 없습니다

-- 아래와 같이 작성해야 ERROR가 어디서 났는 지 정확히 알 수 있다.
INSERT
  INTO
       TB_USER_NOT_NULL
VALUES
	   (
	   2
	 , 'user01'
	 , 'pass01'
	 , NULL
	 , NULL
	   ); --> NOT NULL 제약조건이 달린 컬럼에는 반드시 NULL이 아닌 값이 존재해야함!!

SELECT * FROM TB_USER_NOT_NULL;

INSERT
 INTO
       TB_USER_NOT_NULL
VALUES
       (
	   3
	 , 'user01'
     , 'pass02'       
     , NULL
     , NULL
       );

SELECT * FROM TB_USER_NOT_NULL;
--> 중복 발생
--------------------------------------------------------------
/*
	2. UNIQUE 제약조건
	
	컬럼에 중복값을 제한하는 제약조건
	INSERT / UPDATE 시 기존에 컬럼값 중 중복값이 있을 경우 추가 또는 수정을 할 수 없도록 제약한다.
	
	컬럼레벨 / 테이블레벨 방식 둘 다 가능
*/
CREATE TABLE TB_USER_UNIQUE(
	USER_NO NUMBER CONSTRAINT NUM_NOT_NULL NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL, -- UNIQUE, 컬럼 레벨 방식
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME NVARCHAR2(20),
	GENDER CHAR(3),
	CONSTRAINT ID_UNIQUE UNIQUE(USER_ID) -- 테이블 레벨 방식 / CONSTRAINT 제약조건 명
);
-- 테이블 날리기
DROP TABLE TB_USER_UNIQUE;
SELECT * FROM TB_USER_UNIQUE;
INSERT INTO TB_USER_UNIQUE VALUES(1, 'admin', '2134', NULL, NULL);
INSERT INTO TB_USER_UNIQUE VALUES(2, 'admin', '1231', NULL, NULL); -- 중복 X
INSERT INTO TB_USER_UNIQUE VALUES(1, 'admin', '1231', NULL, NULL); -- 중복 X
-- 제약조건명을 달아두면 문제가 생긴 원인은 조금 더 쉽게 유추할 수 있다.

INSERT INTO TB_USER_UNIQUE VALUES(3, 'user01', '1234', '홍길동', '밥');
SELECT * FROM TB_USER_UNIQUE;
-- GENDER 컬럼은 '남' 또는 '여'라는 값만 들어갈 수 있게 하고 싶음
------------------------------------------------------------------------
/*
	3. CHECK 제약조건
	컬럼에 기록될 수 있는 값에 대한 조건을 설정할 수 있음!
	
	CHECK(조건식)
*/
CREATE TABLE TB_USER_CHECK(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	GENDER CHAR(3) CHECK(GENDER IN ('남', '여')) -- TRUE 일 때만 INSERT 가능
);

INSERT INTO TB_USER_CHECK VALUES(1, 'admin', '1234', '여');
INSERT INTO TB_USER_CHECK VALUES(2, 'user01', 'pass01', '밥'); -- 위배 X
INSERT INTO TB_USER_CHECK VALUES(3, 'user03', 'pass01', NULL); 
-- CHECK 를 부여하더라도 NULL값은 INSERT 할 수 있음 -> NOT NULL로 막아야함

-----------------------------------------------------------------
/*
	테이블 만들기 실습
	테이블명 : TB_USER_DEFAULT
	컬럼 : 
		 1. 회원 번호를 저장할 컬럼 : NULL 값 금지
		 2. 회원 아이디를 저장할 컬럼 : NULL 값금지, 중복값 금지
		 3. 회원 비밀번호를 저장할 컬럼 : NULL 값 금지
		 4. 회원 이름을 저장할 컬럼
		 5. 회원 닉네임을 저장할 컬럼 : 중복값 금지
		 6. 회원 성별을 저장할 컬럼 : 'M' 또는 'F'만 INSERT 될 수 있음
		 7. 전화번호를 저장할 컬럼
		 8. 이메일을 저장할 컬럼
		 9. 주소를 저장할 컬럼
		 10. 가입일 저장할 컬럼 : NULL값금지
*/

-- 특정 컬럼에 기본값을 설정하는 방법 ==> 제약조건은 아님
CREATE TABLE TB_USER_DEFAULT(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME NVARCHAR2(30),
	NICKNAME NVARCHAR2(30),
	GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),
	PHONE VARCHAR2(13),
	EMAIL VARCHAR2(25),
	ADDRESS NVARCHAR2(120),
	ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL -- 기본값 설정 DEFAULT 넣고 싶은 설정값
);
DROP TABLE TB_USER_DEFAULT;

INSERT
  INTO
       TB_USER_DEFAULT
       (
	   USER_NO
	 , USER_ID
	 , USER_PWD
       )
VALUES
       (
       1
     , 'admin'
     , '1234'
       ); 


SELECT * FROM TB_USER_DEFAULT;

----------------------------------------------------------
/*
	4. PRIMARY KEY(기본키, PK) 제약조건 ★★★★★★★★★★★ 중요
	테이블에서 각 행들의 정보를 유일하게 식별할 용도로 컬럼에 부여하는 제약조건
	-> 행드릉ㄹ 구분하는 식별자의 역할
	예) 학생번호, 게시글번호, 사번, 주문번호, 예약번호
	=> 중복이 발생해선 안되고 값이 꼭 있어야만 하는 식별용 컬럼에 PRIMARY KEY를 부여
	
	한 테이블 당 한 번만 사용 가능
*/

CREATE TABLE TB_USER_PK(
    USER_NO NUMBER CONSTRAINT TB_USER PRIMARY KEY,--컬럼레벨 방식
    USER_ID VARCHAR2(15) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여'))
    -- PRIMARY KEY(USER_NO) -- 테이블레벨 방식
);

SELECT * FROM TB_USER_PK;
INSERT INTO TB_USER_PK
VALUES(1, 'admin', '1234', NULL, NULL);

INSERT INTO TB_USER_PK
VALUES (1, 'user01', '123321', NULL, NULL);
-- (ERROR) 기본키 컬럼은 중복값을 INSERT할 수 없음

INSERT INTO TB_USER_PK
VALUES (NULL, 'user01', '123321', NULL, NULL);
-- (ERROR) 기본키 컬럼은 NULL값을 INSERT할 수 없음

-- PRIMAR KEY 주의사항
CREATE TABLE TB_PRIMARYKEY(
	NO NUMBER PRIMARY KEY,
	ID CHAR(2) PRIMARY KEY
);
-- (ERROR) 하나의 테이블은 하나의 PRIMARY KEY만 가질 수 있음
-- 하지만! 두 개의 컬럼을 묶어서 하나의 PRIMARY KEY로 만들 수 있음 --> 복합키 !!★★★
DROP TABLE VIDEO;
CREATE TABLE VIDEO(
	NAME VARCHAR2(15),
	PRODUCT VARCHAR2(20),
	PRIMARY KEY(NAME, PRODUCT) -- 컬럼 두개를 묶어서 PRIMARY KEY 하나로 설정
);
INSERT INTO VIDEO VALUES('이승철', '자바');
INSERT INTO VIDEO VALUES('이승철', '자바'); -- (EEOR) '이승철', '자바' 중복 발생
INSERT INTO VIDEO VALUES('이승철', 'DB');-- (EEOR) '이승철' 중복 발생
INSERT INTO VIDEO VALUES('홍길동', '자바');
-- 중복값 안되게 하려고 UNIQUE 다는건 안됨,,, WHY? 컬럼값이 다름
SELECT * FROM VIDEO;
--------------------------------------------------------------------------------
-- 회원 등급에 대한 데이터(코드, 등급명) 보관하는 테이블 _ 나중에 JOIN하기 위한 테이블
-- 부모 테이블
CREATE TABLE USER_GRADE(
	GRADE_CODE CHAR(2) PRIMARY KEY,
	GRADE_NAME NVARCHAR2(20) NOT NULL
);
INSERT INTO USER_GRADE VALUES('G1', '일반회원');
INSERT INTO USER_GRADE VALUES('G2', '회장님');
INSERT INTO USER_GRADE VALUES('G3', '대통령');

SELECT
       GRADE_CODE
     , GRADE_NAME
  FROM
       USER_GRADE;

/*
	5. FOREIGN KEY(외래키) 제약조건
	
	다른 테이블에 존재하는 값만 컬럼에 INSERT하고 싶을 때 부여하는 제약조건
	=> 다른 테이블(부모테이블)을 참조한다고 표현
	참조하는 테이블에 존재하는 값만 INSERT 할 수 있음
	=> FOREIGN KEY 제약조건을 이용해서 다른 테이블간의 관계를 형성할 수 있음
	
	[ 표현법 ]
	- 컬럼 레벨 방식
	컬럼명 자료형 REFERENCES 참조할테이블명(참조할 키가 없을 경우 '참조할컬럼명' 작성 해주는데 거의 참조할 키가 없는 경우가 없으니 생략)
	
	- 테이블 레벨 방식
	FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명(참조할컬럼명)
	
	
	컬럼명 생략 시 PRIMARY KEY 컬럼이 참조할 컬럼이 됨
*/
-- 자식 테이블
CREATE TABLE TB_USER_CHILD( 
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(15) NOT NULL UNIQUE,
	USER_PWD VARCHAR(20) NOT NULL,
	GRADE_ID CHAR(2) REFERENCES USER_GRADE -- 컬럼레벨 방식(적어야될 게 적음)
	-- FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE 테이블 레벨 방식
);

INSERT INTO TB_USER_CHILD VALUES(1, 'user01', 'pass01', 'G1');
INSERT INTO TB_USER_CHILD VALUES(2, 'user02', 'pass01', 'G2');
INSERT INTO TB_USER_CHILD VALUES(3, 'user03', 'pass03', 'G1');
INSERT INTO TB_USER_CHILD VALUES(4, 'user04', 'pass04', NULL);

SELECT * FROM TB_USER_CHILD;

INSERT INTO TB_USER_CHILD VALUES(5, 'user05', 'pass05', 'G4'); -- (ERROR) 부모키가 없음

-- <QUIZ> TB_USER_CHILD에 존재하는 모든 회원에 대해서
-- 		   회원번호, 회원아이디, 등급명(예: 회장님)을 조회해주세요!

SELECT 
	   USER_NO
     , USER_ID
     , GRADE_NAME
  FROM
       TB_USER_CHILD
  LEFT
  JOIN
       USER_GRADE ON (GRADE_CODE = GRADE_CODE);
-- 조인을 하기 위해서 꼭 외래키 제약조건을 달아야하는 것은 아님!

---------------------------------------------------------------------
-- 부모테이블(USER_GRADE)에서 테이블을 삭제
-- 테이블 삭제 : DROP , 테이블 안에 있는 데이터 삭제 : DELETE
-- DELETE도 기준은 행이다.
-- GRADE_CODE 가 G1인 행 삭제
DELETE
  FROM
  	   USER_GRADE
 WHERE
       GRADE_CODE = 'G1'; -- [ERROR] 자식 레코드가 발견되었습니다
       
SELECT * FROM USER_GRADE;








