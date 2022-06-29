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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.collection.model.service.CollectionService;
import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.collection.model.vo.BookCollectionList;
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
	public void collectionDetail(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request,
			@RequestParam int no, 
			Model model) {
		// 페이지 당 게시글 갯수
		int limit = 4;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		param.put("no", no);
		
		List<BookCollection> collectionDetailList = collectionService.selectCollectionDetail(param);
		log.debug("collectionDetailList = {}", collectionDetailList);
		
		// 비어있는 경우를 위한 리스트 (위의 리스트는 join 쿼리로 행이 무조건 한 개 존재함)
		List<BookCollectionList> bookList = collectionService.selectAllBookList(no);
		log.debug("bookList = {}", bookList);
		
		// 페이지 영역
		int totalContent = collectionService.selectTotalBookList(no);
		String url = request.getRequestURI() + "?no=" + no;
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("collectionDetailList", collectionDetailList);
		model.addAttribute("bookList", bookList);
		model.addAttribute("pagebar", pagebar);
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
	
	// 컬렉션 내에 책 추가
	@PostMapping("/insertBook.do")
	public String insertBook(
			@RequestParam int collectionNo,
			@RequestParam String isbn,
			RedirectAttributes redirectAttr) {
		log.debug("collectionNo = {}", collectionNo);
		log.debug("isbn = {}", isbn);
		
		Map<String, Object> param = new HashMap<>();
		param.put("collectionNo", collectionNo);
		param.put("isbn", isbn);
		int result = collectionService.insertBook(param);
		redirectAttr.addFlashAttribute("msg", result > 0 ? "추가되었습니다." : "다시 시도해주세요.");
		return "redirect:/collection/collectionDetail.do?no=" + collectionNo;
	}
}
