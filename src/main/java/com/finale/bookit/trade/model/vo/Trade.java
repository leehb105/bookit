package com.finale.bookit.trade.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Trade implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int rentNo;
	private int resNo;
	private int price; // 대여비
	private int cash; // 잔액
	private Date tradeDate;
}
