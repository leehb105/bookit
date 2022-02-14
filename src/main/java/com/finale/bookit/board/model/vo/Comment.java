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
public class Comment implements Serializable{

	private int no;
	private String content;
	private int commentRef;
	private Date regDate;
	private String writer;
	private String DeleteYn;
	private int commentLevel;
	private String nickname;
	private String isParent;
	private int commentCount;
	private int communityNo;
	private List<Comment> reComments;
	private String profileImage;

}
