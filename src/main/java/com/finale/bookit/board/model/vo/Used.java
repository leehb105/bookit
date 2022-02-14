package com.finale.bookit.board.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper=true)
@NoArgsConstructor
@AllArgsConstructor
public class Used implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private int usedBoardNo;
	
	private String title;
	
	private String bookState;
	
	private String tradeMethod;
	
	private String category;
	
	private String content;
	
	private String writer;
	
	private boolean deleteYn;
	
	private int price;
	
	private Date regDate;
	
	private int readCount;
	
	private String nickname;

	private List<UsedAttachment> file;
	
	private String profileImage;
}
