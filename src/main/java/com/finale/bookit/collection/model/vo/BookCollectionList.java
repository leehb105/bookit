package com.finale.bookit.collection.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookCollectionList implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int no;
	private int bookCollectionNo;
	private String isbn13;
	private Date regDate;
	
}
