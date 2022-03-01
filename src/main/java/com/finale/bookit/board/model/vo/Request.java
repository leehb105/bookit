package com.finale.bookit.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Request extends RequestEntity  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String nickname;
	private String cover;
	private String title;
	private String author;
	private String publisher;
	private Date pubdate;
	private String profileImage;
	
	public Request(int no, int wishPrice, String bookCondition, String memberId, boolean deleteYn, String isbn13,
			String nickname, String cover, String title, String author, String publisher, Date pubdate, String profileImage) {
		super(no, wishPrice, bookCondition, memberId, deleteYn, isbn13);
		this.nickname = nickname;
		this.cover = cover;
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.pubdate = pubdate;
		this.profileImage = profileImage;
	}

	

	
	
	
}
