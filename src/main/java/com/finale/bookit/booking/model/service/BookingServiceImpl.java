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

}
