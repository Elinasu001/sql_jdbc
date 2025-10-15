CREATE TABLE KH_MEMBER(
	USER_NO NUMBER PRIMARY KEY, -- 외래키 
	USER_ID VARCHAR2(30) UNIQUE NOT NULL,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR(20) NOT NULL,
	EMAIL VARCHAR2(30) NOT NULL,
	ENROLL_DATE DATE DEFAULT SYSDATE, -- 가입시간
	MODIFY_DATE DATE DEFAULT SYSDATE, -- 수정한 시간
	STATUS CHAR(1) DEFAULT 'Y' CHECK(STATUS IN ('Y', 'N'))
);

CREATE SEQUENCE KH_UNO NOCACHE;
-- default 메뉴가 많을 경우 아래와 같이() 가는 걸 선호한다. / 여기의 connection session과 mybatis session이랑 다르기 때문에 commit 해야 사용할 수 있다.
INSERT INTO KH_MEMBER(USER_NO, USER_ID, USER_PWD, USER_NAME, EMAIL) VALUES (KH_UNO.NEXTVAL, 'admin', '1234', '홍길동', 'hong@kh.CLASS_ROOM ');
COMMIT;

SELECT * FROM KH_MEMBER;

-- 아이디 중복체크 -----------------------------------------------------------
SELECT USER_ID FROM KH_MEMBER WHERE  USER_ID = 'admin';
-- 있을 땐 아이디값 없을 때 null
SELECT COUNT(*) FROM KH_MEMBER WHERE USER_ID = 'admin';
-- 있을 땐 1 없을 땐 0
SELECT DECODE(COUNT(*), 0, 'NNNY', 1, 'NNNN') FROM KH_MEMBER WHERE USER_ID ='admin';
-- 스크립트의 조건을 줄이고 싶을 경우 sql에서 decode 방식으로 조건 달아주기
-- return bd.checkId(sqlSession, id);

/*
 * String userId = bd.checkId(sqlSession, id);
 * if(userId != null){
 * 	return = "NNNN"
 * } else {
 * 	return = "NNNY"
 * }
 * 
 * if(userId != null || result > 0){ -- 길다...sql문으로 줄이자
 * 	return = "NNNN"
 * } else {
 * 	return = "NNNY"
 * }
 * 
 */

