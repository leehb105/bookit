package com.finale.bookit.chatRoom.model.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.chat.model.vo.Chat;
import com.finale.bookit.chatRoom.model.vo.ChatRoom;

@Repository
public class ChatRoomDaoImpl implements ChatRoomDao {

	private Map<String, ChatRoom> chatRoomMap;

	@Autowired
	private SqlSessionTemplate session;
	
	@PostConstruct
	private void init() {
		chatRoomMap = new LinkedHashMap<>();
	}
	
	@Override
	public int createChatRoom(String chatParticipants) {
		ChatRoom room = ChatRoom.create(chatParticipants);
		
		return session.insert("chat.insertChatRoom",room);
	}

	@Override
	public List<ChatRoom> findAllRooms(String loginMember) {

		return session.selectList("chat.selectChatRoom", loginMember);
	}

	@Override
	public ChatRoom findRoomById(String id) {
		// TODO Auto-generated method stub
		return  session.selectOne("chat.selectOneChatRoom", id);
	}

	@Override
	public List<Chat> selectChatHistory(String id) {
		// TODO Auto-generated method stub
		return session.selectList("chat.selectChatHistory", id);
	}

	@Override
	public int updateRead_Check(String id) {
		// TODO Auto-generated method stub
		return session.update("chat.updateRead_Check", id);
	}
}
