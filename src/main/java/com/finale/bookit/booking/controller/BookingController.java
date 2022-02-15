package com.finale.bookit.booking.controller;

import com.finale.bookit.booking.model.service.BookingService;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.common.util.Criteria;
import com.finale.bookit.common.util.Paging;
import com.finale.bookit.member.model.service.MemberService;
import com.finale.bookit.member.model.vo.Member;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.booking.model.service.BookingService;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.chat.model.service.ChatService;
import com.finale.bookit.chat.model.vo.Chat;
import com.finale.bookit.chatRoom.model.service.ChatRoomService;
import com.finale.bookit.chatRoom.model.vo.ChatRoom;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.common.util.Criteria;
import com.finale.bookit.common.util.Paging;
import com.finale.bookit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/booking")
public class BookingController {

    @Autowired
    private BookingService bookingService;
    
    @Autowired
    private MemberService memberService;

	@Autowired
    private ChatRoomService chatRoomService;

    @Autowired
    private ChatService chatService;
    
//    @GetMapping("/bookingList.do")
//    public void bookingList(){
//    	
//    }
    @GetMapping("/bookingList.do")
    public void bookingList(
    		@RequestParam(defaultValue = "1") int pageNum, 
    		@RequestParam(value = "bookTitle") String bookTitle, 
    		@RequestParam(value = "checkIn") String checkIn, 
    		@RequestParam(value = "checkOut") String checkOut, 
    		@AuthenticationPrincipal Member loginMember,
    		Model model, 
    		HttpServletRequest request ){
        int amount = 5;
        Criteria cri = new Criteria();
        cri.setPageNum(pageNum);
        cri.setAmount(amount);

        Map<String, Object> param = new HashMap<>();
        param.put("bookTitle", bookTitle);
        param.put("checkIn", checkIn);
        param.put("checkOut", checkOut);
        param.put("cri", cri);
        param.put("address", loginMember.getSearchAddress());
        
        log.debug("title = {}", bookTitle);
        List<Booking> list = bookingService.selectBookingList(param);
        int total = bookingService.selectTotalBookingCount(param);
        log.debug("total = {}", total);
        String url = request.getRequestURI();
        log.debug("url = {}", url);

        log.debug("list = {}", list);
        log.debug("url = {}", url);
        Paging page = new Paging(cri, total);
        log.debug("paging = {}", page);
        
        model.addAttribute("list", list);
        model.addAttribute("page", page);
    }

    @GetMapping("/bookingDetail.do")
    public void bookingDetail(@RequestParam(value = "bno") int bno, Model model,
    		@AuthenticationPrincipal Member loginMember) {
    	String id = loginMember.getId();
    	Map<String, Object> param = new HashMap<>();
    	param.put("bno", bno);
    	param.put("id", id);
    	
    	log.debug("bno = {}", bno);
    	
    	Booking booking = bookingService.selectBooking(param);
    	String newDate = BookitUtils.getFormatDate(booking.getRegDate());
    	log.debug("booking = {} ", booking);
    	
    	List<String> startDateList = new ArrayList<String>();
    	List<String> endDateList = new ArrayList<String>();
    	for(int i = 0; i < booking.getBookReservations().size(); i++) {
    		startDateList.add(BookitUtils.getFormatDateToString(booking.getBookReservations().get(i).getStartDate()));
    		endDateList.add(BookitUtils.getFormatDateToString(booking.getBookReservations().get(i).getEndDate()));
    	}
    	log.debug("startDateList = {}", startDateList);
    	int wishlistCount = bookingService.selectWishCount(param);
    	
    	model.addAttribute("booking", booking);
    	model.addAttribute("newDate", newDate);
    	model.addAttribute("startDateList", startDateList);
    	model.addAttribute("endDateList", endDateList);
    	model.addAttribute("wishlistCount", wishlistCount);
    }
    
    @GetMapping("/bookingEnroll.do")
    public void bookingEnroll() { }
    	
    @PostMapping("/bookingEnroll.do")
    public String bookingEnroll(
    		@RequestParam String status, 
    		@RequestParam int deposit, 
    		@RequestParam int price, 
    		@RequestParam String content, 
    		@RequestParam String isbn, 
    		RedirectAttributes attributes,
    		@AuthenticationPrincipal Member member) {

    	log.debug("member = {}", member);
    	
    	Booking booking = new Booking();
    	booking.setBookStatus(status);
    	booking.setDeposit(deposit);
    	booking.setPrice(price);
    	booking.setContent(content);
    	
    	BookInfo bookInfo = new BookInfo();
    	bookInfo.setIsbn13(isbn);

    	booking.setBookInfo(bookInfo);
    	booking.setWriter(member.getId());
    	
    	log.debug("booking = {} ", booking);
    	
    	int result = bookingService.insertBooking(booking);
    	String msg = "";
    	if(result > 0) {
    		msg = "대여 등록이 완료되었습니다.";
    		attributes.addFlashAttribute("msg", "대여 등록이 완료되었습니다.");    		
    	}else {
    		msg = "글 등록에 실패하였습니다.";
    	}
    	attributes.addFlashAttribute("msg", msg);  
    	
    	return "redirect:/";
    }
    
    @PostMapping("/bookInfoEnroll.do")
    @ResponseBody
    public String bookInfoEnroll(@RequestBody BookInfo bookInfo) {
    	
    	log.debug("bookInfo = {}", bookInfo);
    	
    	int count = bookingService.selectCountByIsbn(bookInfo.getIsbn13());
    	log.debug("count = {}", count);
    	
    	//등록되지 않은 책이라면
    	if(count == 0) {
    		int result = bookingService.insertBookInfo(bookInfo);
    		log.debug("result = {}", result);
    	}
    	
    	return "success";
//    	int result = bookingService.insertBooking();
    	
    }
    	
    @GetMapping("/myBooking.do")
    public void myBooking(
    		@RequestParam(defaultValue = "1") int pageNum, 
    		Model model,
    		@AuthenticationPrincipal Member member) {
    	
		int amount = 5;
		Criteria cri = new Criteria();
		cri.setPageNum(pageNum);
		cri.setAmount(amount);
		
		Map<String, Object> param = new HashMap<>();

        param.put("cri", cri);
        param.put("id", member.getId());
    	log.debug("member = {}", member);
    	
    	List<Booking> list = bookingService.selectMyBookingList(param);
    	log.debug("list = {}", list);
    	
    	int total = bookingService.selectTotalMyBookingCount(param);
    	Paging page = new Paging(cri, total);
    	
    	model.addAttribute("list", list);
    	model.addAttribute("page", page);
    	
    	
    }
    
    @GetMapping("/lentList.do")
    public void lentList(
    		@RequestParam(defaultValue = "1") int pageNum, 
    		Model model,
    		@AuthenticationPrincipal Member member
	) {
    	//내가 빌려준 도서 예약 목록
    	int amount = 5;
		Criteria cri = new Criteria();
		cri.setPageNum(pageNum);
		cri.setAmount(amount);
    	
    	log.debug("member = {}", member);
    	Map<String, Object> param = new HashMap<>();
    	param.put("id", member.getId());
    	param.put("cri", cri);
    	
    	List<Booking> list = bookingService.selectLentList(param);
    	log.debug("list = {}", list);

//    	log.debug("getBookInfos = {}", list.get(1).getBookInfos());
//    	log.debug("테스트데이터 = {}", list.get(1).getBookReservations().get(1));
    	
    	int total = bookingService.selectTotalMyLentBookingCount(param);
    	Paging page = new Paging(cri, total);
    	
    	model.addAttribute("list", list);
    	model.addAttribute("page", page);
    }
    
    
    @GetMapping("/borrowedList.do")
    public void borrowedList(
    		@RequestParam(defaultValue = "1") int pageNum, 
    		Model model,
    		@AuthenticationPrincipal Member member) {
    	//내가 빌린 내역
    	log.debug("member = {}", member);
    	
    	int amount = 5;
		Criteria cri = new Criteria();
		cri.setPageNum(pageNum);
		cri.setAmount(amount);
		

    	HashMap<String, Object> param = new HashMap<String, Object>();
    	param.put("id",  member.getId());
    	param.put("cri", cri);
    	
    	List<Booking> list = bookingService.selectBorrowedList(param);
    	log.debug("list = {}", list);
    	
    	int total = bookingService.selectTotalMyBorrowedBookingCount(param);
    	Paging page = new Paging(cri, total);
    	model.addAttribute("page", page);
    	
    	model.addAttribute("list", list);
        model.addAttribute("page", page);
    	
    	
    }
    
    @PostMapping("/bookingReservation.do")
    public String bookingReservation(
    		@RequestParam String checkIn,
    		@RequestParam String checkOut,
    		@RequestParam int pay,
    		@RequestParam int boardNo,
    		@RequestParam int deposit,
    		@RequestParam String title,
    		@RequestParam String bookingMemberId,
    		RedirectAttributes attributes,
    		@AuthenticationPrincipal Member member) {
    	
    	log.debug("checkIn = {}", checkIn);
    	log.debug("checkOut = {}", checkOut);
    	log.debug("pay = {}", pay);
    	log.debug("boardNo = {}", boardNo);
    	log.debug("lender = {}", bookingMemberId);
    	
    	
    	HashMap<String, Object> param = new HashMap<String, Object>();
    	param.put("checkIn", BookitUtils.getFormatDate(checkIn));
    	param.put("checkOut", BookitUtils.getFormatDate(checkOut));
    	param.put("pay", pay);
    	param.put("boardNo", boardNo);
    	param.put("deposit", deposit);
    	param.put("id", member.getId());
    	param.put("lenderId", bookingMemberId);
    	log.debug("param = {}", param);
    	
    	int result = bookingService.insertBookingReservation(param);
    	String msg = "";
    	String loginMemberId = member.getId();
    	String bookit = "bookit";
    	String chatMsg = "체크인 : "+ checkIn + "\n 체크아웃 : " + checkOut + "\n 도서 : " + title + "\n 대여 신청 완료";
    	String chatMsg2 = "체크인 : "+ checkIn + "\n 체크아웃 : " + checkOut + "\n 도서 : " + title + "\n 대여자 : " + member.getNickname() + "\n 대여 신청 완료";
    	
    	if(result > 0) {
    		
    		
            
            String chatParticipants = MakeStr(bookit,loginMemberId);
            
            String roomId = chatRoomService.selectChatRoomId(chatParticipants);
            
    		//기존에 채팅방이 존재하는지 체크
        	if(roomId != null) {
        		Chat chat = new Chat(roomId,bookit,chatMsg);
        		log.debug("chat = {}",chat);
    	        result = chatService.insertChatHistory(chat);
    	        		
    	    } 	
        	else {
	            result = chatRoomService.createChatRoom(chatParticipants);
	            
	            roomId = chatRoomService.selectChatRoomId(chatParticipants);
	            
        		Chat chat = new Chat(roomId,bookit,chatMsg);     		
        		log.debug("chat = {}",chat);
        		result = chatService.insertChatHistory(chat);
        	}
        	
        	
        	chatParticipants = MakeStr(bookit,bookingMemberId);
        	roomId = chatRoomService.selectChatRoomId(chatParticipants);
        	
        	if(roomId != null) {
        		Chat chat = new Chat(roomId,bookit,chatMsg2);
    	        result = chatService.insertChatHistory(chat);
    	        		
    	    } 	
        	else {
	            result = chatRoomService.createChatRoom(chatParticipants);
	            
	            roomId = chatRoomService.selectChatRoomId(chatParticipants);
	            
        		Chat chat = new Chat(roomId,bookit,chatMsg2);     		
        		log.debug("chat = {}",chat);
        		result = chatService.insertChatHistory(chat);
        	}

    		msg = "대여 신청이 완료되었습니다.";   		
    	}else {
    		msg = "대여 신청에 실패하였습니다.";
    		attributes.addFlashAttribute("msg", msg);
    		return "redirect:/booking/bookingDetail.do?bno=" + boardNo;
    	}
    	
    	attributes.addFlashAttribute("msg", msg); 
    	
    	member.setCash(member.getCash() - pay);
    	Authentication newAuthentication =  new UsernamePasswordAuthenticationToken(member, member.getPassword(), member.getAuthorities());
    	SecurityContextHolder.getContext().setAuthentication(newAuthentication);
    	
    	
    	return "redirect:/";
    }
    
    @PostMapping("/bookingDelete.do")
	public String bookingDelete(
			@RequestParam int boardNo, 
			RedirectAttributes attributes){
		log.debug("boardNo = {}", boardNo);
		
		HashMap<String, Object> param = new HashMap<String, Object>();
    	param.put("boardNo", boardNo);
    	
    	String msg = "";
    	int count = bookingService.selectCountBookingReservation(param);
    	//삭제할 수 없는 경우
    	if(count > 0) {
    		msg = "대여 예약이 있어 삭제가 불가능합니다."; 
    		return "redirect:/booking/bookingDetail.do?bno=" + boardNo;
    	}
    	
		int result = bookingService.deleteBooking(param);
    	if(result > 0) {
    		msg = "대여글 삭제가 완료되었습니다.";   		
    	}else {
    		msg = "대여글 삭제에 실패하였습니다.";
    		attributes.addFlashAttribute("msg", msg); 
    		return "redirect:/booking/bookingDetail.do?bno=" + boardNo;
    	}
    	attributes.addFlashAttribute("msg", msg); 
    	return "redirect:/booking/myBooking.do?pageNum=1&amout=5";
	}

    
    public String MakeStr(String str1,String str2) {
    	
    	StringBuilder sb = new StringBuilder();
        sb.append(str1);
        sb.append(",");
        sb.append(str2);
        
        String chatParticipants = sb.toString();
        
        return chatParticipants;
    }
}
