package com.finale.bookit.board.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class CommunityController {

	
	@GetMapping("/community.do")
	public void community() {
		
	}
	
	@GetMapping("/communityForm.do")
	public void communityForm() {
		
	}
	
	@GetMapping("/communityEnroll.do")
	public void communityEnroll() {
		
	}
}
