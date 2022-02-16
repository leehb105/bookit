package com.finale.bookit.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper=true)
@NoArgsConstructor
@AllArgsConstructor
public class Posts implements Serializable {

		private static final long serialVersionUID = 1L;

		private int no;

		private String title;
		
		private Date regDate;
		
		private String category;
		
		private String deleteYn;
		
		private String memberId;
	
		private String tableName;
		
	}


	
