package com.finale.bookit.booking.model.service;

import com.finale.bookit.booking.model.dao.BookingDao;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.booking.model.vo.BookingEntity;
import com.finale.bookit.common.util.Criteria;
import com.finale.bookit.member.model.dao.MemberDao;
import com.finale.bookit.trade.model.dao.TradeDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor=Exception.class)
public class BookingServiceImpl implements BookingService {

	@Autowired
	private BookingDao bookingDao;

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private TradeDao tradeDao;

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
		int result = bookingDao.insertBookingReservation(param);
		int resNo = bookingDao.selectOneBookingReservation(param);
		param.put("resNo", resNo);
		if(result > 0) {
			result = memberDao.updateMemberCash(param);
			if (result > 0) {
				result = memberDao.chargeMemberCash(param);
			}
			int borrowerCash = memberDao.selectMemberCash(param);
			param.put("borrowerCash", borrowerCash);
			int lenderCash = memberDao.selectMemberCash2(param);
			param.put("lenderCash", lenderCash);
			
			if(result > 0) {
				result = tradeDao.insertTrade(param);
			}
		}
		return result;
	}

	@Override
	public int selectTotalMyBorrowedBookingCount(HashMap<String, Object> param) {
		return bookingDao.selectTotalMyBorrowedBookingCount(param);
	}

	@Override
	public int deleteBooking(HashMap<String, Object> param) {
		return bookingDao.deleteBooking(param);
	}

	@Override
	public int selectCountBookingReservation(HashMap<String, Object> param) {
		return bookingDao.selectCountBookingReservation(param);
	}

	@Override
	public Booking selectLentBooking(Map<String, Object> param) {
		return bookingDao.selectLentBooking(param);
	}

	@Override
	public int updateBookResStatus(HashMap<String, Object> param) {
		int result = bookingDao.updateBookResStatus(param);
		if (result > 0) {
			result = memberDao.updateReturnDeposit(param);
			if (result > 0) {
				result = tradeDao.insertTrade(param);
			}
		}
		return result;
	}

	@Override
	public int insertUserReview(HashMap<String, Object> param) {
		return bookingDao.insertUserReview(param);
	}

	@Override
	public int selectCountUserReview(Map<String, Object> param) {
		return bookingDao.selectCountUserReview(param);
	}

	@Override
	public Booking selectBorrowedBooking(Map<String, Object> param) {
		return bookingDao.selectBorrowedBooking(param);
	}

	
}
