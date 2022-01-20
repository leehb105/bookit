CREATE TABLE member (
	id	varchar2(20)		NOT NULL,
	password	varchar2(300)		NOT NULL,
	email	varchar2(11)		NOT NULL,
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
	detail	varchar2(20)		NULL,
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
	no	number		NOT NULL,
	charge_cash	number		NOT NULL,
	bonus_cash	number		NOT NULL,
	charge_date	date	DEFAULT current_date	NOT NULL,
	member_id	varchar2(20)		NOT NULL

	,CONSTRAINT pk_charge_history_no PRIMARY KEY(no)
	,CONSTRAINT fk_charge_history_member_id FOREIGN KEY(member_id) REFERENCES member(id)
);
CREATE SEQUENCE seq_charge_history_no nocache;

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
	collection_name	varchar2(20)		NOT NULL,
	member_id	varchar2(20)		NOT NULL,
	isbn13	varchar2(13)		NOT NULL

	,constraint pk_book_collection_no_collection_no PRIMARY KEY(no, collection_no)
	,constraint fk_book_collection_member_id FOREIGN key(member_id) REFERENCES member(id)
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

	,constraint pk_authority_authority PRIMARY KEY(authority)
	,constraint fk_authority_member_id FOREIGN key(member_id) REFERENCES member(id)
);

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
	chat_member_id	varchar2(20)		NOT NULL

	,constraint pk_chat_room_chat_room_id_chat_member_id PRIMARY KEY(chat_room_id, chat_member_id)
	,constraint fk_chat_room_chat_member_id FOREIGN key(chat_member_id) REFERENCES member(id)
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
	member_id	varchar2(20)		NOT NULL,
	land_lot	varchar2(100)		NULL,
	road_name	varchar2(100)		NULL,
	detail_address	varchar2(100)		NULL,
	latitude	float(126)		NULL,
	longitude	float(126)		NULL

	,constraint pk_address_member_id PRIMARY KEY(member_id)
	,constraint fk_address_member_id FOREIGN key(member_id) REFERENCES member(id)
);

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
