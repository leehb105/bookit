package com.finale.bookit.inquire.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.inquire.model.service.InquireService;
import com.finale.bookit.inquire.model.vo.Inquire;
import com.finale.bookit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/inquire")
public class InquireController {

	@Autowired
	private InquireService inquireService;
	
	// 나의 문의 목록
	@GetMapping("/inquireList.do")
	public void inquireList(
			@RequestParam(defaultValue = "1") int cPage,
			@SessionAttribute(required = false) Member loginMember,
			HttpServletRequest request,
			Model model) {
		
		String id = loginMember.getId();
		// 페이지 당 게시글 갯수
		int limit = 5;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		param.put("id", id);
		
		List<Inquire> inquireList = inquireService.selectAllInquire(param);
		log.debug("inquireList = {}", inquireList);
		
		// 페이지 영역
		int totalContent = inquireService.selectTotalContent(loginMember);
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("inquireList", inquireList);
		model.addAttribute("pagebar", pagebar);
	}

	// 문의 등록 폼
	@GetMapping("/inquireForm.do")
	public void inquireForm() {}
	
	// 문의 등록
	@PostMapping("/inquireEnroll.do")
	public String inquireEnroll(Inquire inquire, RedirectAttributes redirectAttr) {
		
		int result = inquireService.insertInquire(inquire);
		redirectAttr.addFlashAttribute("msg", result > 0 ? "문의가 접수되었습니다." : "다시 시도하세요.");
		
		return "redirect:/inquire/inquireList.do";
	}
	
	// 문의 내용 상세보기
	@GetMapping("/inquireDetail.do")
	public void inquireDetail(@RequestParam int no, Model model) {
		// 나의 문의글
		Inquire inquire = inquireService.selectOneInquire(no);
		log.debug("inquire = {}", inquire);
		
		// 문의에 대한 관리자 답변(게시글 번호를 넘겨주어 조회)
		AdminInquire adminInquire = inquireService.selectOneAdminInquire(no);
		log.debug("adminInquire = {}", adminInquire);
		
		model.addAttribute("inquire", inquire);
		model.addAttribute("adminInquire", adminInquire);
	}
	
}














