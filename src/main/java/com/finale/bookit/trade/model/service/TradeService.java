package com.finale.bookit.trade.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.finale.bookit.trade.model.vo.Trade;

public interface TradeService {

	int insertTrade(HashMap<String, Object> param);

	List<Trade> selectBorrowList(Map<String, Object> param);

	List<Trade> selectLendList(Map<String, Object> param);
}
