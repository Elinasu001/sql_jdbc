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
	
	
	COMMIT, ROLLBACK, SAVEPOINT
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




















