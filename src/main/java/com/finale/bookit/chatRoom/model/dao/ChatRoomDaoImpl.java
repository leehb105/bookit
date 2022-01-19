package com.finale.bookit.chatRoom.model.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Repository;

import com.finale.bookit.chatRoom.model.vo.ChatRoom;

@Repository
public class ChatRoomDaoImpl implements ChatRoomDao {

	private Map<String, ChatRoom> chatRoomMap;
	
	
	@PostConstruct
	private void init() {
		chatRoomMap = new LinkedHashMap<>();
	}
	
	@Override
	public ChatRoom createChatRoom(String name) {
		ChatRoom room = ChatRoom.create(name);
		

		chatRoomMap.put(room.getRoomId(),room);
		
		return room;
	}

	@Override
	public List<ChatRoom> findAllRooms() {
		// TODO Auto-generated method stub
		List<ChatRoom> result = new ArrayList<>(chatRoomMap.values());
		Collections.reverse(result);
		return result;
	}

	@Override
	public ChatRoom findRoomById(String id) {
		// TODO Auto-generated method stub
		return chatRoomMap.get(id);
	}

}
