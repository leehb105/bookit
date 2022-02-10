package com.finale.bookit.index.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.index.model.service.IndexService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class IndexController {

	@Autowired
	private IndexService indexService;
	
	@ResponseBody
	@PostMapping("/collectionList.do")
	public List<BookCollection> collectionList(Model model) throws Exception {
		List<BookCollection> collectionList = indexService.selectAllCollection();
		log.debug("collectionList = {}", collectionList);
		model.addAttribute("collectionList", collectionList);
		return collectionList;
	}
}
