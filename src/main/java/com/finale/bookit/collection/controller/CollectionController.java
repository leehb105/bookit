package com.finale.bookit.collection.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.finale.bookit.collection.model.service.CollectionService;
import com.finale.bookit.collection.model.vo.BookCollection;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/collection")
@Slf4j
public class CollectionController {

	@Autowired
	private CollectionService collectionService;
	
//	@GetMapping("/collectionList.do")
//	public void collectionList(Model model) {
//		List<BookCollection> collectionList = collectionService.selectAllCollection();
//		log.debug("collectionList = {}", collectionList);
//		model.addAttribute("collectionList", collectionList);
//	}

	//@RequestParam int no, 
	// no(번호)를 넘겨줘야함. boardList.jsp 참고해서 스크립트로 넘겨줘야 할 듯
//	@GetMapping("/collectionDetail.do")
//	public void boardDetail(Model model) {
//		BookCollection collection = collectionService.selectOneCollection(no);
//		log.debug("collection = {}", collection);
//		model.addAttribute("collection", collection);
//	}
}
