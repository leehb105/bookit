package com.finale.bookit.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.admin.model.service.AdminService;
import com.finale.bookit.admin.model.vo.AdminInquire;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	
	
	@GetMapping("/admin.do")
	public void adminPage() {}
	
	@GetMapping("/chart.do")
	public void chart() {}
	// 관리자 답변 등록
	@PostMapping("/inquireAdminReply.do")
	public String inquireAdminReply(RedirectAttributes redirectAttr, AdminInquire adminInquire) {
		
		int result = adminService.insertAdminReply(adminInquire);
		log.debug("result = {}", result);
		
		redirectAttr.addFlashAttribute("msg", result > 0 ? "답변이 등록되었습니다." : "다시 시도하세요.");

		return "redirect:/inquire/inquireDetail.do?no=" + adminInquire.getInquireNo();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
