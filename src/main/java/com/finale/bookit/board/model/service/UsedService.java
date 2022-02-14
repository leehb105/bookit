package com.finale.bookit.board.model.service;

import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Used;
import com.finale.bookit.board.model.vo.UsedAttachment;

public interface UsedService {

	Used getUsed(int no);

	void updateUsedContent(Map<String, Object> param);
	
	List<Used> getUsedList(Map<String, Object> param);

	int getTotalUsedContent();

	void deleteUsedContent(int no, String id);

	void insertUsed(Used used);
	
	UsedAttachment selectOneUsedAttachment(int no);
	
	int getSearchUsedContentCount(Map<String, Object> param);

	int getUsedNoCurrval();
	
	
}
