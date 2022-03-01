package com.finale.bookit.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.Posts;
import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.common.util.Criteria;
import com.finale.bookit.common.util.Paging;
//import com.fasterxml.jackson.core.JsonParser;
import com.finale.bookit.member.model.service.MemberService;
import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.search.model.vo.BookReview;
import com.finale.bookit.wishlist.model.vo.Wishlist;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
@SessionAttributes({"loginMember", "next"})
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping("/memberLogin.do")
	public String memberLogin(
			@RequestHeader(name="Referer", required=false) String referer,
			@SessionAttribute(required=false) String next,
			Model model
	) {
		log.info("referer = {}", referer);
		
		if(next == null)
			model.addAttribute("next", referer);
		
		return "member/memberLogin";
		
	}
	
	@PostMapping("/memberLogin.do")
	public String memberLogin(
			@RequestParam String id,
			@RequestParam String password,
			@SessionAttribute(required=false) String next,
			Model model,
			RedirectAttributes redirectAttr
	) {
		
		MemberEntity member = memberService.selectOneMember(id);
		log.info("member = {}", member);
		log.info("encodedPassword = {}", bcryptPasswordEncoder.encode(password));

		String location = "/";
		if(member != null && bcryptPasswordEncoder.matches(password, member.getPassword())) {
			// 로그인 성공시
			model.addAttribute("loginMember", member);
			
			log.info("next = {}", next);
			location = next;
			redirectAttr.addFlashAttribute("msg", "로그인을 성공했습니다.");
		}
		else {
			// 로그인 실패시
			redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 틀렸습니다.");
		}
		
		return "redirect:" + location;
		
	}
	
	//카카오 로그인
	@RequestMapping(value = "/login/getKakaoAuthUrl")
	public @ResponseBody String getKakaoAuthUrl(
			HttpServletRequest request) throws Exception {
		String reqUrl = 
				"https://kauth.kakao.com/oauth/authorize"
				+ "?client_id=8a451c649411be3540e7cd703568efbf"
				+ "&redirect_uri=http://localhost:9090/bookit/member/kakao"
//				+ "&redirect_uri=" + request.getContextPath() + "/member/kakao"
				+ "&response_type=code";
		
		return reqUrl;
	}
	
	@RequestMapping(value="/kakao", method=RequestMethod.GET)
	public String kakao(@RequestParam(value = "code", required = false) String code) throws Exception {
		System.out.println("#########" + code);
		String access_Token = memberService.getAccessToken(code);
		MemberEntity userInfo = memberService.getUserInfo(access_Token);
		System.out.println("###access_Token#### : " + access_Token);

		session.invalidate();
		// 위 코드는 session객체에 담긴 정보를 초기화 하는 코드.
		session.setAttribute("kakaoN", userInfo.getName());
		session.setAttribute("kakaoE", userInfo.getId());
		session.setAttribute("kakaoCash", userInfo.getCash());
		// 위 2개의 코드는 닉네임과 이메일을 session객체에 담는 코드
	    
		
		return "redirect:/";
    	}
 
	
	
	
	@GetMapping("/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus, ModelMap model) {
		
		model.clear(); // 관리되는 model속성 완전 제거
		session.invalidate();
		
		// 현재 세션객체의 사용완료 설정 - 세션속성등 내부 초기화, 세션객체는 재사용
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();
		return "redirect:/";
	}
	
	@GetMapping("/memberEnroll.do")
	public String memberEnroll() {
		return "member/memberEnroll";
	}
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, Address address, RedirectAttributes redirectAttr) {
		log.info("member = {}", member);
		log.info("address = {}", address);
		// 비밀번호 암호화 처리
		String rawPassword = member.getPassword(); // 평문
		// 랜덤 salt값을 이용한 hashing처리:
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword); // 암호화처리
		member.setPassword(encodedPassword);
		
		// 업무로직
		address.setMemberId(member.getId());
		int result = memberService.insertMember(member, address);
		result = memberService.insertAuthority(member.getId());
		
		
		// 리다이렉트후에 session의 속성을 참조할 수 있도록한다.
		redirectAttr.addFlashAttribute("msg", result > 0 ? "회원 가입 성공!" : "회원 가입 실패!");
		
		return "redirect:/member/memberLogin.do";
	}
	
	@GetMapping("/mypageMain.do")
	public void memberProfile(@AuthenticationPrincipal Member member) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("id", member.getId());
		int result = memberService.selectMemberCash(param);
		member.setCash(result);
		int rating = memberService.selectMemberRating(param);
		member.setRating(rating);
		Authentication newAuthentication = new UsernamePasswordAuthenticationToken(member, member.getPassword(), member.getAuthorities());


		SecurityContextHolder.getContext().setAuthentication(newAuthentication);

	}
	
	@GetMapping("/editProfile.do")
	public void editProfile() {
		
	}
	
	@PostMapping("/memberUpdate.do")
	public String memberUpdate(
			@RequestParam String password,
			@RequestParam String newPassword,
			@RequestParam String nickname,
			@RequestParam String email,
			@RequestParam String phone,
			@RequestParam(name="profileImg", required=false) MultipartFile profileImg,
			@AuthenticationPrincipal Member loginMember,
			Address address,
			RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		log.debug("profileImg = {}", profileImg);
		
		String saveDirectory = application.getRealPath("/resources/img/profile");
		
		if(!profileImg.isEmpty()) {
			String originalFilename = profileImg.getOriginalFilename();
			String renamedFilename = BookitUtils.rename(originalFilename);
			File dest = new File(saveDirectory, renamedFilename);
			profileImg.transferTo(dest);
			
			loginMember.setProfileImage(renamedFilename);
		}
		
		String id = loginMember.getId();
		String profileImage = loginMember.getProfileImage();
		Map<String, Object> param = new HashMap<>();
		
		log.debug("loginMember = {}", loginMember);
		
		param.put("id", id);
		param.put("profileImage", profileImage);
		param.put("nickname", nickname);
		param.put("email", email);
		param.put("phone", phone);
		
		if(!newPassword.isEmpty()) {
			String encodedNewPassword = bcryptPasswordEncoder.encode(newPassword);			
			param.put("encodedNewPassword", encodedNewPassword);
		}
		
		address.setMemberId(id);
		log.debug("address = {}", address);
		
		// 현재 비밀번호 일치하는지 확인
		if(loginMember != null && bcryptPasswordEncoder.matches(password, loginMember.getPassword())) {
			int result = memberService.memberUpdate(param, address);
			redirectAttr.addFlashAttribute("msg", result > 0 ? "정보 수정 성공!" : "정보 수정 실패!");
		}
		else {
			redirectAttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
		}
		
		
		return "redirect:/member/mypageMain.do";
	}
	
	@ResponseBody
	@GetMapping("/checkDuplicateId.do")
	public int checkDuplicateId(@RequestParam String id) {
		log.debug("id = {}", id);
		int result = memberService.selectOneMemberCount(id);
		return result;
	}
	
	@ResponseBody
	@GetMapping("/checkDuplicateNickname.do")
	public int checkDuplicateNickname(@RequestParam String nickname) {
		log.debug("nickname = {}", nickname);
		int result = memberService.selectOneMemberNicknameCount(nickname);
		return result;
	}
	@ResponseBody
	@GetMapping("/checkDuplicateEmail.do")
	public int checkDuplicateEmail(@RequestParam String email) {
		log.debug("email = {}", email);
		int result = memberService.selectOneMemberEmailCount(email);
		return result;
	}
	@ResponseBody
	@GetMapping("/checkDuplicatePhone.do")
	public int checkDuplicatePhone(@RequestParam String phone) {
		log.debug("phone = {}", phone);
		int result = memberService.selectOneMemberPhoneCount(phone);
		return result;
	}
	
	
	@GetMapping("/bookReviewList.do")
	public void reviewList(
			@RequestParam(defaultValue = "1") int pageNum, 
			@AuthenticationPrincipal Member loginMember,
			Model model) {
		
		int amount = 5;
        Criteria cri = new Criteria();
        cri.setPageNum(pageNum);
        cri.setAmount(amount);
        
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("id", loginMember.getId());
		param.put("cri", cri);
		
		List<BookReview> list = memberService.selectBookReviewList(param);
		
		int total = memberService.selectTotalBookReviewCountById(param);
		
		log.debug("list = {}", list);
        Paging page = new Paging(cri, total);
        log.debug("paging = {}", page);
        
        model.addAttribute("list", list);
        model.addAttribute("page", page);
	}
	
	@PostMapping("/bookReviewDelete.do")
	public String reviewDelete(
			@RequestParam int reviewNo, 
			RedirectAttributes attributes) {
		log.debug("reviewNo = {}", reviewNo);
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("reviewNo", reviewNo);
		int result = memberService.bookReviewDelete(param);
		
		String msg = "";
    	if(result > 0) {
    		msg = "도서 리뷰가 삭제되었습니다.";   		
    	}else {
    		msg = "도서 리뷰삭제를 실패했습니다.";
    	}
    	attributes.addFlashAttribute("msg", msg); 
    	return "redirect:/member/reviewList.do?pageNum=1";
		
	}
	//나의 게시글 
	@GetMapping("/myPosts.do")
	public void myPosts(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request,
			Model model,
			@AuthenticationPrincipal Member loginMember) {
		String id = loginMember.getId();
		// 페이지 당 게시글 갯수
		int limit = 10;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		param.put("id", id);
		
		List<Posts> posts = memberService.selectMyPosts(id);
		
		log.debug("posts = {}", posts);
	
		
		// 페이지 영역
		int totalContent = memberService.selectMyPostsTotalCount(id);
		String url = request.getRequestURI();
		String pagebar = BookitUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("posts", posts);
		model.addAttribute("pagebar", pagebar);
	}
	
	// 게시글 삭제
	@PostMapping("/postDelete.do")
	public String wishlistDelete(HttpServletRequest request, Map<String, Object> paramMap) {
		int result;
	 // = request.getParameterValues("checkedArr");
		
		try {
			String tableName = request.getParameter("tableName").toString();
			int no = Integer.parseInt(request.getParameter("no").toString()); 
			
			log.info("isCom {}, no {}", tableName, no);
			
			//for(int i = 0; i < checkedArr.length; i++) {
				if(tableName.trim().equals("커뮤니티")) {
					memberService.deleteCommunityContent(no);
				}else {
					memberService.deleteUsedContent(no);
				}	
				result =1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
			
		//}
		return "redirect:/member/myPosts.do";
	}
	
	
	
}
