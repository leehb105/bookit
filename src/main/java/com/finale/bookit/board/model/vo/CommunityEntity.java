package com.finale.bookit.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommunityEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int communityNo;
	private String title;
	private String content;
	private Date regDate;
	private int readCount;
	private int likeCount;
	private String category;
	private String reportYn;
	private String deleteYn;
	private String memberId;
}
