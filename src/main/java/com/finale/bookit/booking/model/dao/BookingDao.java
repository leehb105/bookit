package com.finale.bookit.booking.model.dao;

import com.finale.bookit.booking.model.vo.Booking;

import java.util.List;
import java.util.Map;

public interface BookingDao {

    int selectTotalBookingCount();

    List<Booking> selectBookInfo(Map<String, Object> param);

	Booking selectBooking(Map<String, Object> param);
}
