package com.finale.bookit.trade.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.trade.model.service.TradeService;
import com.finale.bookit.trade.model.vo.Trade;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TradeController {
	
	@Autowired
	private TradeService tradeService;
	
	@GetMapping(value="/member/trade/history.do")
	public void history(@AuthenticationPrincipal Member member, Model model) {
		log.debug("member = {}", member);
		Map<String, Object> param = new HashMap<>();
		param.put("id", member.getId());
		List<Trade> borrowList = tradeService.selectBorrowList(param);
		
		List<Trade> lendList = tradeService.selectLendList(param);
		
		model.addAttribute("borrowList", borrowList);
		model.addAttribute("lendList", lendList);
	}

}
