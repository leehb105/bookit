package com.finale.bookit.payments.model.dao;

import java.util.List;

import com.finale.bookit.payments.model.vo.KakaoPay;

public interface PaymentsDao {
	int insertCash(KakaoPay info);

	List<KakaoPay> selectHistoryList();
}
