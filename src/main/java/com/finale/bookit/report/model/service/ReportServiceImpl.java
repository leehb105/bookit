package com.finale.bookit.report.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.report.model.dao.ReportDao;
import com.finale.bookit.report.model.vo.ReportBoard;
import com.finale.bookit.report.model.vo.ReportUser;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;

	@Override
	public List<ReportUser> selectAllReportUser(Map<String, Object> param) {
		return reportDao.selectAllReportUser(param);
	}
	
	@Override
	public int selectTotalReportUser(MemberEntity loginMember) {
		return reportDao.selectTotalReportUser(loginMember);
	}

	@Override
	public List<ReportBoard> selectAllReportBoard(Map<String, Object> param) {
		return reportDao.selectAllReportBoard(param);
	}
	
	@Override
	public int selectTotalReportBoard(MemberEntity loginMember) {
		return reportDao.selectTotalReportBoard(loginMember);
	}

	@Override
	public ReportUser selectOneReportUser(int no) {
		return reportDao.selectOneReportUser(no);
	}

	@Override
	public int insertReportBoard(Map<String, Object> param) {
		return reportDao.insertReportBoard(param);
	}

	@Override
	public int insertReportUser(Map<String, Object> param) {
		return reportDao.insertReportUser(param);
	}
	
	
}
