package com.finale.bookit.board.model.service;

import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.CommunityTest;
import com.finale.bookit.board.model.vo.Used;
import com.finale.bookit.board.model.vo.UsedAttachment;

public interface UsedService {

	
	List<Used> getUsedList(Map<String, Object> param);

	int getTotalUsedContent();

	void deleteUsedContent(int no, String id) throws Exception;

	void insertUsed(Used used);
	
	UsedAttachment selectOneUsedAttachment(int no);
	
	int getSearchUsedContentCount(Map<String, Object> param);

	int getUsedNoCurrval();

	List<Used> searchUsed(Map<String, Object> paramMap);

	void updateUsedContent(String memberId, Used used) throws Exception;

	int updateReadCount(int no);
	
	Used getUsed(int no, String id);
	
	
}
