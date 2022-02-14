package com.finale.bookit.board.model.service;



import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Comment;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.CommunityTest;


public interface CommunityService {
	
	Community getCommunity(int no);

	void deleteCommunityContent(int no, String string) throws Exception;

	List<Community> getCommunityList(Map<String, Object> param);

	int getTotalCommunityContent();

	void insertCommunity(CommunityTest communityTest);

	CommunityAttachment selectOneCommunityAttachment(int no);

	int updateReadCount(int no);
	
	int getCommunityNoCurrval();
	
	void insertComment(Comment comment) throws Exception;
	
	int deleteComment(int no) throws Exception;

	List<Comment> getCommentList(int no);
	
	void insertReComment(Comment comment);

	List<Community> searchCommuntiy(Map<String, Object> map);

	void updateCommunityContent(String memberId, Map<String, Object> param) throws Exception;

	void updateComment(Comment comment);

	void updateReComment(Comment comment);
	
}	


