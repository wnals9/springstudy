-- 시퀀스
DROP SEQUENCE USER_SEQ;
DROP SEQUENCE FREE_SEQ;
DROP SEQUENCE BLOG_SEQ;
DROP SEQUENCE COMMENT_SEQ;

CREATE SEQUENCE USER_SEQ NOCACHE;
CREATE SEQUENCE FREE_SEQ NOCACHE;
CREATE SEQUENCE BLOG_SEQ NOCACHE;
CREATE SEQUENCE COMMENT_SEQ NOCACHE;


-- 테이블
DROP TABLE COMMENT_T;
DROP TABLE BLOG_IMAGE_T;
DROP TABLE BLOG_T;
DROP TABLE FREE_T;
DROP TABLE INACTIVE_USER_T;
DROP TABLE LEAVE_USER_T;
DROP TABLE ACCESS_T;
DROP TABLE USER_T;

-- 가입한 사용자
CREATE TABLE USER_T (
    USER_NO        NUMBER              NOT NULL,        -- PK
    EMAIL          VARCHAR2(100 BYTE)  NOT NULL UNIQUE, -- 이메일을 아이디로 사용
    PW             VARCHAR2(64 BYTE),                   -- SHA-256 암호화 방식 사용
    NAME           VARCHAR2(50 BYTE),                   -- 이름
    GENDER         VARCHAR2(2 BYTE),                    -- M, F, NO
    MOBILE         VARCHAR2(15 BYTE),                   -- 하이픈 제거 후 저장
    POSTCODE       VARCHAR2(5 BYTE),                    -- 우편번호
    ROAD_ADDRESS   VARCHAR2(100 BYTE),                  -- 도로명주소
    JIBUN_ADDRESS  VARCHAR2(100 BYTE),                  -- 지번주소
    DETAIL_ADDRESS VARCHAR2(100 BYTE),                  -- 상세주소
    AGREE          NUMBER              NOT NULL,        -- 서비스 동의 여부(0:필수, 1:이벤트)
    STATE          NUMBER,                              -- 가입형태(0:정상, 1:네이버)
    PW_MODIFIED_AT DATE,                                -- 비밀번호 수정일
    JOINED_AT      DATE,                                -- 가입일
    CONSTRAINT PK_USER PRIMARY KEY(USER_NO)
);

-- 접속 기록
CREATE TABLE ACCESS_T (
    EMAIL    VARCHAR2(100 BYTE) NOT NULL,  -- 접속한 사용자
    LOGIN_AT DATE,                         -- 로그인 일시
    CONSTRAINT FK_USER_ACCESS FOREIGN KEY(EMAIL) REFERENCES USER_T(EMAIL) ON DELETE CASCADE
);

-- 탈퇴한 사용자
CREATE TABLE LEAVE_USER_T (
    EMAIL     VARCHAR2(50 BYTE) NOT NULL UNIQUE,  -- 탈퇴한 사용자 이메일
    JOINED_AT DATE,                               -- 가입일
    LEAVED_AT DATE                                -- 탈퇴일
);

-- 휴면 사용자 (1년 이상 접속 기록이 없으면 휴면 처리)
CREATE TABLE INACTIVE_USER_T (
    USER_NO        NUMBER              NOT NULL,        -- PK
    EMAIL          VARCHAR2(100 BYTE)  NOT NULL UNIQUE, -- 이메일을 아이디로 사용
    PW             VARCHAR2(64 BYTE),                   -- SHA-256 암호화 방식 사용
    NAME           VARCHAR2(50 BYTE),                   -- 이름
    GENDER         VARCHAR2(2 BYTE),                    -- M, F, NO
    MOBILE         VARCHAR2(15 BYTE),                   -- 하이픈 제거 후 저장
    POSTCODE       VARCHAR2(5 BYTE),                    -- 우편번호
    ROAD_ADDRESS   VARCHAR2(100 BYTE),                  -- 도로명주소
    JIBUN_ADDRESS  VARCHAR2(100 BYTE),                  -- 지번주소
    DETAIL_ADDRESS VARCHAR2(100 BYTE),                  -- 상세주소
    AGREE          NUMBER              NOT NULL,        -- 서비스 동의 여부(0:필수, 1:이벤트)
    STATE          NUMBER,                              -- 가입형태(0:정상, 1:네이버)
    PW_MODIFIED_AT DATE,                                -- 비밀번호 수정일
    JOINED_AT      DATE,                                -- 가입일
    INACTIVED_AT   DATE,                                -- 휴면처리일
    CONSTRAINT PK_INACTIVE_USER PRIMARY KEY(USER_NO)
);

-- 자유게시판(계층형-N차, 댓글/대댓글 작성 가능)
CREATE TABLE FREE_T (
    FREE_NO     NUMBER              NOT NULL,
    EMAIL       VARCHAR2(100 BYTE)  NULL,
    CONTENTS    VARCHAR2(4000 BYTE) NOT NULL,
    CREATED_AT  TIMESTAMP           NULL,
    STATUS      NUMBER              NOT NULL,  -- 1:정상, 0:삭제 (실제로 삭제되지 않는 게시판)
    DEPTH       NUMBER              NOT NULL,  -- 0:원글, 1:댓글, 2:대댓글, ...
    GROUP_NO    NUMBER              NOT NULL,  -- 원글과 모든 댓글(댓글, 대댓글)은 동일한 GROUP_NO를 가져야 함
    GROUP_ORDER NUMBER              NOT NULL,  -- 같은 그룹 내 정렬 순서
    CONSTRAINT PK_FREE PRIMARY KEY(FREE_NO),
    CONSTRAINT FK_USER_FREE FOREIGN KEY(EMAIL) REFERENCES USER_T(EMAIL) ON DELETE SET NULL
);

-- 블로그(댓글형)
CREATE TABLE BLOG_T (
    BLOG_NO     NUMBER             NOT NULL,  -- 블로그 번호
    TITLE       VARCHAR2(500 BYTE) NOT NULL,  -- 제목
    CONTENTS    CLOB               NULL,      -- 내용
    USER_NO     NUMBER             NOT NULL,  -- 작성자 번호(NULL인 경우 ON DELETE SET NULL 처리가 가능하고, NOT NULL인 경우 ON DELETE CASCADE 처리가 가능하다.)
    HIT         NUMBER             DEFAULT 0, -- 조회수
    IP          VARCHAR2(30 BYTE)  NULL,      -- IP 주소
    CREATED_AT  VARCHAR2(30 BYTE)  NULL,      -- 작성일 
    MODIFIED_AT VARCHAR2(30 BYTE)  NULL,      -- 수정일
    CONSTRAINT PK_BLOG PRIMARY KEY(BLOG_NO),
    CONSTRAINT FK_USER_BLOG FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE CASCADE  -- 작성자가 삭제되면 블로그도 함께 삭제된다.
);

-- 블로그 이미지 목록
CREATE TABLE BLOG_IMAGE_T (
    BLOG_NO         NUMBER             NOT NULL,
    IMAGE_PATH      VARCHAR2(100 BYTE),
    FILESYSTEM_NAME VARCHAR2(100 BYTE),
    CONSTRAINT FK_BLOG_IMAGE FOREIGN KEY(BLOG_NO) REFERENCES BLOG_T(BLOG_NO) ON DELETE CASCADE
);

-- 블로그 댓글(계층형-1차, 댓글 작성 가능/대댓글 작성 불가능)
CREATE TABLE COMMENT_T (
    COMMENT_NO NUMBER              NOT NULL,
    CONTENTS   VARCHAR2(4000 BYTE) NULL,
    USER_NO    NUMBER              NULL,
    BLOG_NO    NUMBER              NOT NULL,
    CREATED_AT VARCHAR2(30 BYTE)   NULL,
    STATUS     NUMBER              NOT NULL,  -- 1:정상, 0:삭제 (실제로 삭제되지 않는 게시판)
    DEPTH      NUMBER              NOT NULL,  -- 0:원글, 1:댓글, 2:대댓글, ...
    GROUP_NO   NUMBER              NOT NULL,  -- 원글과 모든 댓글(댓글, 대댓글)은 동일한 GROUP_NO를 가져야 함
    CONSTRAINT PK_COMMENT PRIMARY KEY(COMMENT_NO),
    CONSTRAINT FK_USER_COMMENT FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE SET NULL,
    CONSTRAINT FK_BLOG_COMMENT FOREIGN KEY(BLOG_NO) REFERENCES BLOG_T(BLOG_NO) ON DELETE CASCADE
);

-- 테스트용 INSERT
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user1@naver.com', STANDARD_HASH('1111', 'SHA256'), '사용자1', 'M', '01011111111', '11111', '디지털로', '가산동', '101동 101호', 0, 0, TO_DATE('20231001', 'YYYYMMDD'), TO_DATE('20220101', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user2@naver.com', STANDARD_HASH('2222', 'SHA256'), '사용자2', 'F', '01022222222', '22222', '디지털로', '가산동', '101동 101호', 0, 0, TO_DATE('20230801', 'YYYYMMDD'), TO_DATE('20220101', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user3@naver.com', STANDARD_HASH('3333', 'SHA256'), '사용자3', 'NO', '01033333333', '33333', '디지털로', '가산동', '101동 101호', 0, 0, TO_DATE('20230601', 'YYYYMMDD'), TO_DATE('20220101', 'YYYYMMDD'));

INSERT INTO ACCESS_T VALUES('user1@naver.com', TO_DATE('20231018', 'YYYYMMDD'));  -- 정상 회원 (user1)
INSERT INTO ACCESS_T VALUES('user2@naver.com', TO_DATE('20220201', 'YYYYMMDD'));  -- 휴면 회원 (user2)
                                                                                  -- 휴면 회원 (user3)
COMMIT;

-- 원글 입력
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user2@naver.com', '내용1', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user1@naver.com', '내용2', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user3@naver.com', '내용3', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user2@naver.com', '내용4', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user2@naver.com', '내용5', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user2@naver.com', '내용6', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user2@naver.com', '내용7', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user1@naver.com', '내용8', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user1@naver.com', '내용9', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user1@naver.com', '내용10', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user3@naver.com', '내용11', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user3@naver.com', '내용12', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user2@naver.com', '내용13', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user3@naver.com', '내용14', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user2@naver.com', '내용15', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user3@naver.com', '내용16', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user2@naver.com', '내용17', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user3@naver.com', '내용18', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user1@naver.com', '내용19', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
INSERT INTO FREE_T VALUES (FREE_SEQ.NEXTVAL, 'user1@naver.com', '내용20', SYSTIMESTAMP, 1, 0, FREE_SEQ.CURRVAL, 0);
COMMIT;


-- 블로그 쿼리 테스트

-- 1. 블로그 목록 (사용자 - 블로그 조인)

-- 부모 : 일대다 관계에서 일(PK, UNIQUE) - 사용자
-- 자식 : 일대다 관계에서 다(FK)         - 블로그

-- 내부 : 사용자와 블로그에 모두 존재하는 데이터를 조인하는 방식
-- 외부 : 사용자가 없는 블로그도 모두 조인하는 방식 (불가능)
--        블로그가 없는 사용자도 모두 조인하는 방식 (필요 없는 방식)

SELECT A.BLOG_NO, A.TITLE, A.CONTENTS, A.USER_NO, A.HIT, A.IP, A.CREATED_AT, A.MODIFIED_AT, A.EMAIL
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY B.BLOG_NO DESC) AS RN, B.BLOG_NO, B.TITLE, B.CONTENTS, B.USER_NO, B.HIT, B.IP, B.CREATED_AT, B.MODIFIED_AT, U.EMAIL
          FROM USER_T U INNER JOIN BLOG_T B
            ON B.USER_NO = U.USER_NO) A
 WHERE A.RN BETWEEN 1 AND 10;

-- 2. 블로그 상세

-- 1) 조회수 증가
UPDATE BLOG_T
   SET HIT = HIT + 1
 WHERE BLOG_NO = 1;

-- 2) 블로그 상세 정보 조회
SELECT B.BLOG_NO, B.TITLE, B.CONTENTS, B.HIT, B.IP, B.CREATED_AT, B.MODIFIED_AT, U.USER_NO, U.EMAIL, U.NAME
  FROM USER_T U, BLOG_T B
 WHERE U.USER_NO = B.USER_NO
   AND B.BLOG_NO = 1;

-- 3) 댓글 목록
-- 블로그 - 댓글 : 1:N (댓글이 달린 블로그 정보는 이미 상세보기에 모두 표시되어 있으므로 여기에선 조인할 필요가 없음)
-- 사용자 - 댓글 : 1:N (댓글의 사용자 이름을 표시)
SELECT A.COMMENT_NO, A.CONTENTS, A.BLOG_NO, A.CREATED_AT, A.STATUS, A.DEPTH, A.GROUP_NO, A.USER_NO, A.NAME
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY GROUP_NO DESC, DEPTH ASC, COMMENT_NO DESC) AS RN, C.COMMENT_NO, C.CONTENTS, C.BLOG_NO, C.CREATED_AT, C.STATUS, C.DEPTH, C.GROUP_NO, U.USER_NO, U.NAME
          FROM USER_T U INNER JOIN COMMENT_T C
            ON U.USER_NO = C.USER_NO
         WHERE C.BLOG_NO = 2) A
 WHERE A.RN BETWEEN 1 AND 10;



-- 계층 쿼리 테스트

-- 1. 목록 (??? 순으로 1 ~ 10)

-- 1) ROWNUM 가상 칼럼
SELECT FREE_NO, EMAIL, CONTENTS, CREATED_AT, STATUS, DEPTH, GROUP_NO, GROUP_ORDER
  FROM (SELECT ROWNUM AS RN, FREE_NO, EMAIL, CONTENTS, CREATED_AT, STATUS, DEPTH, GROUP_NO, GROUP_ORDER
          FROM (SELECT FREE_NO, EMAIL, CONTENTS, CREATED_AT, STATUS, DEPTH, GROUP_NO, GROUP_ORDER
                  FROM FREE_T
                 ORDER BY FREE_NO DESC))
 WHERE RN BETWEEN 1 AND 10;

-- 2) ROW_NUMBER() 함수
SELECT FREE_NO, EMAIL, CONTENTS, CREATED_AT, STATUS, DEPTH, GROUP_NO, GROUP_ORDER
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY FREE_NO DESC) AS RN, FREE_NO, EMAIL, CONTENTS, CREATED_AT, STATUS, DEPTH, GROUP_NO, GROUP_ORDER
          FROM FREE_T)
 WHERE RN BETWEEN 1 AND 10;
 
 
-- 2. 검색

-- 1) 결과 개수
SELECT COUNT(*)
  FROM FREE_T
 WHERE EMAIL LIKE '%' || 'user1' || '%';

-- 2) 결과 목록
SELECT FREE_NO, EMAIL, CONTENTS, CREATED_AT, STATUS, DEPTH, GROUP_NO, GROUP_ORDER
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY GROUP_NO DESC, GROUP_ORDER ASC) AS RN, FREE_NO, EMAIL, CONTENTS, CREATED_AT, STATUS, DEPTH, GROUP_NO, GROUP_ORDER
          FROM FREE_T
         WHERE EMAIL LIKE '%' || 'user1' || '%')
 WHERE RN BETWEEN 11 AND 20;



-- 사용자 쿼리 테스트

-- 1. 로그인 할 때(이메일, 비밀번호 입력)
-- 1) 정상 회원
SELECT USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, PW_MODIFIED_AT, JOINED_AT
  FROM USER_T
 WHERE EMAIL = 'user1@naver.com'
   AND PW = '0FFE1ABD1A08215353C233D6E009613E95EEC4253832A761AF28FF37AC5A150C';

INSERT INTO ACCESS_T VALUES('user1@naver.com', SYSDATE);
COMMIT;

-- 2) 휴면 회원
SELECT USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, PW_MODIFIED_AT, JOINED_AT
  FROM INACTIVE_USER_T
 WHERE EMAIL = 'user1@naver.com'
   AND PW = '0FFE1ABD1A08215353C233D6E009613E95EEC4253832A761AF28FF37AC5A150C';
-- 이후 휴면 복원으로 이동

-- 2. 이메일 중복 체크
SELECT EMAIL
  FROM USER_T
 WHERE EMAIL = 'user4@naver.com';

SELECT EMAIL
  FROM LEAVE_USER_T
 WHERE EMAIL = 'user4@naver.com';

SELECT EMAIL
  FROM INACTIVE_USER_T
 WHERE EMAIL = 'user4@naver.com';

-- 3. 휴면 처리 할 때 (12개월 이상 로그인 이력이 없다. 로그인 이력이 전혀 없는 사용자 중에서 가입일이 12개월 이상 지났다.)
INSERT INTO INACTIVE_USER_T
(
SELECT USER_NO, U.EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, PW_MODIFIED_AT, JOINED_AT, SYSDATE
  FROM USER_T U LEFT OUTER JOIN ACCESS_T A
    ON U.EMAIL = A.EMAIL
 WHERE MONTHS_BETWEEN(SYSDATE, LOGIN_AT) >= 12
    OR (LOGIN_AT IS NULL AND MONTHS_BETWEEN(SYSDATE, JOINED_AT) >= 12)
);

DELETE
  FROM USER_T
 WHERE EMAIL IN(SELECT U.EMAIL
                  FROM USER_T U LEFT OUTER JOIN ACCESS_T A
                    ON U.EMAIL = A.EMAIL
                 WHERE MONTHS_BETWEEN(SYSDATE, LOGIN_AT) >= 12
                    OR (LOGIN_AT IS NULL AND MONTHS_BETWEEN(SYSDATE, JOINED_AT) >= 12));
COMMIT;

-- 4. 휴면 복원 할 때
INSERT INTO USER_T
(
SELECT USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, PW_MODIFIED_AT, JOINED_AT
  FROM INACTIVE_USER_T
 WHERE EMAIL = 'user2@naver.com'
);

DELETE
  FROM INACTIVE_USER_T
 WHERE EMAIL = 'user2@naver.com';

SELECT USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, PW_MODIFIED_AT, JOINED_AT
  FROM USER_T
 WHERE EMAIL = 'user2@naver.com';

INSERT INTO ACCESS_T VALUES('user2@naver.com', SYSDATE);
COMMIT;

-- 5. 탈퇴 할 때
INSERT INTO LEAVE_USER_T VALUES('user1@naver.com', TO_DATE('20220101', 'YYYYMMDD'), SYSDATE);
DELETE FROM USER_T WHERE USER_NO = 1;
COMMIT;