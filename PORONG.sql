DROP TABLE "DEPARTMENT";
DROP TABLE "JOB";
DROP TABLE "MESSAGE";
DROP TABLE "MEETING_ROOM";
DROP TABLE "EDMS_CATEGORY";
DROP TABLE "EDMS_LINE";
DROP TABLE "VACATION";
DROP TABLE "REPLY";
DROP TABLE "FIXTURES";
DROP TABLE "PERSONAL_TRANSFER";
DROP TABLE "BUSINESS";
DROP TABLE "ATTACHMENT";
DROP TABLE "ATTENDANCE";
DROP TABLE "NOTICE_LIKE";
DROP TABLE "BOARD_LIKE";
DROP TABLE "NOTICE_ATTACHMENT";
DROP TABLE "PERSONAL_TRANSFER2";
--DROP TABLE "NOTICE";
--DROP TABLE "EDMS";
--DROP TABLE "BOARD";
--DROP TABLE "EMPLOYEE";
DROP TABLE SCHEDULE CASCADE CONSTRAINTS;
DROP TABLE NOTICE CASCADE CONSTRAINTS;
DROP TABLE EDMS CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;


CREATE TABLE "DEPARTMENT" (
    "DEPT_CODE" VARCHAR2(10) NOT NULL CHECK(DEPT_CODE IN('HR','PD','PM','WEB')),
	"DEPT_NAME"	VARCHAR2(20) NOT NULL,
	"DEPT_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL CHECK(DEPT_STATUS IN('Y','N'))
);
--COMMENT ON COLUMN "DEPARTMENT"."DEPT_NAME" IS '인사부/구매관리부/영업부/웹관리자';
--COMMENT ON COLUMN "DEPARTMENT"."DEPT_STATUS" IS 'Y : 정상 N : 삭제';
INSERT INTO DEPARTMENT VALUES('HR', '인사부', 'Y');
INSERT INTO DEPARTMENT VALUES('PD', '구매관리부', 'Y');
INSERT INTO DEPARTMENT VALUES('PM', '영업부', 'Y');
INSERT INTO DEPARTMENT VALUES('WEB', '웹관리자', 'Y');

CREATE TABLE "JOB" (
	"JOB_CODE"	VARCHAR2(10)		NOT NULL CHECK(JOB_CODE IN('JA','SA','MG','SM','WEB')),
	"JOB_NAME"	VARCHAR2(20)		NOT NULL
);
INSERT INTO JOB VALUES('JA', '사원');
INSERT INTO JOB VALUES('SA', '대리');
INSERT INTO JOB VALUES('MG', '과장');
INSERT INTO JOB VALUES('SM', '차장');
INSERT INTO JOB VALUES('WEB', '웹관리자');

-- COMMENT ON COLUMN "JOB"."JOB_NAME" IS '사원/대리/과장/차장/웹관리자';
CREATE TABLE "EMPLOYEE" (
	"EMP_NO"	NUMBER		NOT NULL,
	"EMP_NAME"	VARCHAR2(20)		NOT NULL,
	"EMP_PWD"	VARCHAR2(30)		NOT NULL,
	"EMP_PHONE"	VARCHAR2(13)		NULL,
	"EMP_ADDRESS"	VARCHAR2(300)		NULL,
	"EMP_ADDRESSCODE"	VARCHAR2(7)		NULL,
	"EMP_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL  CHECK(EMP_STATUS IN('Y','N')),
	"EMP_ADMIN"	VARCHAR2(1)	DEFAULT 'U'	NOT NULL,
	"EMP_EMAIL"	VARCHAR2(50)		NULL,
	"DEPT_CODE"	VARCHAR2(10)		NOT NULL,
	"JOB_CODE"	VARCHAR2(10)		NOT NULL,
	"CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MODIFY_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"FILE_NO"	NUMBER		NULL,
    "FIRST_LOGIN" VARCHAR2(1) DEFAULT 'T' NOT NULL,
	"EMP_ANNUAL"	VARCHAR2(7)	DEFAULT '14'	NOT NULL,
	"EMP_COUNT"	VARCHAR2(7)		NULL
);

-- COMMENT ON COLUMN "EMPLOYEE"."EMP_PHONE" IS '-포함';
-- COMMENT ON COLUMN "EMPLOYEE"."EMP_STATUS" IS 'Y : 정상 N : 삭제';
-- COMMENT ON COLUMN "EMPLOYEE"."EMP_ADMIN" IS 'U:유저 A:어드민';
-- COMMENT ON COLUMN "EMPLOYEE"."EMP_Extension" IS '-포함';
-- COMMENT ON COLUMN "EMPLOYEE"."DEPT_ID" IS '부서명';
-- COMMENT ON COLUMN "EMPLOYEE"."JOB_CODE" IS '직급';
-- COMMENT ON COLUMN "EMPLOYEE"."FILE_NO" IS 'SEQ_FILE_NO';

CREATE TABLE "SCHEDULE" (
	"SCH_NO"	NUMBER		NOT NULL,
	"EMP_NO"	NUMBER		NOT NULL,
	"SCH_TITLE"	VARCHAR2(50)		NOT NULL,
	"SCH_CONTENT"	VARCHAR2(100)		NULL,
	"SCH_START"	VARCHAR2(20)		NOT NULL,
	"SCH_END"	VARCHAR2(20)		NOT NULL,
	"SCH_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL  CHECK(SCH_STATUS IN('Y','N')),
	"SCH_SHARE" VARCHAR2(1) NOT NULL CHECK(SCH_SHARE IN('M','D'))
);
-- COMMENT ON COLUMN "SCHEDULE"."SCH_STATUS" IS 'Y : 정상 N : 삭제';
-- COMMENT ON COLUMN "SCHEDULE"."SCH_SHARE" IS 'M : 개인 D : 부서공유';

CREATE TABLE "MESSAGE" (
	"MESSAGE_NO"	NUMBER		NOT NULL,
	"MESSAGE_CONTENT"	VARCHAR2(1000)		NOT NULL,
	"CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"DELETE_DATE"	DATE		NULL,
	"MESSAGE_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL  CHECK(MESSAGE_STATUS IN('Y','N')),
	"SEND_USER"	NUMBER		NOT NULL,
	"RECEIVE_USER"	NUMBER		NOT NULL,
	"FILE_NO"	NUMBER		NULL
);

--COMMENT ON COLUMN "MESSAGE"."MESSAGE_NO" IS 'SEQ_MESSAGE_NO';
--COMMENT ON COLUMN "MESSAGE"."DELETE_DATE" IS '쪽지 휴지통 이동시 >  UPDATE';
--COMMENT ON COLUMN "MESSAGE"."MESSAGE_STATUS" IS 'Y : 정상 N : 삭제';
--COMMENT ON COLUMN "MESSAGE"."SNED_USER" IS 'USER 테이블의 EMP_NO (FK)';
--COMMENT ON COLUMN "MESSAGE"."RECEIVE_USER" IS 'USER 테이블의 EMP_NO (FK)';
--COMMENT ON COLUMN "MESSAGE"."FILE_NO" IS 'SEQ_FILE_NO';

CREATE TABLE "MEETING_ROOM" (
	"MEET_NO"	NUMBER		NOT NULL,
	"EMP_NO"	NUMBER		NOT NULL,
	"MEET_TITLE"	VARCHAR2(50)		NOT NULL,
	"MEET_CONTENT"	VARCHAR2(100)		NULL,
	"MEET_PNUM"	NUMBER		NULL,
	"MEET_START"	DATE		NOT NULL,
	"MEET_END"	DATE		NOT NULL,
	"MEET_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL CHECK(MEET_STATUS IN('Y','N')),
    "MEET_APPROVAL" VARCHAR2(1) DEFAULT 'S' NOT NULL CHECK(MEET_APPROVAL IN('Y','N','S','C'))
);

-- COMMENT ON COLUMN "MEETING_ROOM"."MEET_STATUS" IS 'Y : 정상N : 삭제';

CREATE TABLE "EDMS" (
	"EDMS_NO"	NUMBER		NOT NULL,
	"EMP_NO"	NUMBER		NOT NULL,
	"EDMS_ RECEPTION"	VARCHAR2(10)		NOT NULL,
	"EDMS_TITLE"	VARCHAR2(50)		NOT NULL,
	"EDMS_DATE"	DATE		NOT NULL,
	"EDMS_CATEGORY"	NUMBER		NOT NULL,
	"EDMS_REASON"	VARCHAR2(3000)		NULL
);

CREATE TABLE "EDMS_CATEGORY" (
	"EDMS_CATEGORY"	NUMBER		NOT NULL,
	"EDMS_NAME"	VARCHAR2(30)		NOT NULL
);
-- COMMENT ON COLUMN "EDMS_CATEGORY"."EDMS_NAME" IS '휴가신청서/지출결의서/인사발령서/출장신청서';

CREATE TABLE "EDMS_LINE" (
	"EDMS_NO"	NUMBER		NOT NULL,
	"EMP_NO"	NUMBER		NOT NULL,
	"APPROVAL_DATE"	DATE		NULL,
	"ACCEPTANCE_DATE"	DATE		NULL,
	"PAYMENT_STATUS"	VARCHAR2(1)	DEFAULT 'N'	NULL CHECK(PAYMENT_STATUS IN('Y','N')),
	"EDMS_ROWNUM"	NUMBER		NOT NULL
);

-- COMMENT ON COLUMN "EDMS_LINE"."PAYMENT_STATUS" IS 'Y:결제 N:대기';

CREATE TABLE "VACATION" (
	"VCT_NO"	NUMBER		NOT NULL,
	"EDMS_CATEGORY"	NUMBER		NOT NULL,
	"VCT_KIND"	VARCHAR2(10)		NULL,
	"VCT_START"	DATE		NULL,
	"VCT_END"	DATE		NULL,
	"VCT_REASON"	VARCHAR2(3000)		NULL,
	"EMP_NO"	NUMBER		NOT NULL
);

--COMMENT ON COLUMN "VACATION"."VCT_KIND" IS '연차/반차';
--COMMENT ON COLUMN "VACATION"."VCT_START" IS '시간까지 넣는걸로';

CREATE TABLE "REPLY" (
	"REPLY_NO"	NUMBER		NOT NULL,
	"NOTICE_NO"	NUMBER		NULL,
	"BOARD_NO"	NUMBER		NULL,
	"REPLY_WRITER"	NUMBER		NOT NULL,
	"REPLY_CONTENT"	VARCHAR2(300)		NOT NULL,
	"REPLY_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"REPLY_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL CHECK(REPLY_STATUS IN('Y','N'))
);

--COMMENT ON COLUMN "REPLY"."REPLY_NO" IS 'SEQ_REPLY_NO';
--COMMENT ON COLUMN "REPLY"."NOTICE_NO" IS 'SEQ_NOTICE_NO';
--COMMENT ON COLUMN "REPLY"."BOARD_NO" IS 'SEQ_BOARD_NO';
--COMMENT ON COLUMN "REPLY"."REPLY_WRITER" IS 'USER 테이블의 EMP_NO (FK)';
--COMMENT ON COLUMN "REPLY"."REPLY_STATUS" IS 'Y : 정상 N :삭제';

CREATE TABLE "FIXTURES" (
	"FIX_NO"	NUMBER		NOT NULL,
	"EDMS_CATEGORY"	NUMBER		NOT NULL,
	"FIX_CATEGORY"	VARCHAR2(100)		NOT NULL,
	"FIX_DETAIL_CATEGORY"	VARCHAR2(100)		NOT NULL,
	"FIX_PRICE"	NUMBER		NOT NULL
);

-- COMMENT ON COLUMN "FIXTURES"."FIX_CATEGORY" IS '출장비/소모품비';
-- COMMENT ON COLUMN "FIXTURES"."FIX_DETAIL_CATEGORY" IS '교통비/식비/비품/인쇄';

CREATE TABLE "PERSONAL_TRANSFER" (
	"PT_NO"	NUMBER		NOT NULL,
	"EDMS_CATEGORY"	NUMBER		NOT NULL,
	"EMP_NO"	NUMBER		NOT NULL,
	"CURRENT_DEPARTMENT"	VARCHAR2(10)		NOT NULL
);


CREATE TABLE "BUSINESS" (
	"BUSINESS_NO"	NUMBER		NOT NULL,
	"EDMS_CATEGORY"	NUMBER		NOT NULL,
	"BUS_AREA"	VARCHAR2(10)		NULL,
	"BUS_START"	DATE		NOT NULL,
	"BUS_END"	DATE		NOT NULL,
	"BUS_CONTENT"	VARCHAR2(1000)		NULL,
	"BUS_NOTE"	VARCHAR2(100)		NULL
);

CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_WRITER"	NUMBER		NOT NULL,
	"BOARD_TITLE"	VARCHAR2(20)		NOT NULL,
	"BOARD_CONTENT"	VARCHAR2(1000)		NOT NULL,
	"CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"UPDATE_DATE"	DATE		NULL,
	"BOARD_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL CHECK(BOARD_STATUS IN('Y','N')),
	"NOTICE_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"FILE_NO"	NUMBER		NULL
);

--COMMENT ON COLUMN "BOARD"."BOARD_NO" IS 'SEQ_BOARD_NO';
--COMMENT ON COLUMN "BOARD"."BOARD_WRITER" IS 'USER 테이블의 EMP_NO (FK)';
--COMMENT ON COLUMN "BOARD"."BOARD_STATUS" IS 'Y : 정상 N : 삭제';
--COMMENT ON COLUMN "BOARD"."FILE_NO" IS 'SEQ_FILE_NO';

CREATE TABLE "ATTACHMENT" (
	"FILE_NO"	NUMBER		NOT NULL,
	"ORIGIN_FILENAME"	VARCHAR2(20)		NOT NULL,
	"CHANGE_FILENAME"	VARCHAR2(20)		NULL,
	"FILE_PATH"	VARCHAR2(1000)		NOT NULL,
	"UPLOAD_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

--COMMENT ON COLUMN "ATTACHMENT"."FILE_NO" IS 'SEQ_FILE_NO';
--COMMENT ON COLUMN "ATTACHMENT"."ORIGIN_FILENAME" IS '파일원본명';
--COMMENT ON COLUMN "ATTACHMENT"."CHANGE_FILENAME" IS '파일수정명';
--COMMENT ON COLUMN "ATTACHMENT"."FILE_PATH" IS '저장폴더경로';
--COMMENT ON COLUMN "ATTACHMENT"."UPLOAD_DATE" IS '업로드일';

CREATE TABLE "NOTICE" (
	"NOTICE_NO"	NUMBER		NOT NULL,
	"NOTICE_WRITER"	NUMBER		NOT NULL,
	"NOTICE_TITLE"	VARCHAR2(20)		NOT NULL,
	"NOTICE_CONTENT"	VARCHAR2(1000)		NOT NULL,
	"CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"NOTICE_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL CHECK(NOTICE_STATUS IN('Y','N')),
	"NOTICE_COUNT"	NUMBER	DEFAULT '0'	NOT NULL,
	"NOTICE_TYPE"	VARCHAR2(1)	DEFAULT 'N'	NOT NULL CHECK(NOTICE_TYPE IN('Y','N'))
);

--COMMENT ON COLUMN "NOTICE"."NOTICE_NO" IS 'SEQ_NOTICE_NO';
--COMMENT ON COLUMN "NOTICE"."NOTICE_WRITER" IS 'USER 테이블의 EMP_NO (FK)';
--COMMENT ON COLUMN "NOTICE"."NOTICE_STATUS" IS 'Y : 정상 N : 삭제';
--COMMENT ON COLUMN "NOTICE"."NOTICE_TYPE" IS 'Y : 필독 N : 일반';

CREATE TABLE "NOTICE_LIKE" (
	"NOTICE_LIKE_NO"	NUMBER		NOT NULL,
	"NOTICE_NO"	NUMBER		NOT NULL,
	"EMP_NO"	NUMBER		NOT NULL,
	"NOTICE_LIKE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

--COMMENT ON COLUMN "NOTICE_LIKE"."NOTICE_LIKE_NO" IS 'SEQ_NOTICE_LIKES_NO';
--COMMENT ON COLUMN "NOTICE_LIKE"."NOTICE_NO" IS 'SEQ_NOTICE_NO';
--COMMENT ON COLUMN "NOTICE_LIKE"."EMP_NO" IS 'USER 테이블의 EMP_NO (FK)';

CREATE TABLE "BOARD_LIKE" (
	"BOARD_LIKE_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"EMP_NO"	NUMBER		NOT NULL,
	"BOARD_LIKE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

--COMMENT ON COLUMN "BOARD_LIKE"."BOARD_LIKE_NO" IS 'SEQ_BOARD_LIKES_NO';
--COMMENT ON COLUMN "BOARD_LIKE"."BOARD_NO" IS 'SEQ_BOARD_NO';
--COMMENT ON COLUMN "BOARD_LIKE"."EMP_NO" IS 'USER 테이블의 EMP_NO (FK)';

CREATE TABLE "NOTICE_ATTACHMENT" (
	"NOTICE_FILE_NO"	NUMBER		NOT NULL,
	"NOTICE_ORIGIN_FILENAME"	VARCHAR2(20)		NOT NULL,
	"NOTICE_CHANGE_FILENAME"	VARCHAR2(20)		NULL,
	"NOTICE_FILE_PATH"	VARCHAR2(1000)		NOT NULL,
	"NOTICE_UPLOAD_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"NOTICE_NO"	NUMBER		NOT NULL
);

--COMMENT ON COLUMN "NOTICE_ATTACHMENT"."NOTICE_FILE_NO" IS 'SEQ_FILE_NO';
--COMMENT ON COLUMN "NOTICE_ATTACHMENT"."NOTICE_NO" IS 'SEQ_NOTICE_NO';

CREATE TABLE "PERSONAL_TRANSFER2" (
	"PT2_NO"	NUMBER		NOT NULL,
	"EDMS_CATEGORY"	NUMBER		NOT NULL,
	"EMP_NO"	NUMBER		NOT NULL,
	"CURRENT_POSITION"	VARCHAR2(10)		NOT NULL
);

CREATE TABLE "ATTENDANCE" (
	"FILE_NO"	NUMBER		NOT NULL,
	"ORIGIN_FILENAME"	VARCHAR2(20)		NOT NULL,
	"CHANGE_FILENAME"	VARCHAR2(20)		NULL,
	"FILE_PATH"	VARCHAR2(1000)		NOT NULL,
	"UPLOAD_DATE"	DATE	DEFAULT SYSDATE	NOT NULL
);

--COMMENT ON COLUMN "Attendance"."WORK_START" IS '로그인일시';
----------------------------------------------------------------------------------
ALTER TABLE "DEPARTMENT" ADD CONSTRAINT "PK_DEPARTMENT" PRIMARY KEY (
	"DEPT_CODE"
);

ALTER TABLE "JOB" ADD CONSTRAINT "PK_JOB" PRIMARY KEY (
	"JOB_CODE"
);

ALTER TABLE "EMPLOYEE" ADD CONSTRAINT "PK_EMPLOYEE" PRIMARY KEY (
	"EMP_NO"
);

ALTER TABLE "SCHEDULE" ADD CONSTRAINT "PK_SCHEDULE" PRIMARY KEY (
	"SCH_NO"
);

ALTER TABLE "MESSAGE" ADD CONSTRAINT "PK_MESSAGE" PRIMARY KEY (
	"MESSAGE_NO"
);

ALTER TABLE "MEETING_ROOM" ADD CONSTRAINT "PK_MEETING_ROOM" PRIMARY KEY (
	"MEET_NO"
);

ALTER TABLE "EDMS" ADD CONSTRAINT "PK_EDMS" PRIMARY KEY (
	"EDMS_NO"
);

ALTER TABLE "EDMS_CATEGORY" ADD CONSTRAINT "PK_EDMS_CATEGORY" PRIMARY KEY (
	"EDMS_CATEGORY"
);

ALTER TABLE "VACATION" ADD CONSTRAINT "PK_VACATION" PRIMARY KEY (
	"VCT_NO"
);

ALTER TABLE "REPLY" ADD CONSTRAINT "PK_REPLY" PRIMARY KEY (
	"REPLY_NO"
);

ALTER TABLE "FIXTURES" ADD CONSTRAINT "PK_FIXTURES" PRIMARY KEY (
	"FIX_NO"
);

ALTER TABLE "PERSONAL_TRANSFER" ADD CONSTRAINT "PK_PERSONAL_TRANSFER" PRIMARY KEY (
	"PT_NO"
);

ALTER TABLE "BUSINESS" ADD CONSTRAINT "PK_BUSINESS" PRIMARY KEY (
	"BUSINESS_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "ATTACHMENT" ADD CONSTRAINT "PK_ATTACHMENT" PRIMARY KEY (
	"FILE_NO"
);

ALTER TABLE "NOTICE" ADD CONSTRAINT "PK_NOTICE" PRIMARY KEY (
	"NOTICE_NO"
);

ALTER TABLE "NOTICE_LIKE" ADD CONSTRAINT "PK_NOTICE_LIKE" PRIMARY KEY (
	"NOTICE_LIKE_NO",
	"NOTICE_NO",
	"EMP_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "PK_BOARD_LIKE" PRIMARY KEY (
	"BOARD_LIKE_NO",
	"BOARD_NO",
	"EMP_NO"
);

ALTER TABLE "NOTICE_ATTACHMENT" ADD CONSTRAINT "PK_NOTICE_ATTACHMENT" PRIMARY KEY (
	"NOTICE_FILE_NO"
);

ALTER TABLE "PERSONAL_TRANSFER2" ADD CONSTRAINT "PK_PERSONAL_TRANSFER2" PRIMARY KEY (
	"PT2_NO"
);

ALTER TABLE "ATTENDANCE" ADD CONSTRAINT "PK_ATTENDANCE" PRIMARY KEY (
	"WORK_DATE",
	"EMP_NO"
);

ALTER TABLE "NOTICE_LIKE" ADD CONSTRAINT "FK_NOTICE_TO_NOTICE_LIKE_1" FOREIGN KEY (
	"NOTICE_NO"
)
REFERENCES "NOTICE" (
	"NOTICE_NO"
);

ALTER TABLE "NOTICE_LIKE" ADD CONSTRAINT "FK_EMPLOYEE_TO_NOTICE_LIKE_1" FOREIGN KEY (
	"EMP_NO"
)
REFERENCES "EMPLOYEE" (
	"EMP_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_BOARD_TO_BOARD_LIKE_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_EMPLOYEE_TO_BOARD_LIKE_1" FOREIGN KEY (
	"EMP_NO"
)
REFERENCES "EMPLOYEE" (
	"EMP_NO"
);

ALTER TABLE "ATTENDANCE" ADD CONSTRAINT "FK_EMPLOYEE_TO_ATTENDANCE_1" FOREIGN KEY (
	"EMP_NO"
)
REFERENCES "EMPLOYEE" (
	"EMP_NO"
);

CREATE SEQUENCE SEQ_FILE_NO; --파일번호
CREATE SEQUENCE SEQ_SCH_NO; -- 스케줄번호
CREATE SEQUENCE SEQ_MEET_NO; --회의번호
CREATE SEQUENCE SEQ_EMP_NO; --사원번호
DROP SEQUENCE SEQ_EMP_NO;
CREATE SEQUENCE SEQ_MESSAGE_NO; --쪽지번호
CREATE SEQUENCE SEQ_NOTICE_NO; --공지사항
CREATE SEQUENCE SEQ_NOTICE_FILE_NO; --공지사항파일
CREATE SEQUENCE SEQ_BOARD_NO; --자유게시판번호
CREATE SEQUENCE SEQ_EDMS_NO; --전자결제
CREATE SEQUENCE SEQ_REPLY_NO; --댓글
CREATE SEQUENCE SEQ_VCT_NO; --휴가번호
CREATE SEQUENCE SEQ_FIX_NO; --지출테이블번호
CREATE SEQUENCE SEQ_PT_NO; --인사발령번호
CREATE SEQUENCE SEQ_BUSINESS_NO; --출장테이블번호
CREATE SEQUENCE SEQ_PT2_NO; --인사발령번호2




INSERT INTO EMPLOYEE (EMP_NO,EMP_NAME,EMP_PWD,EMP_STATUS,EMP_ADMIN,DEPT_CODE,JOB_CODE,CREATE_DATE,EMP_ANNUAL)
VALUES('0000','admin','admin','Y','A','WEB','WEB',SYSDATE,'1');
-- 웹 관리자
INSERT INTO "PORONG"."EDMS_CATEGORY" (EDMS_CATEGORY, EDMS_NAME) VALUES ('1', '휴가신청서'); 
INSERT INTO "PORONG"."EDMS_CATEGORY" (EDMS_CATEGORY, EDMS_NAME) VALUES ('2', '지출결의서');
INSERT INTO "PORONG"."EDMS_CATEGORY" (EDMS_CATEGORY, EDMS_NAME) VALUES ('3', '인사발령서');
INSERT INTO "PORONG"."EDMS_CATEGORY" (EDMS_CATEGORY, EDMS_NAME) VALUES ('4', '출장보고서');
-- 카테고리 더미데이터
commit;


