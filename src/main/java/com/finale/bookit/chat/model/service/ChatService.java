package com.finale.bookit.chat.model.service;

import java.util.List;

import com.finale.bookit.chat.model.vo.Chat;

public interface ChatService {

	int insertChatHistory(Chat msg);

	List<Chat> selectChatAlarm(String id);

}
