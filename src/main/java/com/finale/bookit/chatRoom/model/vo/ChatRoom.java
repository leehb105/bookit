package com.finale.bookit.chatRoom.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import org.springframework.web.socket.WebSocketSession;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatRoom implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	
	   private String roomId;
	   private String memberId;
	   private int read_count;
	   
	  // private Set<WebSocketSession> sessions = new HashSet<>();
	   //WebSocketSession은 Spring에서 Websocket Connection이 맺어진 세션
	    
	   public static ChatRoom create(String memberId){
	        ChatRoom room = new ChatRoom();

	        room.setRoomId(UUID.randomUUID().toString()); 		// UUID는 고유값을 생성하는 코드로 C20CEEBE-BF80... 등 으로 생성된다.
	        room.setMemberId(memberId);
	        return room;
	    } 
}
