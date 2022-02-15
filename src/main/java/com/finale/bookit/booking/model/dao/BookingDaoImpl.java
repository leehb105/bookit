package com.finale.bookit.booking.model.dao;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.booking.model.vo.BookingEntity;
import com.finale.bookit.common.util.Criteria;

import lombok.extern.slf4j.Slf4j;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@Slf4j
public class BookingDaoImpl implements BookingDao{
    @Autowired
    private SqlSessionTemplate session;

    @Override
    public int selectTotalBookingCount(Map<String, Object> param) {
        return session.selectOne("booking.selectTotalBookingCount", param);
    }

    @Override
    public List<Booking> selectBookingList(Map<String, Object> param) {
        return session.selectList("booking.selectBookingList", param);
    }

	@Override
	public Booking selectBooking(Map<String, Object> param) {
		return session.selectOne("booking.selectBooking", param);
	}

	@Override
	public List<BookInfo> selectBook(Map<String, Object> param) {
		return session.selectList("booking.selectBook", param);
	}

	@Override
	public int selectCountByIsbn(String isbn13) {
		return session.selectOne("booking.selectCountByIsbn", isbn13);
	}

	@Override
	public int insertBookInfo(BookInfo bookInfo) {
		return session.insert("booking.insertBookInfo", bookInfo);
	}

	@Override
	public int insertBooking(Booking booking) {
		return session.insert("booking.insertBooking", booking);
	}

	@Override
	public List<Booking> selectBorrowedList(HashMap<String, Object> param) {
		return session.selectList("booking.selectBorrowedList", param);
	}

	@Override
	public List<Booking> selectLentList(Map<String, Object> param) {
		log.debug("dao list = {}  ", session.selectList("booking.selectLentList", param));
		return session.selectList("booking.selectLentList", param);
	}

	@Override
	public List<Booking> selectMyBookingList(Map<String, Object> param) {
		return session.selectList("booking.selectMyBookingList", param);
	}

	@Override
	public int selectTotalMyBookingCount(Map<String, Object> param) {
		return session.selectOne("booking.selectTotalMyBookingCount", param);
	}

	@Override
	public int selectTotalMyLentBookingCount(Map<String, Object> param) {
		return session.selectOne("booking.selectTotalMyLentBookingCount", param);
	}

	@Override
	public int selectWishCount(Map<String, Object> param) {
		return session.selectOne("booking.selectWishCount", param);
	}

	@Override
	public int insertBookingReservation(HashMap<String, Object> param) {
		return session.insert("booking.insertBookingReservation", param);
	}

	@Override
	public int selectTotalMyBorrowedBookingCount(HashMap<String, Object> param) {
		return session.selectOne("booking.selectTotalMyBorrowedBookingCount", param);
	}

	@Override
	public int selectOneBookingReservation(HashMap<String, Object> param) {
		return session.selectOne("booking.selectOneBookingReservation", param);
	}

	@Override
	public int selectOneBookingReservation2(HashMap<String, Object> param) {
		return session.selectOne("booking.selectOneBookingReservation2", param);
	}

	@Override
	public int deleteBooking(HashMap<String, Object> param) {
		return session.update("booking.deleteBooking", param);
	}

	@Override
	public int selectCountBookingReservation(HashMap<String, Object> param) {
		return session.selectOne("booking.selectCountBookingReservation", param);
	}

	@Override
	public Booking selectLentBooking(Map<String, Object> param) {
		return session.selectOne("booking.selectLentBooking", param);
	}

	@Override
	public int updateBookResStatus(HashMap<String, Object> param) {
		return session.update("booking.updateBookResStatus", param);
	}

	
}
