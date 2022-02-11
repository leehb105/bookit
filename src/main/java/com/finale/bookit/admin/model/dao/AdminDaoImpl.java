package com.finale.bookit.admin.model.dao;

import java.util.Map;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;
import com.finale.bookit.inquire.model.vo.Inquire;
import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.report.model.vo.ReportBoard;
import com.finale.bookit.report.model.vo.ReportUser;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class AdminDaoImpl implements AdminDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertAdminReply(AdminInquire adminInquire) {
		return session.insert("admin.insertAdminReply", adminInquire);
	}

	@Override
	public int updateReportUserCondition(Map<String, Object> param) {
		return session.update("admin.updateReportUserCondition", param);
	}
	
	@Override
	public int updateReportBoardCondition(Map<String, Object> param) {
		return session.update("admin.updateReportBoardCondition", param);
	}

	@Override
	public List<Chart> selectChart() {
		return session.selectList("admin.selectChart");
	}

	@Override
	public List<Chart> selectChartDay(String month) {
		return session.selectList("admin.selectChartDay",month);
	}

	@Override
	public List<Inquire> selectAllInquire(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("admin.selectAllInquire", null, rowBounds);
	}

	@Override
	public int selectTotalInquire() {
		return session.selectOne("admin.selectTotalInquire");
	}

	@Override
	public Inquire selectOneInquire(int no) {
		return session.selectOne("admin.selectOneInquire", no);
	}

	@Override
	public AdminInquire selectOneAdminInquire(int no) {
		return session.selectOne("admin.selectOneAdminInquire", no);
	}

	@Override
	public List<ReportUser> selectAllReportUser(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("admin.selectAllReportUser", null, rowBounds);
	}

	@Override
	public List<ReportBoard> selectAllReportBoard(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("admin.selectAllReportBoard", null, rowBounds);
	}

	@Override
	public int selectTotalReport() {
		return session.selectOne("admin.selectTotalReport");
	}

	@Override
	public int enableUser(String reportee) {
		return session.update("admin.enableUser", reportee);
	}

	@Override
	public int selectTotalReportBoard() {
		return session.selectOne("admin.selectTotalReportBoard");
	}

	@Override
	public List<Chart> selectCashChart() {
		return session.selectList("admin.selectCashChart");
	}

	@Override
	public List<MemberEntity> selectAllMembers(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("admin.selectAllMembers",null,rowBounds);
	}

	@Override
	public int getTotalMember() {
		// TODO Auto-generated method stub
		return session.selectOne("admin.getTotalMember");
	}

	@Override
	public int deleteYn(Map<String, Object> param) {
		String boardName = (String) param.get("boardName");
		log.debug("boardName = {}", boardName);
		
		// community, used_board, request_board 분기
		if("community".equals(boardName)) {
			return session.update("admin.communityDeleteYn", param);
		}
		else if("used".equals(boardName)) {
			return session.update("admin.usedDeleteYn", param);
		}
		else {
			return session.update("admin.requestDeleteYn", param);
		}
	}

}
