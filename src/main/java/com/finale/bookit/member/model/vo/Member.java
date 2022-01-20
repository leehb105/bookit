package com.finale.bookit.member.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Member implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String password;
	private String email;
	private String nickname;
	private String name;
	private String phone;
	private boolean enabled;
	private Date enrollDate;
	private String reportYn;
	private int cash;
	
}
