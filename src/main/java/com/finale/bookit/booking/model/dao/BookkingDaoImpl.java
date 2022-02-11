package com.finale.bookit.booking.model.dao;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.booking.model.vo.Criteria;

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


	
	
}
