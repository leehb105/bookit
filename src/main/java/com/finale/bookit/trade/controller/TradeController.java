package com.finale.bookit.trade.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.finale.bookit.trade.model.service.TradeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TradeController {
	
	@Autowired
	private TradeService tradeService;
	
	@GetMapping(value="/member/trade/history.do")
	public void history() {
		log.debug("history");
	}

}
