package com.finale.bookit.booking.model.dao;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.BookingEntity;
import com.finale.bookit.common.util.Criteria;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BookkingDaoImpl implements BookingDao{
    @Autowired
    private SqlSessionTemplate session;

    @Override
    public int selectTotalBookingCount(Map<String, Object> param) {
        return session.selectOne("booking.selectTotalBookingCount", param);
    }

    @Override
    public List<BookingEntity> selectBookingList(Map<String, Object> param) {
        return session.selectList("booking.selectBookingList", param);
    }

	@Override
	public BookingEntity selectBooking(Map<String, Object> param) {
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
	public int insertBooking(BookingEntity booking) {
		return session.insert("booking.insertBooking", booking);
	}

	@Override
	public List<BookingEntity> selectBorrowedList(String id) {
		return session.selectList("booking.selectBorrowedList", id);
	}

	@Override
	public List<BookingEntity> selectLentList(Map<String, Object> param) {
		return session.selectList("booking.selectLentList", param);
	}

	@Override
	public List<BookingEntity> selectMyBookingList(Map<String, Object> param) {
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


	
	
}
