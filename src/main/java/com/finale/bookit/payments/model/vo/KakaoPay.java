package com.finale.bookit.payments.model.vo;

import java.io.Serializable;

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
public class KakaoPay implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String impUid;		// 결제번호
	private String merchantUid; // 주문번호
	private String pgTid;		// 카드사 승인번호
	private int chargeCash; 	// amount
	private int bonusCash;
	private String chargeDate; 	// paidAt
	private String memberId;	// IMP의 응답필드가 따로 없어서 custom_data로 받아옴
	
}