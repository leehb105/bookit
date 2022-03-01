package com.finale.bookit.payments.model.service;

import java.util.List;

import com.finale.bookit.payments.model.vo.KakaoPay;

public interface PaymentsService {
	
	int insertCash(KakaoPay info);

	List<KakaoPay> selectHistoryList(String memberId);

}
