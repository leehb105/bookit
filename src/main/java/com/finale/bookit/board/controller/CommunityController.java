package com.finale.bookit.board.controller;


import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.finale.bookit.board.model.service.CommunityService;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.common.util.BookitUtils;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class CommunityController {
	
	@Autowired
	private CommunityService communityService;
	
	@GetMapping("/communityContent.do")
	public void community(@RequestParam int no, Model model) {
		Community community = new Community();
		
		try {
			community = communityService.getCommunity(no);
			log.info("community {}", community);
		}catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}	
		
		model.addAttribute("community", community);
		model.addAttribute("test", "test");
	}
	
	@GetMapping("/communityForm.do")
	public void communityForm() {
		
	}
	
	@GetMapping("/community.do")
	public void communityList(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request, 
			Model model) {
		// 1.content영역
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		
		List<Community> list = communityService.getCommunityList(param);
		log.debug("list = {}", list);
		
		// 2.pagebar영역
		int totalCommunityContent = communityService.getTotalCommunityContent();
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalCommunityContent, url);
		
		model.addAttribute("list", list);
		model.addAttribute("pagebar", pagebar);
	}
	
	@PostMapping("/communityEnroll.do")
	public void communityEnroll() {
		
	}
	
	@GetMapping("/communityDelete.do")
	public void communityDelete(@RequestParam int no, Model model, HttpServletRequest request) {
		log.info("no : {}", no );
		
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
	      Enumeration<String> attrNames = session.getAttributeNames();                
	      
	      while(attrNames.hasMoreElements()){
	            String attrName = attrNames.nextElement();
	            Object attrValue = session.getAttribute(attrName);
	            System.out.println(attrName + " : " + attrValue);
	      }

	
		log.info("userId {} ", userId);
		
		try {
			
			communityService.deleteCommunityContent(no);
		
		}catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}	
	}
	
	@PostMapping("/communityUpdate.do")
	public void communityUpdate(@RequestBody Map<String, Object> param, Model model) {
		log.info("param : {}", param);
		try {
		communityService.updateCommunityContent(param);
		}catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}	
	}
}
