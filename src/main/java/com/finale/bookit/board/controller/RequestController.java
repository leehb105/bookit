package com.finale.bookit.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.board.model.service.RequestService;
import com.finale.bookit.board.model.vo.Request;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class RequestController {
	
	@Autowired
	private RequestService requestService;
	
	// 도서요청 리스트
    @GetMapping("/request.do")
    public void request(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request,
			Model model) {
		// 페이지 당 게시글 갯수
		int limit = 3;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		
		List<Request> requestList = requestService.selectAllRequest(param);
		log.debug("requestList = {}", requestList);
		
		// 페이지 영역
		int totalContent = requestService.selectTotalRequest();
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("requestList", requestList);
		model.addAttribute("pagebar", pagebar);
	}
    
    @GetMapping("/requestForm.do")
    public void requestForm(){
    }
    
    @PostMapping("/requestEnroll.do")
    public String requestEnroll(@RequestParam int wishPrice, @RequestParam String bookCondtion,
    		@RequestParam String isbn13, @AuthenticationPrincipal Member loginMember,
    		RedirectAttributes redirectAttr) {
    	log.debug("isbn13 = {}", isbn13);
    	log.debug("wishPrice = {}", wishPrice);
    	log.debug("bookCondtion = {}", bookCondtion);
    	String id = loginMember.getId();
    	Map<String, Object> param = new HashMap<>();
    	param.put("wishPrice", wishPrice);
    	param.put("bookCondtion", bookCondtion);
    	param.put("isbn13", isbn13);
    	param.put("id", id);
    	
    	int result = requestService.requestEnroll(param);
    	redirectAttr.addFlashAttribute("msg", result > 0 ? "요청글이 등록되었습니다." : "다시 시도해주세요.");
    	
    	return "redirect:/board/request.do";
    }
    
    @ResponseBody
    @PostMapping("/requestDelete.do")
    public String requestDelete(@RequestParam int requestNo) {
    	log.debug("requestNo = {}", requestNo);
    	int result = requestService.requestDelete(requestNo);
    	return "redirect:/board/request.do";
    }
}