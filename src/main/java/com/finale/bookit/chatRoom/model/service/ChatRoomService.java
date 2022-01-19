package com.finale.bookit.chatRoom.model.service;

import java.util.List;

import com.finale.bookit.chatRoom.model.vo.ChatRoom;

public interface ChatRoomService {

	ChatRoom createChatRoom(String name);

	List<ChatRoom> findAllRooms();

	ChatRoom findRoomById(String id);

	
}
