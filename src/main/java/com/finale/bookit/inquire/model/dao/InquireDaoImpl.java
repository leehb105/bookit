package com.finale.bookit.inquire.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.inquire.model.vo.Inquire;

@Repository
public class InquireDaoImpl implements InquireDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Inquire> selectAllInquire(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("inquire.selectAllInquire", null, rowBounds);
	}

	@Override
	public int selectTotalContent() {
		return session.selectOne("inquire.selectTotalContent");
	}

	@Override
	public int insertInquire(Inquire inquire) {
		return session.insert("inquire.insertInquire", inquire);
	}

	@Override
	public Inquire selectOneInquire(int no) {
		return session.selectOne("inquire.selectOneInquire", no);
	}

	@Override
	public AdminInquire selectOneAdminInquire(int no) {
		return session.selectOne("inquire.selectOneAdminInquire", no);
	}
	
	@Override
	public int updateCondition(int no) {
		return session.update("inquire.updateCondition", no);
	}
	
	
}
