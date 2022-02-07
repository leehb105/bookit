package com.finale.bookit.board.model.dao;

import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.Used;
import com.finale.bookit.board.model.vo.UsedAttachment;

public interface UsedDao {

	Map<String, Object> selectUsedContent(int no);

	List<UsedAttachment> getUsedAttachmentList(int no);
	
	void deleteUsedContent(int no);
	
	void updateUsedContent(Map<String, Object> param);
	
	List<Used> getUsedList(Map<String, Object> param);
	
	int getTotalUsedContent();

}
