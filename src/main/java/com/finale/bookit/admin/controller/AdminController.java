package com.finale.bookit.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.admin.model.service.AdminService;
import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;

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
	public void chart(Model model) {
		
		List<Chart> chart = adminService.selectChart();
		int[] arr = new int[chart.size()];
		for(int i = 0 ; i < chart.size(); i++) {
			arr[i] = chart.get(i).getCount();
		}
		
		model.addAttribute("arr", arr);
		model.addAttribute("size", chart.size());
		
		
	}
	// 관리자 답변 등록
	@PostMapping("/inquireAdminReply.do")
	public String inquireAdminReply(RedirectAttributes redirectAttr, AdminInquire adminInquire) {
		
		int result = adminService.insertAdminReply(adminInquire);
		log.debug("result = {}", result);
		
		redirectAttr.addFlashAttribute("msg", result > 0 ? "답변이 등록되었습니다." : "다시 시도하세요.");

		return "redirect:/inquire/inquireDetail.do?no=" + adminInquire.getInquireNo();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
