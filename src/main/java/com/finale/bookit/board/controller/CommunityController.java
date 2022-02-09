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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.board.model.service.CommunityService;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.CommunityTest;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.member.model.vo.Member;

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
	public Resource fileDownload(@RequestParam int no, HttpServletResponse response)
			throws UnsupportedEncodingException {

		try {
			CommunityAttachment attach = communityService.selectOneCommunityAttachment(no);
			log.debug("attach = {}", attach);

			// 다운로드받을 파일 경로
			String saveDirectory = application.getRealPath("/resources/upload/images");
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

	@GetMapping("/communityContent.do")
	public void community(@RequestParam int no, Model model) {
		Community community = new Community();

		try {
			community = communityService.getCommunity(no);
			log.info("community {}", community);
		} catch (Exception e) {
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
	public void communityList(@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request, Model model) {

		// 현재 로그인한 유저 정보 가져오기
		HttpSession session = request.getSession();

		String attrName = "loginMember";
		Member member = (Member) session.getAttribute(attrName);
		log.info("member {}", member);

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
		log.info("no : {}", no);

		// 현재 로그인한 유저 정보 가져오기
		HttpSession session = request.getSession();

		String attrName = "loginMember";
		Member member = (Member) session.getAttribute(attrName);
	

		try {
			communityService.deleteCommunityContent(no, member.getId());

		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}

	@PostMapping("/communityUpdate.do")
	public void communityUpdate(@RequestBody Map<String, Object> param, HttpServletRequest request, Model model) {

		// 현재 로그인한 유저 정보 가져오기
		HttpSession session = request.getSession();

		String attrName = "loginMember";
		Member member = (Member) session.getAttribute(attrName);
		
		
		
		try {
			communityService.updateCommunityContent(member.getId(), param);
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
	}

	@PostMapping("/communityEnroll.do")
	public ModelAndView communityEnroll(CommunityTest communityDto, Model model,
			@RequestParam(name = "upFile", required = false)MultipartFile[] upFile, HttpServletRequest request,
			RedirectAttributes redirectAttr) throws IllegalStateException, IOException {

		// 현재 로그인한 유저 정보 가져오기
		HttpSession session = request.getSession();

		String attrName = "loginMember";
		Member member = (Member) session.getAttribute(attrName);
		log.info("member {}", member);

		communityDto.setMemberId(member.getId());

		log.info("communityDto {}", communityDto);

		String saveDirectory = application.getRealPath("/resources/upload");

		List<CommunityAttachment> attachments = new ArrayList<>();

		log.info("upFiles {}", upFile);

		// 1. 첨부파일을 서버컴퓨터 저장 : rename
		// 2. 저장된 파일의 정보 -> Attachment객체 -> attachment insert
		for (int i = 0; i < upFile.length; i++) {
			MultipartFile upFiles = upFile[i];
			if (!upFiles.isEmpty()) {
				// 1. 저장경로 | renamedFilename
				String originalFilename = upFiles.getOriginalFilename();
				String renamedFilename = BookitUtils.rename(originalFilename);
				File dest = new File(saveDirectory, renamedFilename);
				upFiles.transferTo(dest);

				// 2
				CommunityAttachment attach = new CommunityAttachment();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				attachments.add(attach);
			}
		}

		if (!attachments.isEmpty())
			communityDto.setFiles(attachments);
		log.debug("communityDto = {}", communityDto);

		communityService.insertCommunity(communityDto);

		ModelAndView mav = new ModelAndView("redirect:/board/community.do");
		log.info("communityTest : {}", communityDto);

		return mav;

	}

	@GetMapping("/communitySearch.do")
	public void communitySearch() {

	}

}
