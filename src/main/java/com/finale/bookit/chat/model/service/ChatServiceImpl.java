package com.finale.bookit.chat.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.chat.model.dao.ChatDao;
import com.finale.bookit.chat.model.vo.Chat;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao dao;
	
	@Override
	public int insertChatHistory(Chat msg) {
		// TODO Auto-generated method stub
		return dao.insertChatHistory(msg);
	}

}
