package com.finale.bookit.booking.controller;

import com.finale.bookit.booking.model.service.BookingService;
import com.finale.bookit.booking.model.vo.Booking;
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
    public void bookingList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request ){
        int limit = 10;
        int offset = (cPage - 1) * limit;

        Map<String, Object> param = new HashMap<>();
        param.put("offset", offset);
        param.put("limit", limit);

        List<Booking> list = bookingService.selectBookInfo(param);
//        String cover = list.get(0).getBookInfo().getCover();
//        log.debug("cover = {}", cover);
        int total = bookingService.selectTotalBookingCount();
        log.debug("total = {}", total);
        String url = request.getRequestURI();
//        String pagebar = HelloSpringUtils.getPagebar(cPage, limit, total, url);
        log.debug("list = {}", list);
        log.debug("url = {}", url);

        model.addAttribute("list", list);
//        model.addAttribute("pagebar", pagebar);
    }


}
