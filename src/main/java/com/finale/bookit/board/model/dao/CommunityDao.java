package com.finale.bookit.board.model.dao;

import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Comment;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.CommunityTest;

public interface CommunityDao {

	
	Map<String, Object> selectCommunityContent(int no);
	
	List<CommunityAttachment> getAttachmentList(int no);

	void deleteCommunityContent(int no);
	
	void updateCommunityContent(Map<String, Object> param);

	List<Community> getCommunityList(Map<String, Object> param);

	int getTotalCommunityContent();
	
	//comment 
	
	List<Comment> getCommentList(int no);
	
	List<Comment> getReCommentList(int refNo);
	
	void insertComment(Comment comment);
	
	void insertReComment(Comment comment);
	
	int updateComment(Comment comment);
	
	int deleteComment(int no);
	
	void isParent(Comment comment);
	

	int insertCommunity(CommunityTest communityTest);

	CommunityAttachment selectOneCommunityAttachment(int no);
	
	String writerCheck(int no);

	int insertCommunityAttachment(CommunityAttachment attach);
	
	//조회수
	int updateReadCount(int no);
	
	int getCommunityNoCurrval();
}
