package com.finale.bookit.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class UsedController {

    @GetMapping("/used.do")
    public void board(){
        
    }
	@GetMapping("/usedForm.do")
	public void usedForm() {}
    
}
