package com.finale.bookit.report.controller;

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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.member.model.vo.Member;
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

	// 나의 사용자 신고 목록
	@GetMapping("/reportUserList.do")
	public void reportUserList(
			@RequestParam(defaultValue = "1") int cPage,
			@AuthenticationPrincipal Member loginMember,
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

		List<ReportUser> reportUserList = reportService.selectAllReportUser(param);
		log.debug("reportUserList = {}", reportUserList);
		// 페이지 영역
		int totalContent = reportService.selectTotalReportUser(loginMember);
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);

		model.addAttribute("reportUserList", reportUserList);
		model.addAttribute("pagebar", pagebar);
	}

	// 나의 게시글 신고 목록
	@GetMapping("/reportBoardList.do")
	public void reportBoardList(
			@RequestParam(defaultValue = "1") int cPage, 
			@AuthenticationPrincipal Member loginMember,
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

		List<ReportBoard> reportBoardList = reportService.selectAllReportBoard(param);
		log.debug("reportBoardList = {}", reportBoardList);
		// 페이지 영역
		int totalContent = reportService.selectTotalReportBoard(loginMember);
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);

		model.addAttribute("reportBoardList", reportBoardList);
		model.addAttribute("pagebar", pagebar);
	}

	// 신고 내용 상세보기 (연결 요청 없음. 삭제해도 무관.)
	@GetMapping("/reportDetail.do")
	public void reportDetail(@RequestParam int no, Model model) {
		ReportUser reportUser = reportService.selectOneReportUser(no);
		log.debug("reportUser = {}", reportUser);
		model.addAttribute("reportUser", reportUser);
	}

	// 게시글 신고 등록
	@PostMapping("/reportBoardEnroll.do")
	public String reportBoardEnroll(@RequestParam String reporter, @RequestParam String boardName,
			@RequestParam String boardNo, @RequestParam String reason, 
			@RequestParam String detail, RedirectAttributes redirectAttr) {
		Map<String, Object> param = new HashMap<>();
		param.put("reporter", reporter);
		param.put("boardName", boardName);
		param.put("boardNo", boardNo);
		param.put("reason", reason);
		param.put("detail", detail);
		int result = reportService.insertReportBoard(param);
		redirectAttr.addFlashAttribute("msg", result > 0 ? "신고가 접수되었습니다." : "다시 시도하세요.");
		
		return "redirect:/board/communityContent.do?no=" + boardNo;
	}
}
