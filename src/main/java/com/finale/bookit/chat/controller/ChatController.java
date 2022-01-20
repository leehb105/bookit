package com.finale.bookit.chat.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.finale.bookit.chat.model.vo.Chat;
import com.finale.bookit.chatRoom.model.service.ChatRoomService;
import com.finale.bookit.chatRoom.model.vo.ChatRoom;





@Controller
public class ChatController {

	@Autowired
	private SimpMessagingTemplate template;


	
	@GetMapping("chat/chatMain.do")
	public String chatMain(Model model) {

		return "forward:/WEB-INF/views/chat/chatMain.jsp";
	}
	

    @MessageMapping("/chat")
    public void broadcasting(Chat msg) {
    	
    	System.out.println("msg : " + msg);

    	template.convertAndSend("/sub/room/"+ msg.getRoomId(), msg);

    }
	
}
