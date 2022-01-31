package com.finale.bookit.booking.model.service;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;

import java.util.List;
import java.util.Map;

public interface BookingService {
	public List<Booking> selectBookInfo(Map<String, Object> param);

	int selectTotalBookingCount();

	public Booking selectBooking(Map<String, Object> param);
}
