package com.finale.bookit.booking.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.finale.bookit.common.util.Criteria;
import com.finale.bookit.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Booking extends BookingEntity implements Serializable {
	
    private BookInfo bookInfo;
    private List<BookInfo> bookInfos;
    private List<BookReservation> bookReservations;
    private Member member;
    private Criteria cri;
    
	public Booking(int boardNo, String content, String bookStatus, int price, int deposit, String writer,
			String deleteYn, String isbn13, Date regDate, BookInfo bookInfo, List<BookInfo> bookInfos,
			List<BookReservation> bookReservations, Member member, Criteria cri) {
		super(boardNo, content, bookStatus, price, deposit, writer, deleteYn, isbn13, regDate);
		this.bookInfo = bookInfo;
		this.bookInfos = bookInfos;
		this.bookReservations = bookReservations;
		this.member = member;
		this.cri = cri;
		
	}
}
