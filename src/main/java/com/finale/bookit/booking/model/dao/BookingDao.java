package com.finale.bookit.booking.model.dao;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.booking.model.vo.BookingEntity;
import com.finale.bookit.common.util.Criteria;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface BookingDao {

    int selectTotalBookingCount(Map<String, Object> param);

    List<Booking> selectBookingList(Map<String, Object> param);

    Booking selectBooking(Map<String, Object> param);

	List<BookInfo> selectBook(Map<String, Object> param);

	int selectCountByIsbn(String isbn13);

	int insertBookInfo(BookInfo bookInfo);

	int insertBooking(Booking booking);

	List<Booking> selectBorrowedList(HashMap<String, Object> param);

	List<Booking> selectLentList(Map<String, Object> param);

	List<Booking> selectMyBookingList(Map<String, Object> param);

	int selectTotalMyBookingCount(Map<String, Object> param);

	int selectTotalMyLentBookingCount(Map<String, Object> param);

	int selectWishCount(Map<String, Object> param);

	int insertBookingReservation(HashMap<String, Object> param);

	int selectTotalMyBorrowedBookingCount(HashMap<String, Object> param);

	int selectOneBookingReservation(HashMap<String, Object> param);

	int selectOneBookingReservation2(HashMap<String, Object> param);

	int deleteBooking(HashMap<String, Object> param);

	int selectCountBookingReservation(HashMap<String, Object> param);

	Booking selectLentBooking(Map<String, Object> param);

	int updateBookResStatus(HashMap<String, Object> param);

	int insertUserReview(HashMap<String, Object> param);

	int selectCountUserReview(Map<String, Object> param);

	Booking selectBorrowedBooking(Map<String, Object> param);
}
