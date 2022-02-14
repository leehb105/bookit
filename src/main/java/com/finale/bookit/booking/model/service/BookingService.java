package com.finale.bookit.booking.model.service;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.BookingEntity;
import com.finale.bookit.common.util.Criteria;

import java.util.List;
import java.util.Map;

public interface BookingService {
	public List<BookingEntity> selectBookingList(Map<String, Object> param);

	int selectTotalBookingCount(Map<String, Object> param);

	public BookingEntity selectBooking(Map<String, Object> param);

	public List<BookInfo> selectBook(Map<String, Object> param);

	public int selectCountByIsbn(String isbn13);

	public int insertBookInfo(BookInfo bookInfo);

	public int insertBooking(BookingEntity booking);

	public List<BookingEntity> selectBorrowedList(String id);

	public List<BookingEntity> selectLentList(Map<String, Object> param);

	public List<BookingEntity> selectMyBookingList(Map<String, Object> param);

	public int selectTotalMyBookingCount(Map<String, Object> param);

	public int selectTotalMyLentBookingCount(Map<String, Object> param);

	public int selectWishCount(Map<String, Object> param);
	
}
