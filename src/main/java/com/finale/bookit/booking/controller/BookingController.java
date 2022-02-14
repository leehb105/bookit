package com.finale.bookit.booking.controller;

import com.finale.bookit.booking.model.service.BookingService;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.common.util.Criteria;
import com.finale.bookit.common.util.Paging;
import com.finale.bookit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;

import lombok.extern.log4j.Log4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/booking")
public class BookingController {

    @Autowired
    private BookingService bookingService;

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
    		RedirectAttributes attributes,
    		@AuthenticationPrincipal Member member) {
    	
    	log.debug("checkIn = {}", checkIn);
    	log.debug("checkOut = {}", checkOut);
    	log.debug("pay = {}", pay);
    	log.debug("boardNo = {}", boardNo);
    	
    	HashMap<String, Object> param = new HashMap<String, Object>();
    	param.put("checkIn", BookitUtils.getFormatDate(checkIn));
    	param.put("checkOut", BookitUtils.getFormatDate(checkOut));
    	param.put("pay", -1 * pay);
    	param.put("boardNo", boardNo);
    	param.put("id", member.getId());
    	log.debug("param = {}", param);
    	
    	int result = bookingService.insertBookingReservation(param);
    	String msg = "";
    	if(result > 0) {
    		msg = "대여 신청이 완료되었습니다.";   		
    	}else {
    		msg = "대여 신청에 실패하였습니다.";
    		attributes.addFlashAttribute("msg", msg); 
    		return "redirect:/booking/bookingDetail.do?bno=" + boardNo;
    	}
    	
    	//사용자 잔액 차감 및 거래내역 추가 부분 이 밑으로 구현하세요 
    	
    	//잔액 차감 메소드만들어놓은거 필요하면 수정해서 쓰세요
//    	result = bookingService.updateUserCash(param);
//    	if(result > 0) {
//    		
//    	}else {
//    		msg = "대여 신청에 실패하였습니다.";
//    		attributes.addFlashAttribute("msg", msg); 
//    		return "redirect:/booking/bookingDetail.do?bno=" + boardNo;
//    	}
    	
    	
    	
    	attributes.addFlashAttribute("msg", msg); 
    	
    	
    	return "redirect:/";
    }
    
    

    
    
}
