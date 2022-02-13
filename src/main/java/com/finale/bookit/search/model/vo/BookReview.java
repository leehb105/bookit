package com.finale.bookit.search.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.finale.bookit.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BookReview implements Serializable {

	private static final long serialVersionUID = 1L;

	private int reviewNo;
	private String isbn13;
	private String content;
	private int rating;
	private String writer;
	private Date regDate;
	private String deleteYn;
	
	private Member member;
}
