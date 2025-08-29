# 🧑🏻‍💻 DBMS_ORACLE

데이터베이스 기초 수업에서 작성한 실습 코드와 과제를 정리한 저장소입니다.
데이터베이스 문법을 학습하며 점진적으로 실력을 향상시키는 것을 목표로 합니다.

---
:pencil2: 박수현

:paperclip: **[데이터베이스 공부 기록 노션](https://ubiquitous-woodpecker-cc5.notion.site/SQL-JDBC-9-5-2598e71b864f80af86a1c402ca478de9?source=copy_link)** :pencil2:

## 📘 학습 내용 요약
---
DQL(SELECT)
DDL(DATA QUERY LANGUAGE)
- 01_기본문법
  - 문자열관련함수
  - 산술연산
  - DATE
  - 컬럼명에 별칭 부여하기
  - 리터럴
  - DISTINCT
  - WHERE 절
  - 논리연산자
  - BETWEEN AND>  / <NOT BETWEEN AND
  - LIKE '특정패턴'
  - IS NULL / IS NOT NULL
  - 연결연산자 ||
  - IN
  - 연산자 우선순위
  - **ORDER BY** ⭐
---
- 02_FUNCTION 함수
  - 단일행 함수
    - 문자열 관련 함수
      - LENGTH / LENGTHB
      - INSTR(STR)
      - SUBSTR(STR, POSITION, LENGTH)
      - LPAD(LEFTPADDING) / RPAD(RIGHTPADDING)
      - LTRIM / RTRIM (STR, 제거하고자하는 문자)
      - TRIM(BOTH / LEADING / TRAILRING '제거하고자하는문자' FROM STR)
      - LOWER(STR)/UPPER(STR)/INITCAP(STR)
      - CONCAT(STR1, STR2)
      - REPLACE(STR, 찾을문자, 바꿀문자)
    - 숫자 관련 함수
    - 날짜 관련 함수
    - 형 변환 함수
    - NULL 처리 함수
  - 그룹함수
    - **SUM(숫자타입)** ⭐
    - **AVG(숫자타입)** ⭐
    - **MIN(ANY)** ⭐
    - **MAX(ANY)** ⭐
    - **COUNT(*'/ 컬럼명 / DISTINCT 컬럼명)** ⭐
---
- 03_GRROUP BY절
  - HAVING 절
  - **실행 순서** ⭐
---
- **04_JOIN** ⭐⭐⭐
  - ORACLE / ANSI
  - 등가조인(EQUAL JOIN) / **내부조인(INNER JOIN)**
  - 포괄조인 / **외부조인 (OUTER JOIN)** + LEFT / RIGTH
  - 카테시안 곱(CARTESIAN PRODUCT) /  교차조인(CROSS JOIN)
  - 비등가 조인(NON EQUAL JOIN)
  - 자체조인 (SELF JOIN)
---
- 05_SUB QUERY
  - 단일행 [단일열] 서브쿼리
  - 다중행 [단일열] 서브쿼리
  - [단일열] 다중열 서브쿼리
  - 다중행 다중열 서브쿼리
  -** 인라인 뷰(INLINE-VIEW)** ⭐⭐
  - 스칼라 서브쿼리(Scalar Subquery)
  - ROWNUM
  - OFFSET
---
DML(INSERT, UPDATE, DELETE)
- 06_DML(INSERT, UPDATE, DELETE)
  - INSERT
    - INSERT INTO 테이블명 VALUEW (값, 값, 값...)
    - INSERT INTO 테이블명(컬럼명, 컬럼명, 컬렴명) VALUES(값, 값, 값)
    - INSERT INTO 테이블명(서브쿼리);
    - INSERT ALL
  - UPDATE
  - DELETE
  - TRUNCATE
---
DDL(CREATE, ALTER, DROP)
- 07_DDL(CREATE, ALTER, DROP)
- DDL(DATA DEFITION LANGUAGE)
  - CREATE
    - CREATE TABLE
    - 자료형
    - COMMENT ON COLUMN 테이블명.컬럼명 IS '설명'
    - 제약조건(CONSTRAINT)
      - NOT NULL
      - UNIQUE
      - CHECK
      - PRIMARY KEY
      - FOREIGN KEY
  - DELETE
    - ON DELETE SET NULL
    - ON DELETE CASCADE
  - ALTER
    - 컬럼 추가 / 수정 / 삭제
    - 제약조건 추가 / 삭제
    - 테이블명 / 컬럼명 / 제약조건
  - DROP
---
**TCL(COMMIT, ROLLBACK)** ⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐
- 08_TCL(COMMIT, ROLLBACK)
- TCL(TRANSACTION CONTROL LANGUAGE)
  - COMMIT
  - ROLLBACK
  - SAVEPOINT
---
OBJECT(VIEW)
---
JDBC
[JAVA (JDBC를 위한 JAVA GITHUB 링크)](https://github.com/Elinasu001/jdbc_workspace.git) + DATABASE


---
🛠 개발 환경
Oracle Database 18c

