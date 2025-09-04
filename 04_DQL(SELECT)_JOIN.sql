SELECT * FROM EMPLOYEE;  -- DEPT_CODE JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;				--    JOB_ID


SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
 FROM
      EMPLOYEE;

SELECT
       DEPT_TITLE
  FROM
       DEPARTMENT;

SELECT
       JOB_NAME
  FROM
       JOB;
-- 1. 회원 전체 조회(사번, 사원명, 급여, 부서명, 직급명)
SELECT
       EMP_ID AS "사번"
     , EMP_NAME AS "사원명"
     , SALARY AS "급여"
     , DEPT_TITLE AS "부서명"
     , JOB_NAME AS "직급명"
 FROM
       EMPLOYEE
 LEFT     
 JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 JOIN  
	   JOB USING (JOB_CODE);

-- 2. 부서명을 입력받아 부서가 동일한 사원 조회(총무부 입력시 총무부인 사원들만 조회되도록)
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE 
       DEPT_TITLE = ?

-- 3. 직급명을 입력받아 직급이 동일한 사원 조회(과장 입력시 과장인 사원들만 조회되도록).
SELECT
	   JOB_NAME
     , EMP_NAME
  FROM
       EMPLOYEE 
  JOIN
       JOB USING (JOB_CODE)
 WHERE 
       JOB_NAME = '대리';

-- 4. 사원 상세 조회(사번을 입력받아서 모든 컬럼 값 조회)
SELECT
	   EMP_ID
	 , EMP_NAME
	 , EMP_NO
	 , EMAIL
	 , PHONE
	 , DEPT_CODE
	 , JOB_CODE
	 , SAL_LEVEL 
	 , SALARY
	 , BONUS
	 , MANAGER_ID
	 , HIRE_DATE
	 , ENT_DATE
	 , ENT_YN
  FROM 
       EMPLOYEE
 WHERE
 	   EMP_ID = '200'; 

--SELECT
--       EMP_NAME
--     , SALARY
-- FROM
--      (SELECT
--	       	  EMP_NAME
--	       ,  SALARY
--	    FROM
--	          EMPLOYEE
--	   WHERE
--	          SALARY IS NOT NULL
--	   ORDER
--	      BY
--	         SALARY DESC)
--WHERE
--      ROWNUM >= 5;

-- 5. 급여가 높은 상위 다섯명 조회
SELECT
       EMP_NAME
     , SALARY
  FROM
       EMPLOYEE
 WHERE
	   SALARY IS NOT NULL
 ORDER
    BY
       SALARY DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 6 급여가 낮은 하위 다섯명 조회
SELECT
       EMP_NAME
     , SALARY
  FROM
       EMPLOYEE
 WHERE
	   SALARY IS NOT NULL
 ORDER
    BY
       SALARY 
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 7. 사원 추가 기능
INSERT
  INTO
	   EMPLOYEE
VALUES
	   (
	   300
	 , '김김김'
	 , '202020-2020202'
	 , 'kee@kh.or.kr'
	 , '01088887777'
	 , 'D8'
	 , 'J4'
	 , 'S3'
	 , 5000000
	 , NULL
	 , NULL
	 , SYSDATE
	 , NULL
	 , N
	   );

--INSERT 
--  INTO 
--       EMPLOYEE 
--       (
--       EMP_ID
--     , EMP_NAME
--     , EMP_NO
--     , EMAIL
--     , PHONE
--     , DEPT_CODE
--     , JOB_CODE
--     , SAL_LEVEL
--     , SALARY
--     , BONUS
--     , MANAGER_ID
--     , HIRE_DATE
--     , ENT_DATE
--     , ENT_YN
--	  ) 
--VALUES 
--      (
--      '300'
--    , '김김김'
--    , '202020-2020202'
--    , 'kee@kh.or.kr'
--    , '01088887777'
--    , 'D8'
--    , 'J4'
--    , 'S3'
--    , 5000000
--    , NULL
--    , NULL
--    , SYSDATE
--    , NULL
--    , 'N'
--);



INSERT
  INTO
  	   EMPLOYEE
       (
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , EMAIL
     , PHONE
     , DEPT_CODE
     , JOB_CODE
     , SAL_LEVEL
     , SALARY
     , BONUS
     , HIRE_DATE  
       )
VALUES
 	   (
	   SEQ_EID.NEXTVAL
	 , '홍길길'
	 , '631010-2653546'
	 , 'kth04@kh.or.kr'
	 , '01077607879'
	 , 'D9'
	 , 'J5'
	 , 'S4'
	 , 5000000
	 , 100
	 , SYSDATE
 	   );


SELECT * FROM EMPLOYEE;

-- 8. 
--SELECT
--       SALARY
--     , JOB_NAME
--     , DEPT_TITLE
--  FROM 
-- 	   EMPLOYEE
--  JOIN
--       JOB USING (JOB_CODE)
--  JOIN
--       DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 8 사원 정보 수정(사번을 입력받아 급여, 직급, 부서 수정)
UPDATE 
       EMPLOYEE
   SET 
       SALARY   = ?
     , JOB_CODE = ?
     , DEPT_CODE= ?
 WHERE 
       EMP_ID   = ?;
 
        
-- 9.사원 퇴사 기능(사번을 입력받아 퇴사 여부, 퇴사일 수정)
UPDATE
       EMPLOYEE
  SET
       ENT_DATE = ?
     , ENT_YN = ?
 WHERE
       EMP_ID = ?;
       
UPDATE
       EMPLOYEE E
   SET
       SALARY    = 5000000
     , JOB_CODE  = (
               SELECT
                        J.JOB_CODE
                 FROM
                        JOB J
                WHERE
                        J.JOB_NAME = '과장'
           )
         , DEPT_CODE = (
               SELECT
                        D.DEPT_ID
                 FROM
                        DEPARTMENT D
                WHERE
                        D.DEPT_TITLE = '총무부'
           )
 WHERE
       E.EMP_ID  = '300';

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;

-- 확인용
SELECT
        E.EMP_ID
      , E.EMP_NAME
      , E.SALARY
      , D.DEPT_TITLE
      , J.JOB_NAME
  FROM
        EMPLOYEE E
  JOIN
        DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN
        JOB J        ON (E.JOB_CODE  = J.JOB_CODE)
 WHERE
        E.EMP_ID = '300';



-- 전체 사원들의 사번, 사원명, 부서코드, 부서명을 한꺼번에 조회하고 싶다.★★★★면접 단골 질문★★★★ JOIN 몇개 테이블까지 해봤는지
SELECT
 	   EMP_ID
 	 , EMP_NAME
 	 , DEPT_CODE
  FROM
       EMPLOYEE;

SELECT 
       DEPT_ID
     , DEPT_TITLE
  FROM
       DEPARTMENT;

-- 전체사원들의 사번, 사원명, 직급코드, 직급명을 한 번에 조회
SELECT
  	   EMP_ID
  	 , EMP_NAME
  	 , JOB_CODE
  FROM
       EMPLOYEE;

SELECT
       JOB_CODE
     , JOB_NAME
  FROM
       JOB;
---------------------------------------------------------------------
/*
	★★★★★★★★★★★★★★★★ JOIN ★★★★★★★★★★★★★★★★
*/

--> JOIN을 통해 연결고리에 해당하는 컬럼만 매칭시킨다면 마치 하나의 조회 결과물처럼 조회가능

-- KH
-- 어떤 강의장에 어떤 강사가 수업을 하고 있는가??
CREATE TABLE CLASS_ROOM(
	CLASS_ID CHAR(1),
	LECTURE_NAME VARCHAR2(20)
);
SELECT * FROM CLASS_ROOM;

INSERT INTO CLASS_ROOM VALUES('A', '이승철');
INSERT INTO CLASS_ROOM VALUES('B', '홍길동');
INSERT INTO CLASS_ROOM VALUES('C', '고길동');

CREATE TABLE STUDENT(
	CLASS_ID CHAR(1),
	STUDENT_NAME VARCHAR2(20)
);
SELECT * FROM STUDENT;

INSERT INTO STUDENT VALUES('A', '이승욱');
INSERT INTO STUDENT VALUES('A', '채정민');
INSERT INTO STUDENT VALUES('B', '김윤기');
INSERT INTO STUDENT VALUES('C', '김태호');
COMMIT; -- INSERT 하고나서 무조건 COMMIT

SELECT
       CLASS_ID
     , LECTURE_NAME
  FROM
       CLASS_ROOM;

SELECT
       CLASS_ID
     , STUDENT_NAME
  FROM
       STUDENT;

SELECT
	   LECTURE_NAME
     , CLASS_ROOM.CLASS_ID
     , STUDENT.CLASS_ID
     , STUDENT_NAME
  FROM 
  	   CLASS_ROOM, STUDENT --> 1절 끝
 WHERE 
       CLASS_ROOM.CLASS_ID = STUDENT.CLASS_ID;
-------------------------------------------------------------------------------
/*
  < JOIN >
  두 개 이상의 테이블에서 데이터를 한 번에 조회하기 위해 사용하는 구문
  조회결과는 하나의 ResultSet으로 나옴
  
  관계형 데이터베이스에서는 최소한의 데이털 각각의 테이블에 데이터를 보관하고 있음(중복방지)
  -> JOIN 구문을 사용해서 여러 개의 테이블 간 "관계"를 맺어서 같이 조회 해야함
  => 무작정 JOIN을 해서 조인하는 것이 아니고 테이블 간 매칭을 할 수 있는 컬럼이 존재해야함
  
  JOIN은 크게 "오라클 전용구문"과 "ANSI(미국국립표준협회)구문[선호]"으로 나뉜다.
  
  ==================================================================
		오라클 전용 주문			|			ANSI(오라클 + 타 DMBS)구문		
  ==================================================================
  		★★등가조인				|			★★내부조인
	 (EQUAL JOIN)			|		 (INNER JOIN)
  -------------------------------------------------------------------
  		★포괄조인				|		★왼쪽 외부조인(LEFT OUTER JOIN)
  	 (LEFT OUTER)			|		★오늘쪽 외부조인(RIGHT OUTER JOIN)
  	 (RIGHT OUTER) 			|		★전체 외부조인(FULL OUTER JOIN)-> 오라클에선X
  -------------------------------------------------------------------
  		카테시안 곱				|			교차조인
  	(CARTESIAN PRODUCT)		|		(CROSS JOIN)
  -------------------------------------------------------------------
	자체조인(SELF JOIN)
  	비등가조인(NON EQUAL JOIN)
  	자연조인(NATURAL JOIN) --> 가치없음...
*/

/*
	1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
	
	JOIN 시 연결시키는 컬럼의 값이 일치하는 행들만 조인돼서 조회
	( == 일치하지 않는 값들을 조회에서 제외 )
*/

--> 오라클 전용 구문
--> SELECT 절에는 조회하고 싶은 컬럼명을 각각 기술
-->   FROM 절에는 조회하고자 하는 테이블을 , 를 이용해서 전부 다 나열
-->  WHERE 절에는 매칭을 시키고자 하는 컬럼명에 대한 조건을 제시함( = )

-- 전체 사원들의 사원명, 부서코드, 부서명을 한꺼번에 조회
SELECT * FROM EMPLOYEE; -- EMP_NAME, DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID, DEPT_TITLE

-- CASE 1. 연결할 두 컬럼의 컬럼명이 다른경우(DEPT_CODE - DEPT_ID)
SELECT
       EMP_NAME
     , DEPT_CODE
     , DEPT_ID
     , DEPT_TITLE
  FROM
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE = DEPT_ID;
-- 207개 행중에서 21개행만 일치
-- 일치하지 않는 값은 조회에서 제외
-- DEPT_CODE 가 NULL인 사원 2명은 데이터가 조회되지 않는다. (EMPLOYEE)
-- DEPT_ID가 D3, D4, D7인 부서데이터가 조회되지 않는다. (DEPARTMENT)

-- 전체 사원들의 사원명, 직급코드, 직급명 조회
SELECT * FROM JOB; -- JOB_CODE, JOB_NAME
SELECT * FROM EMPLOYEE; -- EMP_NAME, JOB_CODE


-- CASE 2. 연결할 두 컬럼의 이름이 같은 경우(JOB_CODE)
-- 방법1. 테이블명을 사용하는 방법
SELECT
 	   EMP_NAME
 	 , EMPLOYEE.JOB_CODE
 	 , JOB.JOB_CODE
 	 , JOB_NAME
 FROM
 	   EMPLOYEE, JOB
 WHERE
       EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- 방법2. 별칭 사용(각 테이블마다 별칭 부여 가능) _ 단, 길어지면 가독성에 안좋음
SELECT 
       EMP_NAME
     , E.JOB_CODE
     , J.JOB_CODE
     , JOB_NAME
  FROM 
       EMPLOYEE E
     , JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE;

--> ANSI구문 [명확, 보기 좋음, 많이 사용함]
-- FROM 절에 기준테이블을 하나 기술한 뒤
-- 그 뒤에 JOIN절에 같이 조회하고자하는 테이블을 기술(매칭시킬 컬럼에 대한 조건도 기술)
-- USING / ON 구문

-- EMP_NAME, DEPT_CODE, DEPT_TITLE
-- 사원명, 부서코드, 부서명
-- 연결컬럼이 컬럼명이 다름(EMPLOYEE - DEPT_CODE / DEPARTMENT - DEPT_ID)
-- 무조건 ON 구문만 사용가능(USING은 못씀 안됨 불가능함 !!!!!!!!!!!!!!!!!!!!!)
SELECT
       EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM
       EMPLOYEE
--INNER -- INNER 사용하지 않으면 INNER JOIN임
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- EMP_NAME, JOB_CODE, JOB_NAME
-- 사원명, 직급코드, 직급명
-- 연결할 두 컬러명이 같을 경우(JOB_CODE)
-- ON 구문 이용) 애매하다 (AMNIGUOUSLY) 발생할 수 있음 어떤 테이블의 컬럼인지 명시
SELECT 
	   EMP_NAME
	 , E.JOB_CODE
	 , JOB_NAME
  FROM 
       EMPLOYEE E
  JOIN   
	   JOB J ON (E.JOB_CODE = J.JOB_CODE);


-- USING 구문이용)컬럼명이 동일할 경우 사용이 가능하며 동등비교연산자를 기술하지 않음
SELECT
       EMP_NAME
     , JOB_CODE
     , JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE);
-- [참고사항] NATURAL JOIN(자연조인) _ 있는 것만 알아놓기 잘 쓰이지 않음.
SELECT
        EMP_NAME
     ,  JOB_CODE
     ,  JOB_NAME
  FROM
   	    EMPLOYEE
NATURAL
   JOIN
        JOB;
-- 두 개의 테이블을 조인하는데 운 좋게도 두 개의 테이블에 일치하는 컬럼이 딱하나있었다. (DEPARTMENT 쓰는 순간 다 깨짐)

/*
 * <QUIZ>
 */
-- 사원명과 직급명을 같이 조회해주세요. 단, 직급명이 대리인 사원들만 조회해주세요.
SELECT * FROM JOB; -- JOB_CODE, JOB_NAME
SELECT * FROM EMPLOYEE; -- EMP_NAME, JOB_CODE

--> ORACLE문법
SELECT
		EMP_NAME
      , E.JOB_CODE
      , J.JOB_CODE
      , JOB_NAME
   FROM
         EMPLOYEE E
      ,  JOB J
   WHERE
         E.JOB_CODE = J.JOB_CODE 
     AND  
	     JOB_NAME = '대리';

--> ANSI문법 ★★
SELECT
       EMP_NAME
     , JOB_NAME
  FROM
       EMPLOYEE E
  JOIN
       JOB J ON (E.JOB_CODE = J.JOB_CODE)
 WHERE
       JOB_NAME = '대리';

-- EQUAL JOIN / INNER JOIN : 일치하지 않는 행은 애초에 ResultSet에 포함시키지 않음
------------------------------------------------------------------------
/*
	2. 포괄조인 / 외부조인 (OUTER JOIN)
	
	테이블간의 JOIN 시 일치하지 않는 행동 포함시켜서 ResultSet 반환
	단, 반드시 LEFT / RIGTH 를 기저해줘야 함! (기준 테이블을 선택해야함)
	
*/

-- EMPLOYEE 테이블에 존재하는 "모든" 사원의 사원명, 부서명 조회
-- INNER JOIN
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
--  INNER
  JOIN
       DEPARTMENT ON (DEPT_CODE  = DEPT_ID);
-- EMPLOYEE 테이블에서 DEPT_CODE가 NULL인 두 명의 사원은 조회 X
-- DEPARTEMT 테이블에서 부서에 배정된 사원이 없는 부서(D3, D4, D7) 조회 X


-- 1) LEFT[ OUTER ] JOIN : 두 테이블 중 왼편에 기술한 테이블을 기준으로 JOIN
-- 조건과는 상관없이 외편에 기술한 테이블의 데이터는 전부 조회(일치하는 값을 못찾더라도 조회)

--> ANSI
-- JOIN 기준으로 왼쪽에 있는 테이블을 조건에 맞지 않더라도 EMPLOYEE 다 조회 (NULL 포함)
SELECT
	   EMP_NAME
	 , DEPT_TITLE
  FROM
       EMPLOYEE
  LEFT
-- OUTER LEFT가 붙으면 OUTER 생략 O
  JOIN 
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-----EMPLOYEE : EMP_NAME, DEPARTMENT : DEPT_TITL

--> ORACLE
-- 기준으로 했던 테이블에서 기준으로 안 삼고 싶던 코드는 + 해준다 
SELECT
        EMP_NAME
     ,  DEPT_TITLE -- NULL
  FROM
        EMPLOYEE
      , DEPARTMENT
  WHERE
        DEPT_CODE = DEPT_ID(+);
-- 기준으로 삼지 않을 테이블의 컬럼에 (+)를 해준다(이럴 경우 NULL 값이 들어간다.)


-- 2) RIGHT [ OUTER ] JOIN : 두 테이블 중 오른편에 기술한 테이블을 기준으로 JOIN
-- 일치하는 컬럼이 존재하지 않더라도 오른쪽 테이블의 데이터는 무조건 다 조회
--> ANSI
SELECT
       EMP_NAME -- NULL
     , DEPT_TITLE
  FROM
       EMPLOYEE
 RIGHT
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--> ORACLE
SELECT
       EMP_NAME
     , DEPT_TITLE
 FROM
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [ OUTER ] JOIN : 두 테이블 가진 모든 행을 조회할 수 있는 조인
--> ANSI 
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM 
       EMPLOYEE
  FULL
 OUTER
  JOIN
        DEPARTMENT ON (DEPT_CODE = DEPT_ID);


--> ORACLE ( X ) - 오라클 전체 외부 조인은 안됨.
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM
       EMPLOYEE
     , DEPARTMENT
 WHERE
       DEPT_CODE(+) = DEPT_ID(+); -- ERROR : outer-join된 테이블은 1개만 지정할 수 있습니다
       
------------------------------------------------------------------------
/*
    _ 사용 안함 과부하과부하과부하과부하과부하!!
	3. 카테시안 곱(CARTESIAN PRODUCT) /  교차조인(CROSS JOIN) 
	모든 테이블의 각 행동을 서로서로 매핑해서 조회된(곱집합) *** 사용금지 문법
	
	두 테이블의 행들이 곱해진 조합 뽑아냄 => 데이터 많을수록 방대한 행이 생겨남
	=> 과부하의 위험!!!!
*/ 
--> ORACLE
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT;
--                                  23         9
--> ANSI
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE CROSS JOIN DEPARTMENT;

------------------------------------------------------------------------
/*
	4. 비등가 조인(NON EQUAL JOIN)
	'=' 를 사용하지 않는 조인
	
	컬럼값을 비교하는 경우가 아니라 "범위"에 포함되는 내용을 매칭
*/ 

-- EMPLOYEE 테이블로부터 사원명, 급여
SELECT
 	   EMP_NAME
 	 , SALARY
  FROM
       EMPLOYEE;

SELECT * FROM SAL_GRADE;

--> ORACLE
SELECT
       EMP_NAME
     , SALARY
     , SAL_GRADE.SAL_LEVEL
  FROM
       EMPLOYEE
     , SAL_GRADE
 WHERE
       SALARY BETWEEN MIN_SAL AND MAX_SAL;

--> ANSI
SELECT
       EMP_NAME
     , SALARY
     , SAL_GRADE.SAL_LEVEL
  FROM
       EMPLOYEE
  JOIN
       SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

------------------------------------------------------------------------
/*
	5. 자체조인 (SELF JOIN) _ 팀에서 한명 정도 사용할 수도 있음.
	
	같은 테이블을 다시 한 번 조인하는 경우
	자기자신의 테이블과 조인을 맺음
*/ 

SELECT
  	   EMP_ID "사원 번호"
     , EMP_NAME "사원 이름"
     , PHONE "전화번호"
     , MANAGER_ID "사수 사번"
  FROM
       EMPLOYEE;
-- EMPLOYEE 에 있는 사수가 있는 사람들은 사수의 정보를 같이 보고 싶을 경우 사원의 정보와 사수의 정보를 resultSet에서 같이 보고 싶음
SELECT EMP_ID, EMP_NAME, PHONE, MANAGER_ID FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

--> ORACLE
-- 사원사번, 사원명, 사원 폰번호, 사수번호
-- 사수사번, 사수명, 사수 폰번호
SELECT
       E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID -- 사수 번호 없는 사람도 나오려면 +
     , M.EMP_ID, M.EMP_NAME, M.PHONE
  FROM
   	   EMPLOYEE E, -- 기준
   	   EMPLOYEE M
 WHERE
	   E.MANAGER_ID  = M.EMP_ID(+);

--> ANSI
SELECT
 	   E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID
 	 , M.EMP_ID, M.EMP_NAME, M.PHONE
  FROM
       EMPLOYEE E
  LEFT -- E는 다 나와야하니 적용
  JOIN 
       EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

------------------------------------------------------------------------
/*
	< 다중 JOIN >
*/
-- 사원명 + 부서명 + 직급명 + 지역명(LOCAL_NAME)
-- 4개 전부 다른 테이블에 있음
SELECT * FROM EMPLOYEE; 	-- EMP_NAME		DEPT_CODE 	JOB_CODE
SELECT * FROM DEPARTMENT; 	-- DEPT_TITLE	DEPT_ID					LOCATION_ID
SELECT * FROM JOB;			-- JOB_NAME				  	JOB_CODE
SELECT * FROM LOCATION;		-- LOCAL_NAME             				LOCAL_CODE

-- EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
--> ANSI 구문
SELECT 
	   EMP_NAME
	 , DEPT_TITLE
	 , JOB_NAME
	 , LOCAL_NAME
  FROM
       EMPLOYEE 
  LEFT -- 왼쪽 기준 NULL 포함
  JOIN
	   DEPARTMENT ON (DEPT_CODE = DEPT_ID) -- 다른 컬럼명
  JOIN 
  	   JOB USING(JOB_CODE) -- 같은 컬럼명
  LEFT -- 왼쪽 기준 NULL 포함
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE);

--> ORACLE
SELECT
	   EMP_NAME
	 , DEPT_TITLE
	 , JOB_NAME
	 , LOCAL_NAME
  FROM
       EMPLOYEE E
     , DEPARTMENT
     , JOB J
     , LOCATION
 WHERE
       DEPT_CODE = DEPT_ID(+)
   AND
       LOCATION_ID = LOCAL_CODE(+)
   AND 
       E.JOB_CODE = J.JOB_CODE;


------------------------------------------------------------------------
/*
	< 집합 연산자 SET OPERATOR >
	
	여러 개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
	
	- UNION : 합집합 (두 쿼리문의 수행 결과값을 더한 후 중복되는 부분을 제거) 
	- INTERSECT : 교집합(두 쿼리문의 수행 결과값 중 중복된 부분)
	- MINUS : 차집합(선행 쿼리문 결과값 빼기 후행 쿼리문의 결과값을 한 결과)
	=> WHERE로 대체 가능
	
	  ★★★★★★
	- UNION ALL : 합집합의 결과에 교집합을 더한 개념
  	(두 쿼리문을 수행한 결과값을 무조건 더함. 합집합에서 중복 제거를 하지 않는 것)
	=> 중복행이 여러 번 조회 될 수 있다.
*/

-- 1. UNION
-- 부서코드가 D5인 사원들 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'; -- 박세혁, 박수현, 박채형, 박현준, 배주영, 유성현 - 6행
       
-- 급여가 300만원 초과인 사람들
SELECT
 	   EMP_NAME
 	 , DEPT_CODE
 	 , SALARY
  FROM
       EMPLOYEE
 WHERE
 	   SALARY > 3000000; -- 이승철, 강병준, 강현성, 박성민, 박현준, 유성현, 채정민, 신국희 - 8행


-- UNION O
SELECT * FROM EMPLOYEE;
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION
SELECT
 	   EMP_NAME
 	 , DEPT_CODE
 	 , SALARY
  FROM
       EMPLOYEE
 WHERE
 	   SALARY > 3000000;
-- UNION 쓰려면 SELECT 절에 기술하는 컬럼이 같아야함
-- 같음 UNION 쓸 바에 컬럼이 같다면 OR 사용
-- UNION X
SELECT
 	   EMP_NAME
 	 , DEPT_CODE
 	 , SALARY
  FROM
       EMPLOYEE
 WHERE
 	   DEPT_CODE = 'D5'
    OR
       SALARY >  3000000;

-- 부서코드가 D1, D2, D5인 부서의 급여 합계를 조회하고 싶다.
-- UNION O
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE  = 'D1'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE  = 'D2'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE  = 'D5';
-- UNION X
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D1', 'D2', 'D5')
GROUP BY DEPT_CODE;

------------------------------------------------------------------------
-- 2. UNION ALL : 여러 개의 쿼리 결과를 무조건 합치는 연산자(중복 가능) ★★★★★★
-- 중복 지원 불가 또는 중복 당첨 불가 할경우 사용
SELECT
	   EMP_NAME
	 , DEPT_CODE
     , SALARY
  FROM 
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION 
   ALL
SELECT
	   EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY >  3000000;

------------------------------------------------------------------------
-- 3. 교집합 INTERSECT (앞에 쿼리랑 뒤에 쿼리 겹치는 것만 조회)
-- INTERSECT O
SELECT
	   EMP_NAME
	 , DEPT_CODE
     , SALARY
  FROM 
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
INTERSECT
SELECT
	   EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY >  3000000;

-- INTERSECT X
SELECT
	   EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
 	   DEPT_CODE = 'D5'
   AND
       SALARY >  3000000;

------------------------------------------------------------------------
--4. MINUS (차집합 - 선행쿼리 결과에서 후행 쿼리 결과를 뺀 나머지) - 중복 된 걸 뺸 나머지
-- MINUS O
SELECT
	   EMP_NAME
	 , DEPT_CODE
     , SALARY
  FROM 
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 MINUS
SELECT
	   EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY >  3000000;

-- MINUS X
SELECT
	   EMP_NAME
	 , DEPT_CODE
     , SALARY
  FROM 
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
   AND
       SALARY <=  3000000; -- 반대로 사용하면 됨.


















