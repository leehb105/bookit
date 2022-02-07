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

import com.finale.bookit.board.model.service.UsedService;
import com.finale.bookit.board.model.vo.Used;
import com.finale.bookit.common.util.BookitUtils;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class UsedController {
	
	@Autowired
	private UsedService usedService;

    @GetMapping("/usedContent.do")
    public void used(@RequestParam int no, Model model){
    	Used used = new Used();
        
		try {
			used = usedService.getUsed(no);
			log.info("used {}", used);
		}catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}	
		
		model.addAttribute("used", used);
		model.addAttribute("test", "test");
    }
	@GetMapping("/usedForm.do")
	public void usedForm() {}
    
	@PostMapping("/usedEnroll.do")
	public void usedEnroll() {
	}
	
	@GetMapping("/used.do")
	public void usedList(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request, 
			Model model) {
		// 1.content영역
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		
		List<Used> list = usedService.getUsedList(param);
		log.debug("list = {}", list);
		
		// 2.pagebar영역
		int totalUsedContent = usedService.getTotalUsedContent();
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalUsedContent, url);
		
		model.addAttribute("list", list);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping("/usedDelete.do")
	public void usedDelete(@RequestParam int no, Model model, HttpServletRequest request) {
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
			
			usedService.deleteUsedContent(no);
		
		}catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}	
	}
	
	@PostMapping("/usedUpdate.do")
	public void usedUpdate(@RequestBody Map<String, Object> param, Model model) {
		log.info("param : {}", param);
		try {
			usedService.updateUsedContent(param);
		}catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}	
	}
}
