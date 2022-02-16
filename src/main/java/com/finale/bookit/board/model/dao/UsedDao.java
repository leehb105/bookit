package com.finale.bookit.board.model.dao;

import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.Used;
import com.finale.bookit.board.model.vo.UsedAttachment;

public interface UsedDao {

	
	//게시판 
	Map<String, Object> selectUsedContent(int no);

	List<UsedAttachment> getUsedAttachmentList(int no);
	
	void deleteUsedContent(int no);
	
	void updateUsedContent(Used used);
	
	List<Used> getUsedList(Map<String, Object> param);
	
	int getTotalUsedContent();
	
	int insertUsed(Used used);
	
	
	//파일
	UsedAttachment selectOneUsedAttachment(int no);
	
	String writerCheck(int no);

	int insertUsedAttachment(UsedAttachment attach);
	
	int getUsedNoCurrval();
	
	int updateReadCount(int no);
	
	//검색
	List<Used> searchUsed(Map<String,Object> map);
	
	int getSearchUsedContentCount(Map<String, Object> param);

	
}
