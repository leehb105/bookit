package com.finale.bookit.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.finale.bookit.board.model.service.CommunityService;
import com.finale.bookit.board.model.vo.Comment;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.CommunityTest;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;

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
	public Resource fileDownload(@RequestParam int fileNo, HttpServletResponse response)
			throws UnsupportedEncodingException {

		try {
			CommunityAttachment attach = communityService.selectOneCommunityAttachment(fileNo);
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

	@GetMapping("/communityContent.do")
	public void community(@RequestParam int no, Model model, @AuthenticationPrincipal Member member) {
		Community community = new Community();

		try {
			community = communityService.getCommunity(no, member.getId());
			communityService.updateReadCount(no);
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
	public void communityList(@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(required = false) String keyword, @RequestParam(required = false) String searchType,
			HttpServletRequest request, Model model, @AuthenticationPrincipal Member member) {

		// 1.content영역
		int limit = 10;
		int offset = (cPage - 1) * limit;

		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		param.put("keyword", keyword);
		param.put("searchType", searchType);

		List<Community> list = communityService.getCommunityList(param);
		log.debug("list = {}", list);

		// 2.pagebar영역
		int totalCommunityContent = 0;

		if (searchType != null && keyword != null) {
			totalCommunityContent = communityService.getSearchCommuntiyContentCount(param);
		} else {
			totalCommunityContent = communityService.getTotalCommunityContent();
		}

		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalCommunityContent, url);

		model.addAttribute("list", list);
		model.addAttribute("pagebar", pagebar);
	}

	// 게시글 삭제
	@GetMapping("/communityDelete.do")
	public String communityDelete(@RequestParam int no, Model model, HttpServletRequest request,
			@AuthenticationPrincipal Member member) {

		try {
			communityService.deleteCommunityContent(no, member.getId());

		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
		return "redirect:/board/community.do";
	}

	// 게시글 수정
	@GetMapping("/communityUpdate.do")
	public void communityUpdate(@RequestParam int no, Model model, @AuthenticationPrincipal Member member) {

		Community community = communityService.getCommunity(no, member.getId());

		model.addAttribute("community", community);

	};

	@PostMapping("/updateCommunity.do")
	public String updateCommunity( HttpServletRequest request, CommunityTest communityDto, Model model,
			@AuthenticationPrincipal Member loginMember,@RequestParam(name = "upFiles", required = false) MultipartFile[] upFiles
) {
		String saveDirectory = application.getRealPath("/resources/img/board");

		List<CommunityAttachment> attachments = new ArrayList<>();

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
					CommunityAttachment attach = new CommunityAttachment();
					attach.setOriginalFilename(originalFilename);
					attach.setRenamedFilename(renamedFilename);
					attachments.add(attach);
				}
			}

			if (!attachments.isEmpty())
				communityDto.setFiles(attachments);
			log.debug("communityDto = {}", communityDto);

			communityService.updateCommunityContent(loginMember.getId(), communityDto);

			log.info("communityTest : {}", communityDto);

			
		} catch (Exception e) {

			e.printStackTrace();
		}
		return "redirect:/board/community.do";

	}

	@PostMapping("/communityEnroll")
	public ModelAndView communityEnroll(CommunityTest communityDto, Model model,
			@RequestParam(name = "upFiles", required = false) MultipartFile[] upFiles, HttpServletRequest request,
			RedirectAttributes redirectAttr, @AuthenticationPrincipal Member loginMember)
			throws IllegalStateException, IOException {

		communityDto.setMemberId(loginMember.getId());

		String saveDirectory = application.getRealPath("/resources/img/board");

		List<CommunityAttachment> attachments = new ArrayList<>();

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

	// 댓글처리

	@ResponseBody
	@GetMapping("/commentList.do")
	public List<Comment> getCommentList(@RequestParam int no, Model model) {
		List<Comment> comments = communityService.getCommentList(no);
		model.addAttribute("comment", comments);
		return comments;
	}

	@PostMapping("/insertComment.do")
	public Map<String, Object> insertComment(@RequestBody Map<String, Object> commentMap,
			@AuthenticationPrincipal Member member) {

		Map<String, Object> resultMap = new HashMap<>();
		boolean result = false;

		try {

			log.info("commnetMap{} ", commentMap);
			
			Comment comment = new Comment();

			comment.setCommunityNo(Integer.parseInt(commentMap.get("communityNo").toString()));
			comment.setCommentLevel(Integer.parseInt(commentMap.get("commentLevel").toString()));
			comment.setContent(commentMap.get("content").toString());
			
			String writer = member.getId();
			comment.setWriter(writer);

			if (comment.getCommentLevel() == 2) {
				comment.setCommentRef(Integer.parseInt(commentMap.get("commentRef").toString()));
				communityService.insertReComment(comment);
			} else {
				communityService.insertComment(comment);
			}

			result = true;

		} catch (Exception e) {
			e.printStackTrace();

		}

		resultMap.put("result", result);

		return resultMap;
	}

	@ResponseBody
	@PostMapping("/updateComment.do")
	public Map<String, Object> updateComment(@RequestBody Comment comment, Model model) {
		log.info("upate comment to ajax {}", comment);
		Map<String, Object> map = new HashMap<>();
		try {

			communityService.updateComment(comment);

			map.put("isSuccess", true);

			model.addAttribute("result", map);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}

	@ResponseBody
	@PostMapping("/deleteComment.do")
	public Map<String, Object> deleteComment(HttpServletRequest request, @RequestParam int no) {

		try {
			communityService.deleteComment(no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("isSuccess", true);
		return map;
	}

	@GetMapping("/search.do")
	public ModelAndView SearchCommunity(@RequestParam(defaultValue = "1") int cPage, @RequestParam String keyword,
			@RequestParam String searchType, Model model, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/community.do");

		try {

			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("keyword", keyword);
			paramMap.put("searchType", searchType);

			log.info("paramMap {}", paramMap);

			List<Community> community = communityService.searchCommuntiy(paramMap);

			log.info("search community {}", community);

			model.addAttribute(community);

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());

		}
		return mav;
	}
	
	@ResponseBody
	@GetMapping("/like.do")
	public Map<String, Object> CommunityLike(@RequestParam int no, @RequestParam boolean isLike, 
			@AuthenticationPrincipal Member member){
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", member.getId());
		paramMap.put("communityNo", no);
	
		
		log.info("isLike {} paramMap {}", isLike, paramMap);
		
		try{
			if(isLike) {
				communityService.likeCountUp(paramMap);
			} else {
				communityService.likeCountDown(paramMap);
			}

			resultMap.put("result", true);
			
		}catch(Exception e) {
			e.printStackTrace();
			resultMap.put("result", false);
		}
		
		return resultMap;
	}
	


}
