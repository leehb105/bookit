package com.finale.bookit.payments.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.payments.model.dao.PaymentsDao;
import com.finale.bookit.payments.model.vo.KakaoPay;

@Service
public class KakaoPayServiceImpl implements PaymentsService {
	
	@Autowired
	private PaymentsDao paymentsDao;

	@Override
	public int insertCash(KakaoPay info) {
		return paymentsDao.insertCash(info);
	}

}
