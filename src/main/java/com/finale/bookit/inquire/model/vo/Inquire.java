package com.finale.bookit.inquire.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Inquire extends InquireEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int condition;

	public Inquire(int no, String title, String category, String content, Date regDate, String memberId,
			int condition) {
		super(no, title, category, content, regDate, memberId);
		this.condition = condition;
	}
	
}
