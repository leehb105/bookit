package com.finale.bookit.booking.controller;

import com.finale.bookit.booking.model.service.BookingService;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.common.util.BookitUtils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import lombok.extern.log4j.Log4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public void bookingEnroll() {
    	
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
