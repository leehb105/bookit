package com.finale.bookit.booking.model.service;

import com.finale.bookit.booking.model.dao.BookingDao;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.booking.model.vo.BookingEntity;
import com.finale.bookit.common.util.Criteria;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BookingServiceImpl implements BookingService {

	@Autowired
	private BookingDao bookingDao;

	@Override
	public List<Booking> selectBookingList(Map<String, Object> param) {
		return bookingDao.selectBookingList(param);
	}

	@Override
	public int selectTotalBookingCount(Map<String, Object> param) {
		return bookingDao.selectTotalBookingCount(param);
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

	@Override
	public int insertBooking(Booking booking) {
		return bookingDao.insertBooking(booking);
	}

	@Override
	public List<Booking> selectBorrowedList(HashMap<String, Object> param) {
		return bookingDao.selectBorrowedList(param);
	}

	@Override
	public List<Booking> selectLentList(Map<String, Object> param) {
		return bookingDao.selectLentList(param);
	}

	@Override
	public List<Booking> selectMyBookingList(Map<String, Object> param) {
		return bookingDao.selectMyBookingList(param);
	}

	@Override
	public int selectTotalMyBookingCount(Map<String, Object> param) {
		return bookingDao.selectTotalMyBookingCount(param);
	}

	@Override
	public int selectTotalMyLentBookingCount(Map<String, Object> param) {
		return bookingDao.selectTotalMyLentBookingCount(param);
	}

	@Override
	public int selectWishCount(Map<String, Object> param) {
		return bookingDao.selectWishCount(param);
	}

	@Override
	public int insertBookingReservation(HashMap<String, Object> param) {
		return bookingDao.insertBookingReservation(param);
	}

	@Override
	public int selectTotalMyBorrowedBookingCount(HashMap<String, Object> param) {
		return bookingDao.selectTotalMyBorrowedBookingCount(param);
	}

	@Override
	public int updateUserCash(HashMap<String, Object> param) {
		return bookingDao.updateUserCash(param);
	}

	

}
