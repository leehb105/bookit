package com.finale.bookit.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.board.model.vo.Used;
import com.finale.bookit.board.model.vo.UsedAttachment;

@Repository
public class UsedDaoImpl implements UsedDao{

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public Map<String, Object> selectUsedContent(int no) {
		return session.selectOne("used.selectUsedContent", no);
	}
	
	@Override
	public List<UsedAttachment> getUsedAttachmentList(int no) {
		return session.selectList("used.selectUsedAttachment", no);
	}
	
	@Override
	public void deleteUsedContent(int no) {
		session.update("used.deleteUsedContent", no);
	}
	
	@Override
	public void updateUsedContent(Used used) {
		session.update("used.updateUsedContent", used);
	}

	@Override
	public List<Used> getUsedList(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("used.getUsedList", null, rowBounds);
	}

	@Override
	public int getTotalUsedContent() {
		return session.selectOne("used.getTotalUsedContent");
	}

	@Override
	public int insertUsed(Used used) {
		return session.insert("used.insertUsed", used);
	}

	@Override
	public UsedAttachment selectOneUsedAttachment(int no) {
		return session.selectOne("used.selectOneUsedAttachment", no);
	}

	@Override
	public String writerCheck(int no) {
		return session.selectOne("used.writerCheck", no);
	}

	@Override
	public int insertUsedAttachment(UsedAttachment attach) {
		return session.insert("used.insertUsedAttachment", attach);
	}

	@Override
	public int getUsedNoCurrval() {
		return session.selectOne("used.getUsedNoCurrval");
	}

	@Override
	public List<Used> searchUsed(Map<String, Object> map) {
		return session.selectList("used.searchUsed", map);
	}

	@Override
	public int getSearchUsedContentCount(Map<String, Object> param) {
		return session.selectOne("used.getSearchUsedContentCount", param);
	}

	@Override
	public int updateReadCount(int no) {
		return session.update("used.updateReadCount", no);
	}


}
