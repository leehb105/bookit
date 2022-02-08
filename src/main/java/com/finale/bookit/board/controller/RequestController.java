package com.finale.bookit.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class RequestController {

    @GetMapping("/request.do")
    public void request(){
        
    }
    
    @GetMapping("/requestForm.do")
    public void requestForm(){
        
    }
}