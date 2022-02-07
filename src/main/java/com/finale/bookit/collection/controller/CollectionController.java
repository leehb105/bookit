package com.finale.bookit.collection.controller;

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

import com.finale.bookit.collection.model.service.CollectionService;
import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.member.model.vo.MemberEntity;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/collection")
@Slf4j
public class CollectionController {

	@Autowired
	private CollectionService collectionService;
	
	// 회원별 컬렉션 모음 리스트
	@GetMapping("/collectionList.do")
	public void collectionList(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request,
			Model model) {
		// 페이지 당 게시글 갯수
		int limit = 6;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		
		List<BookCollection> collectionList = collectionService.selectAllCollection(param);
		log.debug("collectionList = {}", collectionList);
		
		// 페이지 영역
		int totalContent = collectionService.selectTotalCollection();
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("collectionList", collectionList);
		model.addAttribute("pagebar", pagebar);
	}

	// 해당 회원의 컬렉션 상세페이지
	@GetMapping("/collectionDetail.do")
	public void collectionDetail(@RequestParam int no, Model model) {
		List<BookCollection> collectionDetailList = collectionService.selectCollectionDetail(no);
		log.debug("collectionDetailList = {}", collectionDetailList);
		model.addAttribute("collectionDetailList", collectionDetailList);
	}
	
	// 컬렉션 모음집 내의 책 삭제
	@PostMapping("/collectionDetailDelete.do")
	public String collectionDetailDelete(HttpServletRequest request) {
		int result;
		String[] checkedArr = request.getParameterValues("checkedArr");
		for(int i = 0; i < checkedArr.length; i++) {
			result = collectionService.collectionDetailDelete(checkedArr[i]);
		}
		return "redirect:/";
	}
}
