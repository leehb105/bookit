package com.finale.bookit.board.model.service;

import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Used;

public interface UsedService {

	Used getUsed(int no);

	void updateUsedContent(Map<String, Object> param);
	
	List<Used> getUsedList(Map<String, Object> param);

	int getTotalUsedContent();

	void deleteUsedContent(int no, String id);

	
}
