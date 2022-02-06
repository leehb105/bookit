package com.finale.bookit.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommunityAttachment implements Serializable {

	private static final long serialVersionUID = 1L;

	private int no;
	private String originalFilename;
	private String renamedFilename;
	private Date regDate;
	private int communityNo;
	
}
