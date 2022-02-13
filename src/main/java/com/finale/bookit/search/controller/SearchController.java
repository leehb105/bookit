package com.finale.bookit.search.controller;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finale.bookit.booking.model.service.BookingService;
import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.booking.model.vo.Booking;
import com.finale.bookit.common.util.BookitUtils;
import com.finale.bookit.common.util.Criteria;
import com.finale.bookit.common.util.Paging;
import com.finale.bookit.search.model.service.SearchService;
import com.finale.bookit.search.model.service.SearchServiceImpl;
import com.finale.bookit.search.model.vo.BookReview;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SearchController {
	
	@Autowired
	private SearchService searchService;
	@Autowired
	private BookingService bookingService;

	@GetMapping("/booking/bookSearch.do")
//	@ResponseBody
	public void searchBookByTitle(
			@RequestParam String title, 
			Model model) {

		log.debug("title = {}" ,title);
		String bookInfo = searchService.searchBookByTitle(title);
		log.debug("bookInfo = {}", bookInfo);
		
        JSONObject json = new JSONObject(bookInfo);
        log.debug("json = {}", json);
        
        String query = json.getString("query");
        int totalResults = BookitUtils.getTotalResults(json.getInt("totalResults"));
        log.debug("totalResults = {}", totalResults);
        
        //도서 검색 결과 배열 파싱
        JSONArray items = json.getJSONArray("item");
//        log.debug("items = {}", items);
        List<BookInfo> list = new ArrayList<>();

        //전체 도서 list저장
        for(int i = 0; i < items.length(); i++) {
//        	log.debug("items = {}", items.get(i));
        	BookInfo book = new BookInfo();
        	book.setIsbn13(items.getJSONObject(i).getString("isbn13"));   
//        	log.debug("isbn = {}", book.getIsbn13());
        	book.setTitle(items.getJSONObject(i).getString("title"));
        	book.setAuthor(items.getJSONObject(i).getString("author"));
        	book.setPublisher(items.getJSONObject(i).getString("publisher"));
        	book.setPubdate(BookitUtils.getFormatDate(items.getJSONObject(i).getString("pubDate")));      	
        	book.setCategoryName(items.getJSONObject(i).getString("categoryName"));
        	
        	int itemPage = 0;
        	//isbn13이 존재하지 않을경우 isbn10으로 대체
        	if(book.getIsbn13().equals("")) {
        		book.setIsbn13(items.getJSONObject(i).getString("isbn"));
        		itemPage = searchService.searchBookPageByIsbn10(book.getIsbn13()); 
        	}else {
        		itemPage = searchService.searchBookPageByIsbn13(book.getIsbn13());        		
        	}
        	book.setItemPage(itemPage);
//        	book.setToc(items.getJSONObject(i).getString("toc"));
        	book.setCover(items.getJSONObject(i).getString("cover"));
        	book.setDescription(items.getJSONObject(i).getString("description"));

        	if(!book.getAuthor().equals("")) {
        		list.add(book);        		
        	}else {
        		totalResults--;
        	}
        	
        	log.debug("book = {}", book);
        	
        }
        
        model.addAttribute("list", list);
        model.addAttribute("totalResults", totalResults);
        model.addAttribute("query", query);


	}

	@GetMapping("/search/searchBook.do")
	public void searchBook(
			@RequestParam String title, 
			Model model) {

		log.debug("title = {}" ,title);
		String bookInfo = searchService.searchBookByTitle(title);
		log.debug("bookInfo = {}", bookInfo);
		
        JSONObject json = new JSONObject(bookInfo);
        log.debug("json = {}", json);
        
        String query = json.getString("query");
        int totalResults = BookitUtils.getTotalResults(json.getInt("totalResults"));
        log.debug("totalResults = {}", totalResults);
        
        //도서 검색 결과 배열 파싱
        JSONArray items = json.getJSONArray("item");
//        log.debug("items = {}", items);
        List<BookInfo> list = new ArrayList<>();

        //전체 도서 list저장
        for(int i = 0; i < items.length(); i++) {
//        	log.debug("items = {}", items.get(i));
        	BookInfo book = new BookInfo();
        	book.setIsbn13(items.getJSONObject(i).getString("isbn13"));   
//        	log.debug("isbn = {}", book.getIsbn13());
        	book.setTitle(items.getJSONObject(i).getString("title"));
        	book.setAuthor(items.getJSONObject(i).getString("author"));
        	book.setPublisher(items.getJSONObject(i).getString("publisher"));
        	book.setPubdate(BookitUtils.getFormatDate(items.getJSONObject(i).getString("pubDate")));      	
        	book.setCategoryName(items.getJSONObject(i).getString("categoryName"));
        	
        	int itemPage = 0;
        	//isbn13이 존재하지 않을경우 isbn10으로 대체
        	if(book.getIsbn13().equals("")) {
        		book.setIsbn13(items.getJSONObject(i).getString("isbn"));
        		itemPage = searchService.searchBookPageByIsbn10(book.getIsbn13()); 
        	}else {
        		itemPage = searchService.searchBookPageByIsbn13(book.getIsbn13());        		
        	}
        	book.setItemPage(itemPage);
//        	book.setToc(items.getJSONObject(i).getString("toc"));
        	book.setCover(items.getJSONObject(i).getString("cover"));
        	book.setDescription(items.getJSONObject(i).getString("description"));

        	if(!book.getAuthor().equals("")) {
        		list.add(book);        		
        	}else {
        		totalResults--;
        	}
        	
        	log.debug("book = {}", book);
        	
        }
        
        model.addAttribute("list", list);
        model.addAttribute("totalResults", totalResults);
        model.addAttribute("query", query);
	}
	
	@GetMapping("/search/bookDetail.do")
	public void bookDatail(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam String isbn, 
			Model model) {
		
		log.debug("isbn = {}" ,isbn);
		int amount = 5;
        Criteria cri = new Criteria();
        cri.setPageNum(pageNum);
        cri.setAmount(amount);
		
		String jsonBookInfo = searchService.searchBookByIsbn13(isbn); 
    		
		JSONObject json = new JSONObject(jsonBookInfo);
		log.debug("json = {}", json);
		
		//도서 검색 결과 배열 파싱
		JSONArray items = json.getJSONArray("item");
		log.debug("items = {}", items);
		
		BookInfo book = new BookInfo();
		book.setIsbn13(items.getJSONObject(0).getString("isbn13"));   
//    	log.debug("isbn = {}", book.getIsbn13());
		book.setTitle(items.getJSONObject(0).getString("title"));
		book.setAuthor(items.getJSONObject(0).getString("author"));
		book.setPublisher(items.getJSONObject(0).getString("publisher"));
		book.setPubdate(BookitUtils.getFormatDate(items.getJSONObject(0).getString("pubDate")));      	
		book.setCategoryName(items.getJSONObject(0).getString("categoryName"));
		
		//isbn13이 존재하지 않을경우 isbn10으로 대체
		if(book.getIsbn13().equals("")) {
			book.setIsbn13(items.getJSONObject(0).getString("isbn"));
		}
		int itemPage = json.getJSONArray("item").getJSONObject(0).getJSONObject("subInfo").getInt("itemPage");
		book.setItemPage(itemPage);
		book.setCover(items.getJSONObject(0).getString("cover"));
		book.setDescription(items.getJSONObject(0).getString("description"));
		
    	log.debug("book = {}", book);
    	
    	int count = bookingService.selectCountByIsbn(book.getIsbn13());
    	//등록되지 않은 책이라면
    	if(count == 0) {
    		int result = bookingService.insertBookInfo(book);
    		log.debug("result = {}", result);
    	}
    	HashMap<String, Object> param = new HashMap<String, Object>();
    	param.put("isbn", isbn);
    	param.put("cri", cri);
    	
     	List<BookReview> list = searchService.selectBookReviewByIsbn(param);
    	log.debug("list = {}", list);
    	
    	int total = searchService.selectTotalBookReviewCount(param);
		Paging page = new Paging(cri, total);
		log.debug("paging = {}", page);
         
        model.addAttribute("list", list);
        model.addAttribute("page", page);
		model.addAttribute("book", book);
		model.addAttribute("list", list);
	}
}

