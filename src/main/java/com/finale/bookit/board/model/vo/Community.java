package com.finale.bookit.board.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.finale.bookit.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper=true)
@NoArgsConstructor
@AllArgsConstructor
public class Community implements Serializable {

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
	
	private String nickname;

	// private Member member;
	
	private List<Comment> comment;

	private List<CommunityAttachment> file;
	
	private int commentCount;
}

