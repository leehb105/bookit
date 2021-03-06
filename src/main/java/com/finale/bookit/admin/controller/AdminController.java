package com.finale.bookit.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.admin.model.service.AdminService;
import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.inquire.model.vo.Inquire;
import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.report.model.vo.ReportBoard;
import com.finale.bookit.report.model.vo.ReportUser;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	
	
	
	@GetMapping("/selectChartDay")
	@ResponseBody
	public List<Chart> selectChartDay(@RequestParam String month,Model model) {
		

		List<Chart> chartDay = adminService.selectChartDay(month);
		
		log.debug("chartDay = {}",chartDay);
		
		return chartDay;
		
	}
	@GetMapping("/selectChartMonth")
	@ResponseBody
	public String selectChartMonth(@RequestParam String category,Model model) {
		String month = "month";
		log.debug("category = {}",category);
		if(category.equals(month)) {
			model.addAttribute("category", month);
		};
		
		return category;
		
	}
	
	@GetMapping("/admin.do")
	public void adminPage(@RequestParam(defaultValue = "1") int cPage,Model model,HttpServletRequest request) {
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		
		
		List<Member> memberList = adminService.selectAllMembers(param);
		log.debug("memberList= {}",memberList);
		
		model.addAttribute("memberList", memberList);
		
		
		
		
		int totalMember = adminService.getTotalMember();
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalMember, url);
		
		model.addAttribute("pagebar", pagebar);
		
	}
	
	
	
	@GetMapping("/chart/cashChart.do")
	public void cashChart(Model model) {
		List<Chart> chart = adminService.selectCashChart();
		int size = chart.size();
		int[] cash = new int[size];
		
		for(int i = 0 ; i < size; i++) {
			cash[i] = chart.get(i).getCount();
		}
		
		
		log.debug("CashChart = {}", chart);
		
		model.addAttribute("cash", cash);
		
	}
	@GetMapping("/chart/addressChart.do")
	public void addressChart() {
		
	}
	@GetMapping("/chart/chart.do")
	public void chart(Model model) {
		
		List<Chart> chart = adminService.selectChart();
		int[] arr = new int[chart.size()];
		for(int i = 0 ; i < chart.size(); i++) {
			arr[i] = chart.get(i).getCount();
		}
		
		model.addAttribute("arr", arr);
		model.addAttribute("size", chart.size());
		
		
	}
	
	// ?????? ??????
	@GetMapping("/adminInquireList.do")
	public void adminInquireList(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request,
			Model model) {
		
		// ????????? ??? ????????? ??????
		int limit = 5;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		
		List<Inquire> inquireList = adminService.selectAllInquire(param);
		log.debug("inquireList = {}", inquireList);
		
		// ????????? ??????
		int totalContent = adminService.selectTotalInquire();
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("inquireList", inquireList);
		model.addAttribute("pagebar", pagebar);
	}
	
	// ?????? ?????? ????????????
	@GetMapping("/adminInquireDetail.do")
	public void adminInquireDetail(@RequestParam int no, Model model) {
		// ????????? ?????????
		Inquire inquire = adminService.selectOneInquire(no);
		
		// ????????? ?????? ????????? ??????(????????? ????????? ???????????? ??????)
		AdminInquire adminInquire = adminService.selectOneAdminInquire(no);
		
		model.addAttribute("inquire", inquire);
		model.addAttribute("adminInquire", adminInquire);
	}

	// ????????? ?????? ??????
	@PostMapping("/inquireAdminReply.do")
	public String inquireAdminReply(RedirectAttributes redirectAttr, AdminInquire adminInquire) {
		int result = adminService.insertAdminReply(adminInquire);
		log.debug("result = {}", result);
		redirectAttr.addFlashAttribute("msg", result > 0 ? "????????? ?????????????????????." : "?????? ???????????????.");

		return "redirect:/admin/adminInquireDetail.do?no=" + adminInquire.getInquireNo();
	}
	
	// ????????? ?????? ?????? ??????(?????? = 1, ?????? = 2)
	@PostMapping("/reportUserUpdateCondition.do")
	public String reportUserUpdateCondition(@RequestParam int condition, @RequestParam int no, RedirectAttributes redirectAttr) {
		Map<String, Object> param = new HashMap<>();
		param.put("condition", condition);
		param.put("no", no);
		
		int result = adminService.updateReportUserCondition(param);
		log.debug("result = {}", result);
		if(condition > 1)
			redirectAttr.addFlashAttribute("msg", result > 0 ? "????????? ?????????????????????." : "?????? ???????????????.");
		else
			redirectAttr.addFlashAttribute("msg", result > 0 ? "????????? ?????????????????????." : "?????? ???????????????.");
		
		return "redirect:/admin/adminReportUserList.do";
	}
	
	// ????????? ?????? ?????? ??????(?????? = 1, ?????? = 2)
	@PostMapping("/reportBoardUpdateCondition.do")
	public String reportBoardUpdateCondition(@RequestParam int condition, @RequestParam int no, RedirectAttributes redirectAttr) {
		Map<String, Object> param = new HashMap<>();
		param.put("condition", condition);
		param.put("no", no);
		
		int result = adminService.updateReportBoardCondition(param);
		log.debug("result = {}", result);
		if(condition > 1)
			redirectAttr.addFlashAttribute("msg", result > 0 ? "????????? ?????????????????????." : "?????? ???????????????.");
		else
			redirectAttr.addFlashAttribute("msg", result > 0 ? "????????? ?????????????????????." : "?????? ???????????????.");
		
		return "redirect:/admin/adminReportBoardList.do";
	}
	
	// ????????? ?????? ??????
	@GetMapping("/adminReportUserList.do")
	public void reportList(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request,
			Model model) {
		
		// ????????? ??? ????????? ??????
		int limit = 5;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		
		// ????????? ?????? ??????
		List<ReportUser> reportUserList = adminService.selectAllReportUser(param);
		log.debug("reportUserList = {}", reportUserList);
		
		// ????????? ??????
		int totalContent = adminService.selectTotalReport();
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("reportUserList", reportUserList);
		model.addAttribute("pagebar", pagebar);
	}
	
	// ????????? ?????? ??????
	@GetMapping("/adminReportBoardList.do")
	public void reportBoardList(
			@RequestParam(defaultValue = "1") int cPage, 
			HttpServletRequest request,
			Model model) {
		
		// ????????? ??? ????????? ??????
		int limit = 5;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);

		List<ReportBoard> reportBoardList = adminService.selectAllReportBoard(param);
		log.debug("reportBoardList = {}", reportBoardList);
		// ????????? ??????
		int totalContent = adminService.selectTotalReportBoard();
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);

		model.addAttribute("reportBoardList", reportBoardList);
		model.addAttribute("pagebar", pagebar);
	}
	
	// ?????? ?????? (enabled = 0)
	@PostMapping("/enableUser.do")
	public String enableUser(@RequestParam String reportee, RedirectAttributes redirectAttr) {
		int result = adminService.enableUser(reportee);
		redirectAttr.addFlashAttribute("msg", result > 0 ? "????????? ????????? ?????????????????????." : "?????? ???????????????.");
		
		return "redirect:/admin/adminReportUserList.do";
	}
	
	// ????????? ?????? ?????? (delete_yn = 'Y')
	@PostMapping("/deleteYn.do")
	public String deleteYn(
			@RequestParam int boardNo,
			@RequestParam String boardName,
			RedirectAttributes redirectAttr) {
		log.debug("boardNo = {}", boardNo);
		log.debug("boardName = {}", boardName);
		
		Map<String, Object> param = new HashMap<>();
		param.put("boardNo", boardNo);
		param.put("boardName", boardName);
		int result = adminService.deleteYn(param);
		redirectAttr.addFlashAttribute("msg", result > 0 ? "???????????? ?????????????????????." : "?????? ???????????????.");
		
		return "redirect:/admin/adminReportBoardList.do";
	}
	
	
	
	
	
	@GetMapping("/updateAuthority")
	@ResponseBody
	public String updateAuthority(@RequestParam String userId,@RequestParam String authority) {
		String msg = "??????!";
		int result;
		if(authority.equals("ROLE_USER")) {
			int userAuthority = adminService.selectAuthority(userId);
			if(userAuthority == 0) {
				result = adminService.insertAuthority(userId);
				
			}
			else {
				result = adminService.deleteAuthority(userId);
			}
			
		}
		
		else {
			result = adminService.insertAuthority_ADMIN(userId);
			
		}
		
		return msg;
		
	}
	
	
	
	
	
}
