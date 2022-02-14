package com.finale.bookit.trade.model.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TradeDaoImpl implements TradeDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertTrade(HashMap<String, Object> param) {
		return session.insert("trade.insertOneTrade", param);
	}
	
}
