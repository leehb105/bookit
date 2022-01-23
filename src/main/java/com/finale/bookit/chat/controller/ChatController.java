package com.finale.bookit.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.finale.bookit.chat.model.service.ChatService;
import com.finale.bookit.chat.model.vo.Chat;

import lombok.extern.slf4j.Slf4j;





@Controller
@Slf4j
public class ChatController {

	@Autowired
	private SimpMessagingTemplate template;

	@Autowired
	private ChatService chatService;

	
	@GetMapping("chat/chatMain.do")
	public String chatMain(Model model) {

		return "forward:/WEB-INF/views/chat/chatMain.jsp";
	}
	

    @MessageMapping("/chat")
    public void broadcasting(Chat msg) {
    	
    	int result = chatService.insertChatHistory(msg);
    	
    	template.convertAndSend("/sub/room/"+ msg.getRoomId(), msg);

    }
	
}
