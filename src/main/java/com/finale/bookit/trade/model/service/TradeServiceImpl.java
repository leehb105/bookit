package com.finale.bookit.trade.model.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finale.bookit.trade.model.dao.TradeDao;
import com.finale.bookit.trade.model.vo.Trade;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TradeServiceImpl implements TradeService {

	@Autowired
	private TradeDao tradeDao;

	@Override
	public int insertTrade(HashMap<String, Object> param) {
		return tradeDao.insertTrade(param);
	}
}
