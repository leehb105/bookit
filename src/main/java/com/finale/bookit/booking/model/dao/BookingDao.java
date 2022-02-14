package com.finale.bookit.booking.model.dao;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.BookingEntity;
import com.finale.bookit.common.util.Criteria;

import java.util.List;
import java.util.Map;

public interface BookingDao {

    int selectTotalBookingCount(Map<String, Object> param);

    List<BookingEntity> selectBookingList(Map<String, Object> param);

	BookingEntity selectBooking(Map<String, Object> param);

	List<BookInfo> selectBook(Map<String, Object> param);

	int selectCountByIsbn(String isbn13);

	int insertBookInfo(BookInfo bookInfo);

	int insertBooking(BookingEntity booking);

	List<BookingEntity> selectBorrowedList(String id);

	List<BookingEntity> selectLentList(Map<String, Object> param);

	List<BookingEntity> selectMyBookingList(Map<String, Object> param);

	int selectTotalMyBookingCount(Map<String, Object> param);

	int selectTotalMyLentBookingCount(Map<String, Object> param);

	int selectWishCount(Map<String, Object> param);

}
