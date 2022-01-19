package com.finale.bookit.chat.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;





@Controller
public class ChatController {

	@Autowired
	private SimpMessagingTemplate template;
	
	
	@GetMapping("chat/chatMain.do")
	public String chatMain(Model model) {
		
		return "forward:/WEB-INF/views/chat/chatMain.jsp";
	}
	

    @MessageMapping("/chat")
    @SendTo("/topic/a")
    public void broadcasting(String msg) {
    	
    	System.out.println("msg : " + msg);
    	HashMap<String,Object> payload = new HashMap<>();
    	payload.put("name", "chan");
    	template.convertAndSend("/topic/a", payload);

    }
	
}
