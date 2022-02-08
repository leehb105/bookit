package com.finale.bookit.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class RequestController {

    @GetMapping("/request.do")
    public void request(){
        
    }
    
    @GetMapping("/requestForm.do")
    public void requestForm(){
    }
    
    @PostMapping("/requestEnroll.do")
    public void requestEnroll() {
    	
    }
}