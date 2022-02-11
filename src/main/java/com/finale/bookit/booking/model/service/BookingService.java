package com.finale.bookit.booking.model.service;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.booking.model.vo.Criteria;

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
	
}
