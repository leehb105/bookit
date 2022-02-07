package com.finale.bookit.booking.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookInfo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String isbn13;
    private String title;
    private String author;
    private String publisher;
    private Date pubdate;
    private int itemPage;
    private String categoryName;
    private String cover;
    private String description;

}