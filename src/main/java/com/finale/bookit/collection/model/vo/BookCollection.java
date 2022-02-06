package com.finale.bookit.collection.model.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BookCollection extends BookCollectionEntity implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String nickname;
	private String listNo; // 삭제 시 배열타입을 위해 String으로 선언
	private String bookCollectionNo;
	private String isbn13;
	private String title;
	private String author;
	private String publisher;
	private String cover;
	
	public BookCollection(int no, String collectionName, String memberNickname, String listNo, String bookCollectionNo,
			String isbn13, String title, String author, String publisher, String cover) {
		super(no, collectionName, memberNickname);
		this.listNo = listNo;
		this.bookCollectionNo = bookCollectionNo;
		this.isbn13 = isbn13;
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.cover = cover;
	}
	
	
	
	
	
	

}
