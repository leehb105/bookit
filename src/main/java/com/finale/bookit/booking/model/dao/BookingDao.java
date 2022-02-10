package com.finale.bookit.booking.model.dao;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;

import java.util.List;
import java.util.Map;

public interface BookingDao {

    int selectTotalBookingCount();

    List<Booking> selectBookingList(Map<String, Object> param);

	Booking selectBooking(Map<String, Object> param);

	List<BookInfo> selectBook(Map<String, Object> param);

	int selectCountByIsbn(String isbn13);

	int insertBookInfo(BookInfo bookInfo);

	int insertBooking(Booking booking);
}
