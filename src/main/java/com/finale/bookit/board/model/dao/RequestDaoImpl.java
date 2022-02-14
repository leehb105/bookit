package com.finale.bookit.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.board.model.vo.Request;

@Repository
public class RequestDaoImpl implements RequestDao{

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Request> selectAllRequest(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("request.selectAllRequest", null, rowBounds);
	}

	@Override
	public int selectTotalRequest() {
		return session.selectOne("request.selectTotalRequest");
	}

	@Override
	public int requestEnroll(Map<String, Object> param) {
		return session.insert("request.requestEnroll", param);
	}

	@Override
	public int requestDelete(int requestNo) {
		return session.delete("request.requestDelete", requestNo);
	}
	
	
}
