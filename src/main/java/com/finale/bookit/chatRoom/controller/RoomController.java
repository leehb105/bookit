package com.finale.bookit.chatRoom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.chat.model.vo.Chat;
import com.finale.bookit.chatRoom.model.service.ChatRoomService;
import com.finale.bookit.chatRoom.model.vo.ChatRoom;
import com.finale.bookit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = "/chatroom")
public class RoomController {

	@Autowired
	private ChatRoomService service;

	
	// 채팅방 목록 조회
	@GetMapping(value = "/list")
	public String rooms(@RequestParam String loginMember,Model model) {
        
        List<ChatRoom> result = service.findAllRooms(loginMember);
        
        for(ChatRoom room : result) {
        	String memberId = room.getMemberId();
        	
        	memberId = memberId.replace(loginMember, "");
        	memberId = memberId.replace(",","");
        	
        	room.setMemberId(memberId);
        	
        	log.debug("newId = {}",room.getMemberId());
        	
        	
        }
        log.debug("list = {}", result);
        model.addAttribute("list", result);
        
        return "forward:/WEB-INF/views/chat/chatMain.jsp";
	}
	
	@PostMapping(value = "/create")
    public String create(@RequestParam("writer") String writer,@AuthenticationPrincipal Member loginMember,RedirectAttributes rttr){

    	String memberId = service.selectIdByNickName(writer);
    	String loginMemberId = loginMember.getId();
    	
    	List<ChatRoom> list = service.findAllRooms(loginMemberId);
    	
    	if(list != null) {
	        for(ChatRoom room : list) {
	        	String sbId = room.getMemberId();
	        	
	        	sbId = sbId.replace(loginMemberId, "");
	        	sbId = sbId.replace(",","");
	        	
	        	// 이미 채팅방이 존재할떄
	        	if(sbId.equals(memberId)) {
	        		return "redirect:/chatroom/list?loginMember="+loginMemberId;
	        		}
	        }
    	}
    	
    	
        StringBuilder sb = new StringBuilder();
        sb.append(memberId);
        sb.append(",");
        sb.append(loginMemberId);
        
        String chatParticipants = sb.toString();
        log.debug("chatParticipants = {}",chatParticipants);
        
        int result = service.createChatRoom(chatParticipants);
        
        
        return "redirect:/chatroom/list?loginMember="+loginMemberId;
    }
    
    
    // 채팅방 조회
    @GetMapping("/detail")
    @ResponseBody
    public List<Chat> getRoom(@RequestParam String id,Model model) {
    	
    	log.debug("id = {}",id);
    	

    	List<Chat> ChatList = service.selectChatHistory(id);
    	ChatRoom room = service.findRoomById(id);
    	
    	
    	int result = service.updateRead_check(id);
    	
    	log.debug("ChatList = {}", ChatList);
    	
    	model.addAttribute("chatRoom", room);
    	model.addAttribute("ChatList", ChatList);
    	
    	
    	return ChatList;
    }
    
	
}
