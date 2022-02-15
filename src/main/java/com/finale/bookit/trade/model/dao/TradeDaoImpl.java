package com.finale.bookit.trade.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.trade.model.vo.Trade;

@Repository
public class TradeDaoImpl implements TradeDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertTrade(HashMap<String, Object> param) {
		return session.insert("trade.insertOneTrade", param);
	}


	@Override
	public List<Trade> selectBorrowList(Map<String, Object> param) {
		return session.selectList("trade.selectBorrowList", param);
	}

	@Override
	public List<Trade> selectLendList(Map<String, Object> param) {
		return session.selectList("trade.selectLendList", param);
	}
	
}
