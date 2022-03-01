package com.finale.bookit.payments.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.payments.model.vo.KakaoPay;

@Repository
public class KakaoPayDaoImpl implements PaymentsDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertCash(KakaoPay info) {
		return session.insert("kakaoPay.insertCash", info);
	}

	@Override
	public List<KakaoPay> selectHistoryList(String memberId) {
		return session.selectList("kakaoPay.selectHistoryList", memberId);
	}
	
}
