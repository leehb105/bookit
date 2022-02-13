package com.finale.bookit.wishlist.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Wishlist extends WishlistEntity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String content;
	private String writer;
	private Date regDate;

	public Wishlist(String memberId, int boardNo, String content, String writer, Date regDate) {
		super(memberId, boardNo);
		this.content = content;
		this.writer = writer;
		this.regDate = regDate;
	}
	
	
}
