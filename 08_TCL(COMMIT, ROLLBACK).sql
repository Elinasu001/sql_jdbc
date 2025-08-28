/*
	< TCL : TRANSACTION CONTROL LANGUAGE >
		  	트랜잭션		제어 		언어
	★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	★★★★★★★★★★★★★생각이 필요한 개념★★★★★★★★★★★
	
	* TRANSACTION
	- 작업단위
	- 데이터베이스의 상태를 변화시키는 논리적 연산단위
	- 여러개의 DML구문을 하나로 묶어 처리하는 메커니즘
	예) 계좌이체 시 동시 발생 시 어떻게?
	- 데이터의 변경사항(DML)들을 하나의 트랜잭셩으로 묶어서 관리  -단, SELECT는 조회라 데이터 바뀌지 않으니 포함 안됨
	  COMMIT(확정)하기 전까지의 변동사항들을 하나의 트랜잭션에 담게됨
	- 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE
	
	* TRANSACTION의 4가지 속성
	ACID 
	1. Atomicity(원자성) : 트랜잭션 내의 모든 작업은 전부 수행되거나,
	 					 전혀 수행되지 않아야한다. 라는 원칙					(될거면 전부 되던가 안되면 전부 안되던가 ~~)
	2. Consistency(일관성) : 트랜잭션이 성공적으로 완료 된 후에도,
						   데이터베이스는 유요한 상태를 유지해야한다는 원칙 		(데이터 유지 (테이블의 데이터타입, 데이터크기 등이 깨지면 안된다))
	3. Isolation(고립성) : 동시에 실행되는 여러 트랜잭션이 상호간에 영향을 끼치지
						 않도록 하는 원칙 								(트랜잭션 서로 영향 없이 독립적으로 수행해야된다.)
	4. Durablity(지속성) : 트랜잭션이 성공적으로 수행되었다면,
						 시스템에 문제가 발생하더라도 영구적으로 반영이 되어야한다. 	(결과가 유지되어야한다.)
	
	
	
	
	
	
	COMMIT(트랜잭션을 종료 처리 후 확정), ROLLBACK(트랜잭션 취소), SAVEPOINT
*/
-- 복사
CREATE TABLE EMP_COPY
    AS SELECT EMP_ID, EMP_NAME FROM EMPLOYEE;

SELECT * FROM EMP_COPY;

-- 사번이 900번인 사원 삭제
DELETE  					--> 데이터 변동 => TRANSACTION 생성 => 1번째 DELETE 들어감.
  FROM
       EMP_COPY
 WHERE
       EMP_ID = 900;
 
-- 사번이 222번인 사원 삭제
DELETE						--> 2번째 DELETE 들어감.			
  FROM
       EMP_COPY
 WHERE
       EMP_ID = 222;

-- 조건 없으면 싹 사라짐
DELETE
  FROM
       EMP_COPY;

-- 돌려돌려 - 데이터 원복
ROLLBACK;					--> TRANSACTION 전체 날림

--> 실질적으로 데이터베이스는 SELECT랑 연관이 없음
-------------------------------------------------------------------------------

SELECT * FROM EMP_COPY;  -- 트랜잭션 아직 안생김

DELETE FROM EMP_COPY WHERE EMP_ID = 900; --  트랜잭션 생성 + DELETE

UPDATE EMP_COPY SET EMP_NAME = '고길동' WHERE EMP_NAME = '홍길동'; --  + UPDATE

SELECT * FROM EMP_COPY;

COMMIT;-- COMMIT 시 TRANSACTION 올라간 DELETE UPDATE "확정"을 지음. == 물리적인 저장장치에 저장 예) 한글파일작업시 저장할 경우

ROLLBACK; -- 예) 한글파일 작업시 저장 안하고 끌 경우 (내용 날라감)

-------------------------------------------------------------------------------
-- 조심!
-- 사번이 214, 216번인 사원 삭제
DELETE
  FROM
       EMP_COPY
 WHERE  
       EMP_ID IN (214, 216); -- Updated Rows : 정수값 2 -- TRANSACTION에 포함
       
-- 2개 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT DELETE2ROWS; -- TRANSACTION에 포함

SELECT * FROM EMP_COPY;

DELETE
  FROM
       EMP_COPY
 WHERE
       EMP_ID = 222; -- 기존 TRANSACTION에 포함
       
ROLLBACK TO DELETE2ROWS; 

SELECT * FROM EMP_COPY;  -- 세이브 포인트

ROLLBACK; -->  이럴경우 SAVEPOINT해준 지점까지만 ROLLBACK 된다.

------------------------------------------------------------
-- 조심해야 되는 부분 !
COMMIT;

DELETE FROM EMP_COPY WHERE EMP_ID = 222;

SELECT * FROM EMP_COPY;

CREATE TABLE HAHA( -- 커밋 수행은 여기서 수행됨
	HID NUMBER
);

ROLLBACK; -- 홍길동 ROLLBACK 안됨. WHY? 마지막 커밋 한 시점으로 감.
/*
	DDL 구문(CREATE, ALTER, DROP)을 수행하는 순간
	트랜잭션에 이는 모든 작업사항을 무조건 COMMIT 해서 실제 DB에 반영 한 후 DDL을 수행
	--> DDL을 써야하는데 이전 트랜잭션이 존재한다면? => COMMIT / ROLLBACK 수행 후 처리
*/



