package com.finale.bookit.report.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportBoard implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String boardId;
	private int boardNo;
	private String reason;
	private String detail;
	private String reporter;
	private Date regDate;
	private int condition;
	private String boardName;
}
