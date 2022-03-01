package com.finale.bookit.booking.model.service;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.booking.model.vo.BookingEntity;
import com.finale.bookit.common.util.Criteria;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface BookingService {
	public List<Booking> selectBookingList(Map<String, Object> param);

	int selectTotalBookingCount(Map<String, Object> param);

	public Booking selectBooking(Map<String, Object> param);

	public List<BookInfo> selectBook(Map<String, Object> param);

	public int selectCountByIsbn(String isbn13);

	public int insertBookInfo(BookInfo bookInfo);

	public int insertBooking(Booking booking);

	public List<Booking> selectBorrowedList(HashMap<String, Object> param);

	public List<Booking> selectLentList(Map<String, Object> param);

	public List<Booking> selectMyBookingList(Map<String, Object> param);

	public int selectTotalMyBookingCount(Map<String, Object> param);

	public int selectTotalMyLentBookingCount(Map<String, Object> param);

	public int selectWishCount(Map<String, Object> param);

	public int insertBookingReservation(HashMap<String, Object> param);

	public int selectTotalMyBorrowedBookingCount(HashMap<String, Object> param);

	public int deleteBooking(HashMap<String, Object> param);

	public int selectCountBookingReservation(HashMap<String, Object> param);

	public Booking selectLentBooking(Map<String, Object> param);

	public int updateBookResStatus(HashMap<String, Object> param);

	public int insertUserReview(HashMap<String, Object> param);

	public int selectCountUserReview(Map<String, Object> param);

	public Booking selectBorrowedBooking(Map<String, Object> param);

}
