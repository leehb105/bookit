package com.finale.bookit.booking.controller;

import com.finale.bookit.booking.model.service.BookingService;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.BookingEntity;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.common.util.Criteria;
import com.finale.bookit.common.util.Paging;
import com.finale.bookit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;
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
        
        log.debug("title = {}", bookTitle);
        List<BookingEntity> list = bookingService.selectBookingList(param);
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
    	
    	BookingEntity booking = bookingService.selectBooking(param);
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
    	
    	BookingEntity booking = new BookingEntity();
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
    	
    	List<BookingEntity> list = bookingService.selectMyBookingList(param);
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
    	
    	List<BookingEntity> list = bookingService.selectLentList(param);
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
    		Model model,
    		@AuthenticationPrincipal Member member
	) {
    	//내가 빌린 내역
    	log.debug("member = {}", member);
    	String id = member.getId();
    	List<BookingEntity> list = bookingService.selectBorrowedList(id);
    	log.debug("list = {}", list);
    	
    	
    	
    	
    }
    
    

    
    
}
