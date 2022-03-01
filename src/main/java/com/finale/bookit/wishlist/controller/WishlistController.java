package com.finale.bookit.wishlist.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.wishlist.model.service.WishlistService;
import com.finale.bookit.wishlist.model.vo.Wishlist;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/wishlist")
@SessionAttributes("loginMember")
public class WishlistController {

	@Autowired 
	private WishlistService wishlistService;
	
	// 찜 목록 리스트 + 나의 컬렉션
	@GetMapping("/wishlistList.do")
	public void wishlistList(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request,
			Model model,
			@AuthenticationPrincipal Member loginMember) {
		String id = loginMember.getId();
		// 페이지 당 게시글 갯수
		int limit = 5;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		param.put("id", id);
		
		List<Wishlist> wishlistList = wishlistService.selectAllWishlist(param);
		List<BookCollection> collectionList = wishlistService.selectAllCollection(param);
		log.debug("wishlistList = {}", wishlistList);
		log.debug("collectionList = {}", collectionList);
		
		// 페이지 영역
		int totalContent = wishlistService.selectTotalWishlist(loginMember);
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("wishlistList", wishlistList);
		model.addAttribute("collectionList", collectionList);
		model.addAttribute("pagebar", pagebar);
	}
	
	// 찜 목록 삭제
	@PostMapping("/wishlistDelete.do")
	public String wishlistDelete(HttpServletRequest request) {
		int result;
		String[] checkedArr = request.getParameterValues("checkedArr");
		for(int i = 0; i < checkedArr.length; i++) {
			result = wishlistService.wishlistDelete(checkedArr[i]);
		}
		return "redirect:/";
	}
	
	// 찜 등록
	@ResponseBody
	@PostMapping("/wishlistEnroll.do")
	public int wishlistEnroll(
			@RequestParam int boardNo, 
			@AuthenticationPrincipal Member loginMember) {
		String id = loginMember.getId();
		Map<String, Object> param = new HashMap<>();
		param.put("boardNo", boardNo);
		param.put("id", id);
		int result = wishlistService.wishlistEnroll(param);
		
		return result;
	}
	
	// 찜 취소
	@ResponseBody
	@PostMapping("/wishlistCancel.do")
	public int wishlistCancel(
			@RequestParam int boardNo,
			@AuthenticationPrincipal Member loginMember) {
		String id = loginMember.getId();
		Map<String, Object> param = new HashMap<>();
		param.put("boardNo", boardNo);
		param.put("id", id);
		int result = wishlistService.wishlistCancel(param);
				
		return result;
	}
	
	
//	아래는 컬렉션 관련==================================
	
	// 나의 컬렉션 생성
	@PostMapping("/collectionInsert.do")
	public String collectionInsert(
			@RequestParam String collectionName, 
			@AuthenticationPrincipal Member loginMember,
			RedirectAttributes redirectAttr) {
		String id = loginMember.getId();
		log.debug("id = {}", id);
		Map<String, Object> param = new HashMap<>();
		param.put("collectionName", collectionName);
		param.put("id", id);
		int result = wishlistService.collectionInsert(param);
		redirectAttr.addFlashAttribute("msg", result > 0 ? "컬렉션이 생성되었습니다." : "다시 시도해주세요.");
		
		return "redirect:/wishlist/wishlistList.do";
	}
	
	// 컬렉션 삭제(내부의 책 모음도 모두 삭제)
	@PostMapping("/collectionDelete.do")
	public String collectionDelete(HttpServletRequest request) {
		int result;
		String[] checkedArr = request.getParameterValues("checkedArr");
		for(int i = 0; i < checkedArr.length; i++) {
			result = wishlistService.collectionDelete(checkedArr[i]);
		}
		return "redirect:/";
	}
}
