package com.finale.bookit.booking.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.finale.bookit.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Booking implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int boardNo;
    private String content;
    private String bookStatus;
    private int price;
    private int deposit;
    private String writer;
    private String deleteYn;
    private String isbn13;
    private Date regDate;
    
    private BookInfo bookInfo;
    private BookReservation bookReservation;
    private Member member;
    private Criteria cri;

}