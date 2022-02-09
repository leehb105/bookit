package com.finale.bookit.booking.model.service;

import com.finale.bookit.booking.model.dao.BookingDao;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BookingServiceImpl implements BookingService {

	@Autowired
	private BookingDao bookingDao;

	@Override
	public List<Booking> selectBookInfo(Map<String, Object> param) {
		return bookingDao.selectBookInfo(param);
	}

	@Override
	public int selectTotalBookingCount() {
		return bookingDao.selectTotalBookingCount();
	}

	@Override
	public Booking selectBooking(Map<String, Object> param) {
		return bookingDao.selectBooking(param);
	}

	@Override
	public List<BookInfo> selectBook(Map<String, Object> param) {
		return bookingDao.selectBook(param);
	}

	@Override
	public int selectCountByIsbn(String isbn13) {
		return bookingDao.selectCountByIsbn(isbn13);
	}

	@Override
	public int insertBookInfo(BookInfo bookInfo) {
		return bookingDao.insertBookInfo(bookInfo);
	}
	

}
