package com.finale.bookit.booking.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BookReservation implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int resNo;
	private int boardNo;
	private Date startDate;
	private Date endDate;
	private String borrowerId;
	private Date regDate;
	private String status;

}
