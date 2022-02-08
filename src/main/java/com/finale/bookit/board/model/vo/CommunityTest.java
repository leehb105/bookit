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
public class CommunityTest implements Serializable {
	
	private String title;
	
	private String content;
	
	private String category;
	
	private String memberId;
}
