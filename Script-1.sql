-- 서브웨이 테이블 만들기 !!

-- 일단, pk 없이 진행
-- 이름
-- 전화번호
-- 주소
-- 주문시 메시지
-- 샌드위치
-- 채소
-- 소스
-- 과자
-- 결제방식
-- (주문내역보기를 위해) 주문일자
DROP TABLE TB_SUBWAY;
CREATE TABLE TB_SUBWAY(
	NAME VARCHAR2(100) NOT NULL,
	PHONE VARCHAR2(13) NOT NULL,
	ADDRESS VARCHAR2(400) NOT NULL,
	REQUEST VARCHAR2(4000),
	SANDWICH VARCHAR2(100) NOT NULL,
	VEGETABLE VARCHAR2(300), -- 정석대로 가려면 채소, 소스, 쿠기 등은 테이블을 분리해야된다.(분리 안할 시, 중복발생) -- 정규화 시간때 할 예정
	SAUCE VARCHAR2(300),
	COOKIE VARCHAR2(50),
	PAYMENT VARCHAR2(10),
	ORDER_DATE DATE DEFAULT SYSDATE
);

SELECT * FROM TB_SUBWAY;



