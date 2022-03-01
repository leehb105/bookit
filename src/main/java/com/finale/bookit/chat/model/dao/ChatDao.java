package com.finale.bookit.chat.model.dao;

import java.util.List;

import com.finale.bookit.chat.model.vo.Chat;

public interface ChatDao {

	int insertChatHistory(Chat msg);

	List<Chat> selectChatAlarm(Chat param);

}
