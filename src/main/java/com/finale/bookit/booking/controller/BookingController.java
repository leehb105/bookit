package com.finale.bookit.booking.controller;

import com.finale.bookit.booking.model.service.BookingService;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.common.util.BookitUtils;
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
    		@RequestParam(defaultValue = "1") int cPage, 
    		@RequestParam(value = "bookTitle") String bookTitle, 
    		@RequestParam(value = "checkIn") String checkIn, 
    		@RequestParam(value = "checkOut") String checkOut, 
    		Model model, 
    		HttpServletRequest request ){
        int limit = 10;
        int offset = (cPage - 1) * limit;

        Map<String, Object> param = new HashMap<>();
        param.put("offset", offset);
        param.put("limit", limit);
        param.put("bookTitle", bookTitle);
        param.put("checkIn", checkIn);
        param.put("checkOut", checkOut);
        log.debug("title = {}", bookTitle);
        List<Booking> list = bookingService.selectBookInfo(param);
//        String cover = list.get(0).getBookInfo().getCover();
//        log.debug("cover = {}", cover);
        int total = bookingService.selectTotalBookingCount();
        log.debug("total = {}", total);
        String url = request.getRequestURI();
        String pagebar = BookitUtils.getPagebar(cPage, limit, total, url);
        log.debug("list = {}", list);
        log.debug("url = {}", url);

        model.addAttribute("list", list);
        model.addAttribute("pagebar", pagebar);
    }

    @GetMapping("/bookingDetail.do")
    public void bookingDetail(@RequestParam(value = "bno") int bno, Model model) {
    	Map<String, Object> param = new HashMap<>();
    	param.put("bno", bno);
    	
    	log.debug("bno = {}", bno);
    	
    	Booking booking = bookingService.selectBooking(param);
    	String newDate = BookitUtils.getFormatDate(booking.getRegDate());
    	log.debug("booking = {} ", booking);
    	
    	model.addAttribute("booking", booking);
    	model.addAttribute("newDate", newDate);
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
    		@AuthenticationPrincipal Member member
	) {

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
    
    
    
    
//    @GetMapping("/bookSearch.do")
//    public void bookSearch(@RequestParam String bookTitle, Model model) {
//    	log.debug("bookTitle = {}", bookTitle);
//    	Map<String, Object> param = new HashMap<>();
//    	param.put("bookTitle", bookTitle);
//    	
//    	List<BookInfo> list = bookingService.selectBook(param);
//    	log.debug("bookInfo = {}", list);
//    	
//    	model.addAttribute("list", list);
//    }
    
    
}
