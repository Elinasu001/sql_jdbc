


INSERT INTO CT_EVENT_ATTACHMENT VALUES (SEQ_EVENT_FILE_NO.NEXTVAL, 1, 'example1.png', 'Event1.png', 'resources/upfiles/event', SYSDATE, 'Y');
INSERT INTO CT_EVENT_ATTACHMENT VALUES (SEQ_EVENT_FILE_NO.NEXTVAL, 2, 'example2.png', 'Event2.png', 'resources/upfiles/event', SYSDATE, 'Y');
INSERT INTO CT_EVENT_ATTACHMENT VALUES (SEQ_EVENT_FILE_NO.NEXTVAL, 3, 'example3.png', 'Event3.png', 'resources/upfiles/event', SYSDATE, 'Y');
INSERT INTO CT_EVENT_ATTACHMENT VALUES (SEQ_EVENT_FILE_NO.NEXTVAL, 4, 'example4.png', 'Event4.png', 'resources/upfiles/event', SYSDATE, 'N');
INSERT INTO CT_EVENT_ATTACHMENT VALUES (SEQ_EVENT_FILE_NO.NEXTVAL, 5, 'example1.png', 'Event1.ppg', 'resources/upfiles/event', SYSDATE, 'N');



SELECT * FROM CT_EVENT_ATTACHMENT;


SELECT * FROM CT_EVENT;


-- 진행 중 이벤트 (SYSDATE 기준 이후)
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '가을맞이 이벤트', '10% 할인 쿠폰 증정!', 0, SYSDATE, SYSDATE + 7, 'Y', 5, SYSDATE);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '겨울 특별전', '연말 이벤트 안내', 0, SYSDATE, SYSDATE + 10, 'Y', 5, SYSDATE);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '신규회원 이벤트', '회원가입 시 쿠폰 증정', 0, SYSDATE, SYSDATE + 5, 'Y', 5, SYSDATE);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '봄맞이 세일', '봄맞이 세일 안내입니다.', 0, SYSDATE, SYSDATE + 14, 'Y', 5, SYSDATE);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '여름 캠페인', '여름 캠페인 이벤트!', 0, SYSDATE, SYSDATE + 20, 'Y', 5, SYSDATE);

-- 종료된 이벤트 (이미 끝난 기간)
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '연초맞이 이벤트', '새해 첫 구매 고객 5% 추가 할인!', 0, SYSDATE - 40, SYSDATE - 30, 'Y', 5, SYSDATE - 40);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '봄 특별 세일', '봄 신상품 할인전', 0, SYSDATE - 25, SYSDATE - 10, 'Y', 5, SYSDATE - 25);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '여름 사은품 증정 이벤트', '한정판 굿즈 증정 이벤트 종료', 0, SYSDATE - 70, SYSDATE - 50, 'Y', 5, SYSDATE - 70);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '가정의 달 감사전', '가족 선물세트 20% 할인', 0, SYSDATE - 100, SYSDATE - 90, 'Y', 5, SYSDATE - 100);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '추석맞이 한가위 이벤트', '추석 선물세트 30% 할인', 0, SYSDATE - 400, SYSDATE - 380, 'Y', 5, SYSDATE - 400);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '지난 여름 이벤트', '종료된 이벤트입니다.', 0, SYSDATE - 10, SYSDATE - 5, 'Y', 5, SYSDATE);

-- 종료된 이벤트 3개 추가
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '지난봄 이벤트', '종료된 이벤트 예시1', 0, SYSDATE - 20, SYSDATE - 10, 'Y', 5, SYSDATE);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '지난여름 세일', '종료된 이벤트 예시2', 0, SYSDATE - 40, SYSDATE - 30, 'Y', 5, SYSDATE);
INSERT INTO CT_EVENT VALUES (SEQ_EVENT.NEXTVAL, 1, '작년 겨울 감사제', '종료된 이벤트 예시3', 0, SYSDATE - 70, SYSDATE - 60, 'Y', 5, SYSDATE);

COMMIT;

COMMIT;

 SELECT
         EVENT_NO eventNo
       , EVENT_TITLE eventTitle
       , START_DATE startDate
       , END_DATE endDate
       , FILE_PATH filePath
       , ORIGIN_NAME originName
       , CHANGE_NAME changeName
    FROM  
         CT_EVENT
    LEFT -- 첨부파일이 null 값이니 outerjoin으로 
    JOIN 
         CT_EVENT_ATTACHMENT ON (REF_BNO = EVENT_NO)
   WHERE 
         CT_EVENT.STATUS = 'Y'
     AND 
         END_DATE < SYSDATE
   ORDER
      BY 
         EVENT_NO DESC