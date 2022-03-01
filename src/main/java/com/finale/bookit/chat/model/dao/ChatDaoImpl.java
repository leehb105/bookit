package com.finale.bookit.chat.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.chat.model.vo.Chat;

@Repository
public class ChatDaoImpl implements ChatDao {
	
	
	@Autowired
	private SqlSessionTemplate session;
	
	
	@Override
	public int insertChatHistory(Chat msg) {
		// TODO Auto-generated method stub
		return session.insert("chat.insertChatHistory", msg);
	}


	@Override
	public List<Chat> selectChatAlarm(Chat param) {
		// TODO Auto-generated method stub
		return session.selectList("chat.selectChatAlarm", param);
	}
	
	


}
