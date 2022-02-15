package com.finale.bookit.booking.model.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.finale.bookit.common.util.Criteria;
import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString(callSuper = true)
public class Booking extends BookingEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int rowNum;
	private BookInfo bookInfo;
    private List<BookInfo> bookInfos;
    private BookReservation bookReservation;
    private List<BookReservation> bookReservations;
    private Address address;
    private Member member;
    private Criteria cri;
    private List<Booking> bookingList;
    
	public Booking(int boardNo, String content, String bookStatus, int price, int deposit, String writer,
			String deleteYn, String isbn13, Date regDate, int rowNum, BookInfo bookInfo, List<BookInfo> bookInfos,
			BookReservation bookReservation,
			List<BookReservation> bookReservations, Address address, Member member, Criteria cri, List<Booking> bookingList) {
		super(boardNo, content, bookStatus, price, deposit, writer, deleteYn, isbn13, regDate);
		this.rowNum = rowNum;
		this.bookInfo = bookInfo;
		this.bookInfos = bookInfos;
		this.bookReservation = bookReservation;
		this.bookReservations = bookReservations;
		this.address = address;
		this.member = member;
		this.cri = cri;
		this.bookingList = bookingList;
		
	}
}
