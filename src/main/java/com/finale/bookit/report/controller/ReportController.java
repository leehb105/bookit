package com.finale.bookit.report.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.report.model.service.ReportService;
import com.finale.bookit.report.model.vo.ReportBoard;
import com.finale.bookit.report.model.vo.ReportUser;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/report")
@Slf4j
public class ReportController {

	@Autowired
	private ReportService reportService;
	
	// 나의 신고 목록
	@GetMapping("/reportList.do")
	public void reportList(
			@RequestParam(defaultValue = "1") int cPage,
			@SessionAttribute(required = false) MemberEntity loginMember,
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
		
		// 사용자 신고 목록
		List<ReportUser> reportUserList = reportService.selectAllReportUser(param);
		log.debug("reportUserList = {}", reportUserList);
		// 페이지 영역(사용자신고)
		int totalContent = reportService.selectTotalReportUser(loginMember);
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);
		
		// 게시글 신고 목록
		List<ReportBoard> reportBoardList = reportService.selectAllReportBoard(param);
		log.debug("reportBoardList = {}", reportBoardList);
		// 페이지 영역(사용자신고)
		int totalContent1 = reportService.selectTotalReportBoard(loginMember);
		String url1 = request.getRequestURI();
		String pagebar1 = BookitUtils.getPagebar(cPage, limit, totalContent1, url1);
		
		
		model.addAttribute("reportUserList", reportUserList);
		model.addAttribute("reportBoardList", reportBoardList);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("pagebar1", pagebar1);
	}
	
	// 신고 내용 상세보기 (연결 요청 없음. 삭제해도 무관.)
	@GetMapping("/reportDetail.do")
	public void reportDetail(@RequestParam int no, Model model) {
		ReportUser reportUser = reportService.selectOneReportUser(no);
		log.debug("reportUser = {}", reportUser);
		model.addAttribute("reportUser", reportUser);
	}
	

	
	
	
	
	
	
}


