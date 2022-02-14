package com.finale.bookit.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.board.model.vo.Comment;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.CommunityTest;

@Repository
public class CommunityDaoImpl implements CommunityDao{

	@Autowired
	private SqlSessionTemplate session;
	
	
	@Override
	public Map<String, Object> selectCommunityContent(int no) {
		return session.selectOne("community.selectCommunityContent", no);
	}

	@Override
	public List<CommunityAttachment> getAttachmentList(int no) {
		return session.selectList("community.selectCommunityAttachment", no);
	}
	
	@Override
	public void deleteCommunityContent(int no) {
		session.update("community.deleteCommunityContent", no);
	}

	@Override
	public void updateCommunityContent(Map<String, Object> param) {
		session.update("community.updateCommunityContent", param);
	}

	@Override
	public List<Community> getCommunityList(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.getCommunityList", param, rowBounds);
	}

	@Override
	public int getTotalCommunityContent() {
		return session.selectOne("community.getTotalCommunityContent");
	}

	@Override
	public List<Comment> getCommentList(int no) {
		return session.selectList("community.selectCommunityComment", no);
	}

	@Override
	public List<Comment> getReCommentList(int refNo) {
		return session.selectList("community.selectCommunityReComment", refNo);
	}

	@Override
	public int insertCommunity(CommunityTest communityTest) {
		return session.insert("community.insertCommunity", communityTest);
	}

	@Override
	public CommunityAttachment selectOneCommunityAttachment(int no) {
		return session.selectOne("community.selectOneCommunityAttachment", no);
	}

	@Override
	public String writerCheck(int no) {
		
		return session.selectOne("community.writerCheck", no);
	}

	@Override
	public int insertCommunityAttachment(CommunityAttachment attach) {
		return session.insert("community.insertCommunityAttachment", attach);
	}

	@Override
	public int updateReadCount(int no) {
		return session.update("community.updateReadCount", no);
	}

	@Override
	public int getCommunityNoCurrval(){
		return session.selectOne("community.getCommunityNoCurrval");
	}

	@Override
	public void insertComment(Comment comment) {
		session.insert("community.insertComment", comment);
	}


	@Override
	public int deleteComment(int no) {
		return session.update("community.deleteCommunity", no);
	}

	@Override
	public void isParent(Comment comment) {
		session.update("community.setIsParent", comment);
	}

	@Override
	public void insertReComment(Comment comment) {
		session.insert("community.insertReComment", comment);
	}

	@Override
	public List<Community> searchCommuntiy(Map<String, Object> map) {
		
		return session.selectList("community.searchCommuntiy", map);
	}

	@Override
	public void updateComment(Comment comment) {
		session.update("community.updateComment", comment);
	}

	@Override
	public int getSearchCommuntiyContentCount(Map<String, Object> param) {
		return session.selectOne("community.selectSearchCommuntiyContentCount", param);
	}



		}

