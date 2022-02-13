CREATE TABLE member (
	id	varchar2(20)		NOT NULL,
	password	varchar2(300)		NOT NULL,
	email	varchar2(30)		NOT NULL,
	nickname	varchar2(20)		NOT NULL,
	name	varchar2(20)		NOT NULL,
	phone	varchar2(11)		NULL,
	enabled	number	DEFAULT 1	NOT NULL,
	enroll_date	date	DEFAULT current_date	NULL,
	report_yn	varchar2(1)	DEFAULT 'N'	NOT NULL,
	cash	number	DEFAULT 0	NOT NULL

	,CONSTRAINT pk_member_id PRIMARY KEY(id)
	,CONSTRAINT ck_member_enabled check(enabled in (0, 1))
	,CONSTRAINT ck_member_report_yn check(report_yn in ('Y', 'N'))
	,CONSTRAINT uk_member_email UNIQUE(email)
	,CONSTRAINT uk_member_nickname UNIQUE(nickname)
);

CREATE TABLE book_info (
	isbn13	varchar2(13)		NOT NULL,
	title	varchar2(100)		NOT NULL,
	author	varchar2(50)		NOT NULL,
	publisher	varchar2(50)		NOT NULL,
	pubdate	date		NOT NULL,
	item_page	number		NULL,
	category_name	varchar2(100)		NULL,
	toc	varchar2(4000)		NULL,
	original_title	varchar2(200)		NULL,
	sub_title	varchar2(200)		NULL,
	cover	varchar2(500)		NULL,
	description	varchar2(2000)		NULL

	,constraint pk_book_info_isbn13 PRIMARY KEY(isbn13)
);

CREATE TABLE inquire (
	no	number		NOT NULL,
	title	varchar2(100)		NOT NULL,
	category	varchar2(20)		NOT NULL,
	content	varchar2(4000)		NOT NULL,
	reg_date	date	DEFAULT current_date	NOT NULL,
	member_id	varchar2(20)		NOT NULL

	,CONSTRAINT pk_inquire_no PRIMARY KEY(no)
	,CONSTRAINT fk_inquire_member_id FOREIGN KEY(member_id) REFERENCES member(id)
	,CONSTRAINT ck_inquire_category check(category IN ('게시판', '북토리', '대여'))
	
);
CREATE SEQUENCE seq_inquire_no nocache;

CREATE TABLE used_board (
	used_board_no	number		NOT NULL,
	title	varchar2(100)		NOT NULL,
	book_state	varchar2(20)		NOT NULL,
	trade_method	varchar2(20)		NOT NULL,
	category	varchar2(20)		NULL,
	content	varchar2(4000)		NOT NULL,
	writer	varchar2(20)		NOT NULL,
	delete_yn	varchar2(1)	DEFAULT 'N'	NULL,
	read_count	number	DEFAULT 0	NOT NULL,
	isbn13	varchar2(13)		NOT NULL

	,CONSTRAINT pk_used_board_used_board_no PRIMARY KEY(used_board_no)
	,CONSTRAINT fk_used_board_isbn13 FOREIGN KEY(isbn13) REFERENCES book_info(isbn13)
);
CREATE SEQUENCE seq_used_board_used_board_no nocache;

CREATE TABLE report_user (
	no	number		NOT NULL,
	reason	varchar2(20)		NULL,
	detail	varchar2(100)		NULL,
	reporter	varchar2(20)		NOT NULL,
	reportee	varchar2(20)		NOT NULL,
	reg_date	date	DEFAULT current_date	NOT NULL

	,CONSTRAINT pk_report_user_no PRIMARY KEY(no)
	,CONSTRAINT fk_report_user_reporter FOREIGN KEY(reporter) REFERENCES member(id)
	,CONSTRAINT fk_report_user_reportee FOREIGN KEY(reportee) REFERENCES member(id)
);
CREATE SEQUENCE seq_report_user_no nocache;

CREATE TABLE community (
	community_no	number		NOT NULL,
	title	varchar2(100)		NOT NULL,
	content	varchar2(4000)		NOT NULL,
	reg_date	date	DEFAULT current_date	NOT NULL,
	read_count	number	DEFAULT 0	NOT NULL,
	category	varchar2(20)		NULL,
	like_count	number	DEFAULT 0	NULL,
	report_yn	varchar2(1)	DEFAULT 'N'	NULL,
	delete_yn	varchar2(1)	DEFAULT 'N'	NULL,
	member_id	varchar2(20)		NOT NULL

	,CONSTRAINT pk_community_community_no PRIMARY KEY(community_no)
	,CONSTRAINT fk_community_member_id FOREIGN KEY(member_id) REFERENCES member(id)
	,CONSTRAINT ck_community_category check(category IN ('독서모임', '사담', '도서추천'))
	,CONSTRAINT ck_community_report_yn check(report_yn IN ('Y', 'N'))
	,CONSTRAINT ck_community_delete_yn check(delete_yn IN ('Y', 'N'))

);
CREATE SEQUENCE seq_community_community_no nocache;

CREATE TABLE charge_history (
	imp_uid varchar2(16)		NOT NULL,
	merchant_uid varchar2(20)	NOT NULL,
	pg_tid varchar2(20)			NOT NULL,
	charge_cash number			NOT NULL,
	bonus_cash number,
	charge_date date			NOT NULL,
	member_id varchar2(20)		NOT NULL

	,CONSTRAINT pk_charge_history_imp_uid PRIMARY KEY(imp_uid)
	,CONSTRAINT uq_charge_history_merchant_uid UNIQUE(merchant_uid)
	,CONSTRAINT fk_charge_history_member_id FOREIGN KEY(member_id) REFERENCES member(id)
	,CONSTRAINT ck_charge_history_charge_cash CHECK (charge_cash IN (2000, 5000, 10000, 20000))
);



CREATE TABLE rent (
	rent_no	number		NOT NULL,
	rent_start_date	date		NOT NULL,
	rent_end_date	date		NOT NULL,
	rent_state	varchar2(20)		NULL,
	reason	varchar2(50)		NULL,
	borrower_id	varchar2(20)		NOT NULL,
	board_no	number		NOT NULL,
	isbn13	varchar2(13)		NOT NULL

	,CONSTRAINT pk_rent_rent_no PRIMARY KEY(rent_no)
	,CONSTRAINT fk_rent_borrower_id FOREIGN KEY(borrower_id) REFERENCES member(id)
);
CREATE SEQUENCE seq_rent_rent_no nocache;

CREATE TABLE report_board (
	no	number		NOT NULL,
	board_no	number		NULL,
	reason	varchar2(20)		NOT NULL,
	detail	varchar2(100)		NULL,
	reporter	varchar2(20)		NOT NULL,
	reg_date	date	DEFAULT current_date	NOT NULL,
	board_id	varchar2(20)		NOT NULL

	,CONSTRAINT pk_report_board_no PRIMARY KEY(no)
	,CONSTRAINT fk_report_board_reporter FOREIGN KEY(reporter) REFERENCES member(id)
	,CONSTRAINT fk_report_board_board_id FOREIGN KEY(board_id) REFERENCES board_id(id)
	,CONSTRAINT ck_report_board_reason check(reason IN ('욕설', '사기', '도배', '음란물', '광고'))
);
CREATE SEQUENCE seq_report_board_no nocache;

CREATE TABLE community_comment (
	no	number		NOT NULL,
	content	varchar2(200)		NOT NULL,
	comment_ref	number		NULL,
	reg_date	date	DEFAULT current_date	NOT NULL,
	community_no	number		NOT NULL,
	writer	varchar2(20)		NOT NULL,
	delete_yn	varchar2(1)	DEFAULT 'N'	NULL,
	comment_level	number	DEFAULT 1	NOT NULL

	,constraint pk_community_comment PRIMARY KEY(no)
	,constraint fk_community_comment_writer FOREIGN key(writer) REFERENCES member(id)
	,constraint fk_community_comment_community_no FOREIGN key(community_no) REFERENCES community(community_no)
	,constraint fk_community_comment_comment_ref FOREIGN key(comment_ref) REFERENCES community_comment(no)
	,constraint ck_community_comment_delete_yn check(delete_yn IN ('Y', 'N'))
);
CREATE SEQUENCE seq_community_comment_no nocache;

CREATE TABLE profile_image (
	member_id	varchar2(20)		NOT NULL,
	original_filename	varchar2(255)		NULL,
	renamed_filename	varchar2(255)		NULL

	,constraint pk_profile_image PRIMARY KEY(member_id)
	,constraint fk_profile_image_member_id FOREIGN key(member_id) REFERENCES member(id)
);

CREATE TABLE review (
	no	number		NOT NULL,
	rating	number		NULL,
	sender_id	varchar2(20)		NOT NULL, 
	receiver_id	varchar2(20)		NOT NULL 

	,constraint pk_review_no PRIMARY KEY(no)
	,constraint fk_review_sender_id FOREIGN key(sender_id) REFERENCES member(id)
	,constraint fk_review_receiver_id FOREIGN key(receiver_id) REFERENCES member(id)

);
CREATE SEQUENCE seq_review_no nocache;

CREATE TABLE request_board (
	no	number		NOT NULL,
	wish_price	number		NULL,
	book_condition	varchar2(6)		NULL,
	member_id	varchar2(20)		NOT NULL,
	delete_yn	varchar2(1)	DEFAULT 'N'	NULL,
	isbn13	varchar2(13)		NOT NULL

	,constraint pk_request_board_no PRIMARY KEY(no)
	,constraint fk_request_board_isbn13 FOREIGN key(isbn13) REFERENCES book_info(isbn13)
	,constraint fk_request_board_member_id FOREIGN key(member_id) REFERENCES member(id)
	,constraint ck_request_board_book_condition check(book_condition IN ('최상', '상', '중', '하', '최하'))
);
CREATE SEQUENCE seq_request_board_no nocache;

CREATE TABLE book_collection (
	no	number		NOT NULL,
	collection_no	number		NOT NULL,
	collection_name	varchar2(50)		NOT NULL,
	member_nickname	varchar2(20)		NOT NULL,
	isbn13	varchar2(13)		NOT NULL

	,constraint pk_book_collection_no_collection_no PRIMARY KEY(no, collection_no)
	,constraint fk_book_collection_member_nickname FOREIGN key(member_nickname) REFERENCES member(nickname)
	,constraint fk_book_collection_isbn13 FOREIGN key(isbn13) REFERENCES book_info(isbn13)
);
CREATE SEQUENCE seq_book_collection_no nocache;

CREATE TABLE book_review (
	isbn13	varchar2(13)		NOT NULL,
	content	varchar2(300)		NULL,
	rating	number		NOT NULL,
	writer	varchar2(20)		NOT NULL,
	delete_yn	varchar2(1)	DEFAULT 'N'	NOT NULL

	,constraint pk_book_review_isbn13 PRIMARY KEY(isbn13)
	,constraint fk_book_review_isbn13 FOREIGN key(isbn13) REFERENCES book_info(isbn13)
	,constraint fk_book_review_writer FOREIGN key(writer) REFERENCES member(id)
	,constraint ck_book_review_delete_yn check(delete_yn IN ('Y', 'N'))
);

CREATE TABLE authority (
	authority	varchar2(20)		NOT NULL,
	member_id	varchar2(20)		NOT NULL

	,constraint pk_authority_authority PRIMARY KEY(authority, member_id) -- 기본키 복합키로 변경했습니다.
	,constraint fk_authority_member_id FOREIGN key(member_id) REFERENCES member(id)
);
select * from authority;
alter table authority modify(authority varchar2(20) default 'ROLE_USER');
CREATE TABLE board_id (
	board_id	varchar2(20)		NOT NULL,
	board_name	varchar2(20)		NOT NULL

	,constraint pk_board_id_board_id PRIMARY KEY(board_id)
);

CREATE TABLE booking (
	board_no	number		NOT NULL,
	content	varchar2(400)		NOT NULL,
	book_status	varchar2(20)		NOT NULL,
	price	number		NULL,
	deposit	number		NOT NULL,
	writer	varchar2(20)		NOT NULL,
	delete_yn	varchar2(1)	DEFAULT 'N'	NULL,
	isbn13	varchar2(13)		NOT NULL

	,constraint pk_booking_board_no PRIMARY KEY(board_no)
	,constraint fk_booking_writer FOREIGN key(writer) REFERENCES member(id)
	,constraint fk_booking_isbn13 FOREIGN key(isbn13) REFERENCES book_info(isbn13)
	,constraint ck_booking_book_status check(book_status IN ('최상', '상', '중', '하', '최하'))
	,constraint ck_booking_delete_yn check(delete_yn IN ('Y', 'N'))
);
CREATE SEQUENCE seq_booking_board_no nocache;

CREATE TABLE persistent_login (
	series	varchar2(64)		NOT NULL,
	last_used	timestamp		NOT NULL,
	member_id	varchar2(20)		NOT NULL,
	token	varchar2(64)		NOT NULL
	
	,constraint pk_persistent_login_series PRIMARY KEY(series)
);

CREATE TABLE community_attachment (
	no	number		NOT NULL,
	original_filename	varchar2(255)		NOT NULL,
	renamed_filename	varchar2(255)		NOT NULL,
	reg_date	date	DEFAULT current_date	NOT NULL,
	community_no	number		NOT NULL

	,constraint pk_community_attachment_no PRIMARY KEY(no)
	,constraint fk_community_attachment_community_no FOREIGN key(community_no) REFERENCES community(community_no)
);
CREATE SEQUENCE seq_community_attachment_no nocache;

CREATE TABLE used_board_attachment (
	no	number		NOT NULL,
	original_filenmae	varchar2(255)		NOT NULL,
	renamed_filename	varchar2(255)		NOT NULL,
	reg_date	date	DEFAULT current_date	NOT NULL,
	used_board_no	number		NOT NULL 

	,constraint pk_userd_board_attachment PRIMARY KEY(no)
	,constraint fk_used_board_attachment_community_no FOREIGN key(community_no) REFERENCES community(community_no)
);
CREATE SEQUENCE seq_used_board_attachment_no nocache;

CREATE TABLE chat_room (
	chat_room_id	number		NOT NULL,
	chat_member_id	varchar2(50)		NOT NULL

	,constraint pk_chat_room_chat_room_id_chat_member_id PRIMARY KEY(chat_room_id)
);

-- CREATE TABLE chat_history (
-- 	chat_room_id	number		NOT NULL,
-- 	--receiver_id	varchar2(20)		NOT NULL,
-- 	sender_id	varchar2(20)		NOT NULL,
-- 	message	varchar2(300)		NULL,
-- 	send_date	date	DEFAULT current_date	NULL

-- 	,constraint pk_chat_history_chat_room_id PRIMARY KEY(chat_room_id)
-- 	--,constraint fk_chat_history_chat_room_id FOREIGN key(chat_room_id) REFERENCES chat_room(chat_room_id)
-- 	,constraint fk_chat_history_chat_room_id FOREIGN key(chat_room_id, sender_id) REFERENCES chat_room(chat_room_id, chat_member_id)
-- 	,constraint fk_chat_history_receiver_id FOREIGN key(receiver_id) REFERENCES member(id)
-- 	,constraint fk_chat_history_sender_id FOREIGN key(sender_id) REFERENCES member(id)
-- );

CREATE TABLE chat_history (
	chat_room_id	number		NOT NULL,
	sender_id	varchar2(20)		NOT NULL,
	message	varchar2(300)		NULL,
	send_date	date	DEFAULT current_date	NULL

	,constraint pk_chat_history_chat_room_id PRIMARY KEY(chat_room_id)
	,constraint fk_chat_history_chat_room_id FOREIGN key(chat_room_id, sender_id) REFERENCES chat_room(chat_room_id, chat_member_id)
);

CREATE TABLE address (
	member_id		varchar2(20)		NOT NULL,
	postcode		varchar2(10)		NULL,
	road_address	varchar2(100)		NULL,
	extra_address	varchar2(100)		NULL,
	depth1			varchar2(20)		NOT NULL,
	depth2			varchar2(30)		NOT NULL,
	depth3			varchar2(50)		NOT NULL,
	bunji1			varchar2(10)		NULL,
	bunji2			varchar2(10)		NULL,
	detail_address	varchar2(100)		NULL,
	latitude		float				NOT NULL,
	longitude		float				NOT NULL

	,CONSTRAINT  pk_address_member_id PRIMARY KEY(member_id)
	,CONSTRAINT  fk_address_member_id FOREIGN key(member_id) REFERENCES member(id) ON DELETE cascade
);
COMMENT ON COLUMN address.postcode IS '우편번호';
COMMENT ON COLUMN address.road_address IS '도로명 주소';
COMMENT ON COLUMN address.extra_address IS '도로명 주소에 붙는 건물명';
COMMENT ON COLUMN address.depth1 IS '도/광역시';
COMMENT ON COLUMN address.depth2 IS '시/군 + 구';
COMMENT ON COLUMN address.depth3 IS '동/읍/면 + 리';
COMMENT ON COLUMN address.bunji1 IS '번지1';	-- int가 맞지만 혹시 몰라 string으로
COMMENT ON COLUMN address.bunji2 IS '번지2';		-- int가 맞지만 혹시 몰라 string으로
COMMENT ON COLUMN address.detail_address IS '사용자가 입력한 상세 주소';
COMMENT ON COLUMN address.latitude IS '위도';
COMMENT ON COLUMN address.longitude IS '경도';

GRANT CREATE VIEW TO spring;
CREATE OR REPLACE VIEW member_view
AS
SELECT
	m.*,
	a.LATITUDE,
	a.LONGITUDE,
	a.road_address || nvl2(a.extra_address, ' (' || a.extra_address || ')', '') AS road_address,
	a.depth1 || ' ' || a.depth2 || ' ' || a.depth3 || ' ' || a.bunji1 || nvl2(a.bunji2, '-' || a.bunji2, '') || ' ' || a.detail_address AS jibun_address
FROM MEMBER m LEFT JOIN address a
	ON m.id = a.member_id;

SELECT * FROM member_view;

CREATE TABLE wishlist (
	member_id	varchar2(20)		NOT NULL,
	board_no	number		NOT NULL

	,constraint pk_wishlist_board_no_member_id PRIMARY KEY(board_no, member_id)
	,constraint fk_wishlist_member_id FOREIGN key(member_id) REFERENCES member(id)
	,constraint fk_wishlist_board_no FOREIGN key(board_no) REFERENCES booking(board_no)
);

CREATE TABLE rent_deposit (
	rent_no	number		NOT NULL,
	deposit	number		NULL,
	refunds	varchar2(1)	DEFAULT 'N'	NOT NULL

	,constraint pk_rent_deposit_rent_no PRIMARY KEY(rent_no)
	,constraint ck_rent_deposit_refunds check(refunds IN ('Y', 'N'))
);
CREATE SEQUENCE seq_rent_deposit_rent_no nocache;

CREATE TABLE my_trade_history (
	rent_no	number		NOT NULL,
	price	number		NOT NULL,
	cash	number		NOT NULL,
	trade_date	date		NOT NULL

	,constraint pk_my_trade_history_rent_no PRIMARY KEY(rent_no)
);
CREATE SEQUENCE seq_my_trade_history_rent_no nocache;


create table admin_inquire(
    no number,
    inquire_no number,
    admin_id varchar2(20),  -- 제약조건 아직 안 넣었습니다
    admin_name varchar2(30),
    content varchar2(4000),
    reg_date date default sysdate,
    condition number default 1,
    constraint pk_admin_inquire_no primary key(no),
    constraint fk_admin_inquire_inquire_no foreign key(inquire_no) references inquire(no)
);
create sequence seq_admin_inquire_no;



insert into member values('chart2','$2a$10$/7oikXVoSStVl3qVBL3B5.S7x1hb7PcNWRkV7j7XAVR.P0Iom78iK','chartTest2@naver.com','ch2','차트테스트','01012345678',1,'2022-03-03','N',0);
insert into member values('chart3','$2a$10$/7oikXVoSStVl3qVBL3B5.S7x1hb7PcNWRkV7j7XAVR.P0Iom78iK','chartTest3@naver.com','ch3','차트테스트','01012345678',1,'2022-04-03','N',0);
insert into member values('chart3.1','$2a$10$/7oikXVoSStVl3qVBL3B5.S7x1hb7PcNWRkV7j7XAVR.P0Iom78iK','chartTest3.1@naver.com','ch3.1','차트테스트','01012345678',1,'2022-04-05','N',0);
insert into member values('chart4','$2a$10$/7oikXVoSStVl3qVBL3B5.S7x1hb7PcNWRkV7j7XAVR.P0Iom78iK','chartTest4@naver.com','ch4','차트테스트','01012345678',1,'2022-05-03','N',0);
insert into member values('chart5','$2a$10$/7oikXVoSStVl3qVBL3B5.S7x1hb7PcNWRkV7j7XAVR.P0Iom78iK','chartTest5@naver.com','ch5','차트테스트','01012345678',1,'2022-06-03','N',0);
insert into member values('chart6','$2a$10$/7oikXVoSStVl3qVBL3B5.S7x1hb7PcNWRkV7j7XAVR.P0Iom78iK','chartTest2@naver.com','ch6','차트테스트','01012345678',1,'2022-07-03','N',0);

select  extract(month from m.enroll_date),count(*) from member m where extract(month from m.enroll_date) is not null group by extract(month from m.enroll_date) order by extract(month from m.enroll_date) asc;
delete from member where id ='chart1';
commit;

select * from (select count(*) from member group by extract(day from enroll_date));


		select
            extract(month from ch.charge_date) as month,
			round(avg(charge_cash),0) as cash
		from
			charge_history ch
        group by
            extract(month from ch.charge_date);
            
		select
		    *
		from
		    member m left join authority a
		    on m.id = a.member_id;            

--DROP TRIGGER trig_member;
--SQL Error [4098] [42000]: ORA-04098 오류 발생시 trigger drop 후에 재생성
CREATE OR REPLACE TRIGGER trig_member
	AFTER
	INSERT ON charge_history
	FOR EACH ROW
BEGIN 
	UPDATE
		MEMBER
	SET cash = cash + :NEW.charge_cash + :NEW.bonus_cash
	WHERE id = :NEW.member_id;
END;
/;	