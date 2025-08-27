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



*/































