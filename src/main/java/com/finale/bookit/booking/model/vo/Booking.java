package com.finale.bookit.booking.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Booking {
    private int boardNo;
    private String content;
    private String bookStatus;
    private int price;
    private int deposit;
    private String writer;
    private String deleteYn;
    private String isbn13;
    
    private BookInfo bookInfo;

	public Booking(int boardNo, String content, String bookStatus, int price, int deposit, String writer,
			String deleteYn, String isbn13, BookInfo bookInfo) {
		super();
		this.boardNo = boardNo;
		this.content = content;
		this.bookStatus = bookStatus;
		this.price = price;
		this.deposit = deposit;
		this.writer = writer;
		this.deleteYn = deleteYn;
		this.isbn13 = isbn13;
		this.bookInfo = bookInfo;
	}
    
    

}