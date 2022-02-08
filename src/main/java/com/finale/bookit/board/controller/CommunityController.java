package com.finale.bookit.board.controller;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.finale.bookit.board.model.service.CommunityService;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.CommunityTest;
import com.finale.bookit.common.util.BookitUtils;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class CommunityController {
	
	@Autowired
	private CommunityService communityService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@GetMapping(
			value="/urlResource.do",
			produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public Resource urlResource(HttpServletResponse response) {
		String location = "https://www.w3schools.com/tags/att_a_download.asp";
		Resource resource = resourceLoader.getResource(location);
		response.addHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=att_a_download.html");
		return resource;
	}
	@GetMapping(
			value = "/fileDownload.do", 
			produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public Resource fileDownload(@RequestParam int no, HttpServletResponse response) 
			throws UnsupportedEncodingException {
		CommunityAttachment attach = communityService.selectOneCommunityAttachment(no);
		log.debug("attach = {}", attach);
		
		// 다운로드받을 파일 경로
		String saveDirectory = application.getRealPath("/resources/upload/community");
		File downFile = new File(saveDirectory, attach.getRenamedFilename());
		String location = "file:" + downFile; // file객체의 toString은 절대경로로 오버라이드되어 있다.
		log.debug("location = {}", location);
		Resource resource = resourceLoader.getResource(location);
		
		// 헤더설정
		String filename = new String(attach.getOriginalFilename().getBytes("utf-8"), "iso-8859-1");
		response.addHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename);
		
		return resource;
	}
	
	
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
	
	@PostMapping("/communityEnroll.do")
	public ModelAndView communityEnroll(CommunityTest communityTest, Model model) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/board/community.do");
		log.info("communityTest : {}", communityTest);
		communityTest.setMemberId("admin");
        communityService.insertCommunity(communityTest);
        return mav;

	}
	
	@GetMapping("/communitySearch.do")
	public void communitySearch() {
		
	}
	
}

