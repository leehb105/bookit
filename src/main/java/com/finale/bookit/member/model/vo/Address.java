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
public class Address implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String memberId;
	private String postcode;
	private String roadAddress;
	private String extraAddress;
	private String depth1;
	private String depth2;
	private String depth3;
	private String bunji1;
	private String bunji2;
	private String mainAddress;
	private String subAddress;
	private String detailAddress;
	private float latitude;
	private float longitude;
	
}
