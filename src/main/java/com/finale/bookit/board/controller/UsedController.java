package com.finale.bookit.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.board.model.service.UsedService;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.CommunityTest;
import com.finale.bookit.board.model.vo.Used;
import com.finale.bookit.board.model.vo.UsedAttachment;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/used")
@Slf4j
public class UsedController {
	
	@Autowired
	private UsedService usedService;

	@Autowired
	private ServletContext application;

	@Autowired
	private ResourceLoader resourceLoader;
	
	@GetMapping(value = "/urlResource.do", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public Resource urlResource(HttpServletResponse response) {
		String location = "https://www.w3schools.com/tags/att_a_download.asp";
		Resource resource = resourceLoader.getResource(location);
		response.addHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=att_a_download.html");
		return resource;
	}

	@GetMapping(value = "/fileDownload.do", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public Resource fileDownload(@RequestParam int fileNo, HttpServletResponse response)
			throws UnsupportedEncodingException {

		try {
			UsedAttachment attach = usedService.selectOneUsedAttachment(fileNo);
			log.debug("attach = {}", attach);

			// 다운로드받을 파일 경로
			String saveDirectory = application.getRealPath("/resources/img/board");
			File downFile = new File(saveDirectory, attach.getRenamedFilename());
			String location = "file:" + downFile; // file객체의 toString은 절대경로로 오버라이드되어 있다.
			log.debug("location = {}", location);
			Resource resource = resourceLoader.getResource(location);

			// 헤더설정
			String filename = new String(attach.getOriginalFilename().getBytes("utf-8"), "iso-8859-1");
			response.addHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename);

			return resource;

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());

			return null;
		}

	}
	
	@GetMapping("/usedContent.do")
	public void used(@RequestParam int no, Model model, @AuthenticationPrincipal Member member) {
		Used used = new Used();

		try {
			used = usedService.getUsed(no, member.getId());
			usedService.updateReadCount(no);
			log.info("used {}", used);
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}

		model.addAttribute("used", used);
		model.addAttribute("test", "test");
	}

	@GetMapping("/usedForm.do")
	public void usedForm() {

	}

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
	
	// 게시글 삭제
	@GetMapping("/usedDelete.do")
	public String usedDelete(@RequestParam int no, Model model, HttpServletRequest request,
			@AuthenticationPrincipal Member member) {

		try {
			usedService.deleteUsedContent(no, member.getId());
			
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
		return "redirect:/used/used.do";
	}
	      
	
	// 게시글 수정
	@GetMapping("/usedUpdate.do")
	public void usedUpdate(@RequestParam int no, Model model, @AuthenticationPrincipal Member member) {

		Used used = usedService.getUsed(no, member.getId());

		model.addAttribute("used", used);

	};

	@PostMapping("/updateUsed.do")
	public String updateCommunity( HttpServletRequest request, Used used, Model model,
			@AuthenticationPrincipal Member loginMember,@RequestParam(name = "upFiles", required = false) MultipartFile[] upFiles
) {
		String saveDirectory = application.getRealPath("/resources/img/board");

		List<UsedAttachment> attachments = new ArrayList<>();

		log.info("upFiles {}", upFiles);
		if (upFiles.length > 0)
			log.info("===== file length {}", upFiles.length);
		
		try {
			
			for (int i = 0; i < upFiles.length; i++) {
				MultipartFile upFile = upFiles[i];
				if (!upFile.isEmpty()) {
					// 1. 저장경로 | renamedFilename
					String originalFilename = upFile.getOriginalFilename();
					String renamedFilename = BookitUtils.rename(originalFilename);
					File dest = new File(saveDirectory, renamedFilename);
					upFile.transferTo(dest);

					// 2
					UsedAttachment attach = new UsedAttachment();
					attach.setOriginalFilename(originalFilename);
					attach.setRenamedFilename(renamedFilename);
					attachments.add(attach);
				}
			}

			if (!attachments.isEmpty())
				used.setFiles(attachments);
			log.debug("communityDto = {}", used);

			usedService.updateUsedContent(loginMember.getId(), used);

			log.info("communityTest : {}", used);

			
		} catch (Exception e) {

			e.printStackTrace();
		}
		return "redirect:/used/used.do";

	}
	@PostMapping("/usedEnroll")
	public ModelAndView usedEnroll(Used usedDto, Model model,
			@RequestParam(name = "upFiles", required = false) MultipartFile[] upFiles, HttpServletRequest request,
			RedirectAttributes redirectAttr, @AuthenticationPrincipal Member loginMember)
			throws IllegalStateException, IOException {

		usedDto.setWriter(loginMember.getId());

		String saveDirectory = application.getRealPath("/resources/img/board");

		List<UsedAttachment> attachments = new ArrayList<>();

		log.info("upFiles {}", upFiles);

		if (upFiles.length > 0)
			log.info("===== file length {}", upFiles.length);

		for (int i = 0; i < upFiles.length; i++) {
			MultipartFile upFile = upFiles[i];
			if (!upFile.isEmpty()) {
				// 1. 저장경로 | renamedFilename
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = BookitUtils.rename(originalFilename);
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest);

				// 2
				UsedAttachment attach = new UsedAttachment();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				attachments.add(attach);
			}
		}

		if (!attachments.isEmpty())
			usedDto.setFiles(attachments);
		log.debug("usedDto = {}", usedDto);

		usedService.insertUsed(usedDto);

		ModelAndView mav = new ModelAndView("redirect:/used/used.do");
		log.info("usedTest : {}", usedDto);

		return mav;
	}
	
	@GetMapping("/search.do")
	public ModelAndView SearchUsed(@RequestParam(defaultValue = "1") int cPage, @RequestParam String keyword,
			@RequestParam String searchType, Model model, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/used.do");

		try {

			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("keyword", keyword);
			paramMap.put("searchType", searchType);

			log.info("paramMap {}", paramMap);

			List<Used> used = usedService.searchUsed(paramMap);

			log.info("search used {}", used);

			model.addAttribute(used);

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());

		}
		return mav;
	}
}
