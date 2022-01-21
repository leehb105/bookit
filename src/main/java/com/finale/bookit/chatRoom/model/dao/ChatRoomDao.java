package com.finale.bookit.chatRoom.model.dao;

import java.util.List;

import com.finale.bookit.chatRoom.model.vo.ChatRoom;

public interface ChatRoomDao {

	ChatRoom createChatRoom(String name);

	List<ChatRoom> findAllRooms();

	ChatRoom findRoomById(String id);

}
