package com.finale.bookit.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.Message;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;





@Controller
public class ChatController {

	@Autowired
	private SimpMessagingTemplate template;
	
	
	@GetMapping("chat/chatMain.do")
	public String chatMain() {
		
		return "forward:/WEB-INF/views/chat/chatMain.jsp";
	}
	

    @MessageMapping("/chat")
    @SendTo("/topic/a")
    public Message broadcasting(@Payload Message msg) {
    	
    	System.out.println("메세지성공");
    	template.convertAndSend("/topic/a", msg);
    	return msg;
    }
	
}
