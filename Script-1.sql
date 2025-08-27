/*
	< DML : DATA MANIPULATION LANGUAGE >
	
			데이터 	 조작  		언어
			
 	논외 SELECT : 클래식(DML) / 모던(DQL (Data query language))*
 	
 	INSERT / UPDATE / DELETE
 	
    테이블에 새로운 데이터를 삽입(INSERT)하거나,
    테이블에 존재하는 데이터를 수정(UPDATE)하거나,
    테이블에 존재하는 데이터를 삭제(DELETE) 하는 구문
*/


/*
	1. INSERT : 테이블에 새로운 행을 추가해주는 구문
	
	[ 표현법 ]
	
	1) INSERT INTO 테이블명 VALUES (값, 값, 값, ,,,);
	
	
	=> 해당 테이블에 모든 "컬럼"에 추가하고자 하는 값을 직접 입력해서 "한 행"을 INSERT할 때 사용
	※ 주의할 점 : 값의 순서를 컬럼의 "순서"와 동일하게 작성해야 함
*/
SELECT * FROM EMPLOYEE;

--INSERT INTO EMPLOYEE VALUEW ('김태호'); -- 한행인데 이름만 넣음? 안돼 !! 컬럼의 개수만큼 넣으세요
-- 현재는 받을 수 없으니 직접 만들었지만, 실제로는 입력을 받아서 테이블에 넣을거임
INSERT
  INTO
       EMPLOYEE
VALUES
       (
	   223
	 , '김태호'
	 , '991231-9999999'
	 , 'kth04@kh.or.kr'
	 , '01004044040'
	 , 'D9'
	 , 'J5'
	 , 'S4'
	 , 5000000
	 , NULL
	 , NULL
	 , SYSDATE
	 , NULL
	 , 'N'
       );
SELECT * FROM EMPLOYEE WHERE EMP_ID = 223; -- 추가 ~

/*
	2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES(값, 값, 값);
 	=> 테이블 특정 컬럼만 선택해서 컬럼에 값을 추가하면서 행을 추가할 때 사용
	INSERT는 무조건 한 행 단위로 추가가 되기 때문에 작성하지 않은 컬럼은 NULL값이 들어감
	
	주의할 점 ) NOT NULL이 달려있는 컬럼은 반드시 테이블 명 뒤에 컬럼명을 적어야함
	예외 사항 ) NOT NULL 제약조건이 달려있는데 기본값이 있는 경우는 DEFAULT VALUE가 들어감 	
*/

INSERT
  INTO
       EMPLOYEE
       (
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , JOB_CODE
     , SAL_LEVEL
       )
VALUES
       (
      900
     , '고길동'
     , '841015-1353452'
     , 'J5'
     , 'S1'
       );

SELECT * FROM EMPLOYEE;

--------------------------------------------------
/*
 	3) INSERT INTO 테이블명 (서브쿼리);
 	=> VALUES 대신에 서브쿼리를 작성해서 INSERT 할 수 있음
 */
-- 새 테이블 하나 만들기
CREATE TABLE EMP_01(
	EMP_NAME VARCHAR2(20),
	DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- EMPLOYEE 테이블에 존재하는 모든 사원 사원명과, 부서명을 새로만든 EMP_01에 INSERT
INSERT
  INTO
       EMP_01
       (
       SELECT
              EMP_NAME
            , DEPT_TITLE
         FROM
              EMPLOYEE
            , DEPARTMENT
        WHERE
              DEPT_CODE = DEPT_ID(+)
       );

----------------------------------------------------------------
/*
	4) INSERT ALL
	하나의 테이블에 여러 행을 한꺼번에 INSERT 할 때 사용
  	INSERT ALL
  	  INTO 테이블명 VALUES(값, 값, 값 ,,,)
  	  INTO 테이블명 VALUES(값, 값, 값 ,,,)
  	SELECT *
  	  FORM DUAL;
 */
INSERT INTO EMP_01 VALUES('사우너1', '부서1');
INSERT INTO EMP_01 VALUES('사원2', '부서2');
-- ...
SELECT * FROM EMP_01;
INSERT INTO EMP_01 VALUES('사원3', '부서3');
-- 처리결과 :: Updated Rows : 1 --> 얼마나 많은 행이 수행 되었는가 -->1 INSERT 했더니 Value 정수 값 1 돌아옴
INSERT
   ALL
       INTO EMP_01 VALUES('사원4', '부서4')
       INTO EMP_01 VALUES('사원5', '부서5')
       INTO EMP_01 VALUES('사원6', '부서6')
SELECT
       *
  FROM
       DUAL;
-- 처리결과 :: Updated Rows : 3개 행 INSERT -> 정수값 3 돌려줌
--------------------------------------------------------------------------------
/*
	2. UPDATE
	테이블에 기록된 기존의 데이터를 수정하는 구문
    
    [ 표현법 ]
    UPDATE 
           테이블명
       SET
           컬럼명 = 바꿀값
         , 컬럼명 = 바꿀값
         , ...  => 여러 개의 컬럼값을 바꿀 수 있음(, 써야함!! AND 아님 !!!! ★★★★)
     WHERE
           조건식; => 생략 가능 단, 조건이 있으면 조건식 써줘야됨
*/
----테이블 복사하기
CREATE TABLE DEPT_COPY2 -- 복사 ~
    AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY; -- 땡겨 ~

-- DEPT_COPY 테이블에서 총무부를 부서명을 미래사업부로 변경
UPDATE 
       DEPT_COPY
   SET
       DEPT_TITLE = '미래사업부';
--출력 결과 Updated Rows : 9 ...? 

SELECT * FROM DEPT_COPY; -
--전체 행의 모든 DEPT_TITLE 컬럼 값이 전부 미래사업부로 UPDATE 되버림 우리는 총무부를 미래사업부로 변경하고 싶으니 다시 ROLLBACK;
ROLLBACK; -- 아... auto commit...DEPT_COPY2로

UPDATE 
       DEPT_COPY2
   SET
       DEPT_TITLE = '미래사업부'
 WHERE
	   DEPT_TITLE = '총무부';
SELECT * FROM DEPT_COPY2;
-- 이제 총무부만 미래사업부로 변경됨.

-- 그럼 어떤 상황이어야지 WHERE절이 안붙나?
-- 김하늘 100원 보너스
UPDATE
       EMPLOYEE
   SET
       SALARY = 100
 WHERE
       --EMP_NAME = '김하늘'; --> 사실 좋은 건 아님 WHY? 중복이 있을 수 있기 때문이다. 그럼 겹치지 않는 갑으로 하는게 좋음
	   EMP_ID = 204;

-- 전체 사원들 급여를 기존 급여에서 5% 인상해
UPDATE 
       EMPLOYEE
   SET 
       SALARY = SALARY * 1.05;
SELECT * FROM EMPLOYEE;

-------------------------------------------------------------------------
/*
	UPDATE 사용 시 서브쿼리 사용해보기
	
	UPDATE
	       테이블명
	   SET
	       컬럼명 = (서브쿼리)
	 WHERE
	       조건; -- 생략 가능
	       
	※주의 :: 조건 안 사용하면 전부 삭제됨
*/

-- 안예성 사원의 급여를 김하늘 사원의 급여만큼으로 갱신
-- 중복 고려하기
UPDATE 
       EMPLOYEE
   SET
       SALARY = (SELECT --> = 대입의 용도
                        SALARY
                   FROM
                        EMPLOYEE
                  WHERE
                        EMP_NAME = '김하늘') -- 그럼 이건 ? 중복이 발생하지 않는가?
 WHERE
       EMP_ID = (SELECT --> = 동등비교의 용도 : 중복 발생 예방
                        EMP_ID
                   FROM
                        EMPLOYEE
                  WHERE
                        EMP_NAME = '안예성');

SELECT * FROM EMPLOYEE;

--------------------------------------------------------------------------
/*
 	3. DELETE
 	테이블에 기록된 행을 삭제하는 구문
 	
 	[ 표현법 ]
 	DELETE
 	  FROM 
 	       테이블명
 	 WHERE
 	       조건; => 생략가능
 	※주의 :: UPDATE와 동일하게 WHERE 조건 절을 작성하지 않으면 모든 행 삭제 될 수 있음.※
 */

SELECT * FROM DEPT_COPY2;
DELETE
  FROM
       DEPT_COPY2
 WHERE
       DEPT_TITLE = '미래사업부';
SELECT * FROM DEPT_COPY2;

-------------------------------------------------------------------

/*
	TRUNCATE : 테이블의 전체 행을 삭제하는 사용하는 구문(절삭)
	 		   DELETE 보다 빠름 (이론적으로............)
	 		   별도의 조건을 부여할 수 없음 ROOLBACK 불가능 !!!!
*/
DELETE FROM DEPT_COPY; -- 0.0004s
TRUNCATE TABLE DEPT_COPY2; -- 0.063s  이론적으로 물리적 위치와 지우려는 데이터의 양에 따라 달라질 수 있음... 수십 만개일 경우 차이 날 수 있음
