package com.finale.bookit.report.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.report.model.vo.ReportBoard;
import com.finale.bookit.report.model.vo.ReportUser;

@Repository
public class ReportDaoImpl implements ReportDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<ReportUser> selectAllReportUser(Map<String, Object> param) {
		String id = (String) param.get("id");
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("report.selectAllReportUser", id, rowBounds);
	}
	
	@Override
	public int selectTotalReportUser(MemberEntity loginMember) {
		return session.selectOne("report.selectTotalReportUser", loginMember);
	}

	@Override
	public List<ReportBoard> selectAllReportBoard(Map<String, Object> param) {
		String id = (String) param.get("id");
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("report.selectAllReportBoard", id, rowBounds);
	}
	
	@Override
	public int selectTotalReportBoard(MemberEntity loginMember) {
		return session.selectOne("report.selectTotalReportBoard", loginMember);
	}

	@Override
	public ReportUser selectOneReportUser(int no) {
		return session.selectOne("report.selectOneReportUser", no);
	}
	
	
}
