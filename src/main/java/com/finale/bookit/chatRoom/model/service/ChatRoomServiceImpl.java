package com.finale.bookit.chatRoom.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.chatRoom.model.dao.ChatRoomDao;
import com.finale.bookit.chatRoom.model.vo.ChatRoom;


import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class ChatRoomServiceImpl implements ChatRoomService {

	
	@Autowired
	private ChatRoomDao dao;
	
	@Override
	public int createChatRoom(String chatParticipants) {
		
		return dao.createChatRoom(chatParticipants);
	}

	@Override
	public List<ChatRoom> findAllRooms(String loginMember) {
		// TODO Auto-generated method stub
		return dao.findAllRooms(loginMember);
	}

	@Override
	public ChatRoom findRoomById(String id) {
		// TODO Auto-generated method stub
		return dao.findRoomById(id);
	}

}
