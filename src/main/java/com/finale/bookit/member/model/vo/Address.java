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
	private String jibunAddress;
	private String roadAddress;
	private String detailAddress;
	private String extraAddress;
	private String latitude;
	private String longitude;
	
}
