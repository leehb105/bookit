package com.finale.bookit.board.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RequestEntity implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private int wishPrice;
	private String bookCondition;
	private String memberId;
	private boolean deleteYn;
	private String isbn13;
}