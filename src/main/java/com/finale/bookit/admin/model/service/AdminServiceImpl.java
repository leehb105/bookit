package com.finale.bookit.admin.model.service;

import java.util.Map;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.admin.model.dao.AdminDao;
import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;
import com.finale.bookit.inquire.model.vo.Inquire;
import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.report.model.vo.ReportBoard;
import com.finale.bookit.report.model.vo.ReportUser;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDao adminDao;

	@Override
	public int insertAdminReply(AdminInquire adminInquire) {
		return adminDao.insertAdminReply(adminInquire);
	}

	@Override
	public int updateReportUserCondition(Map<String, Object> param) {
		return adminDao.updateReportUserCondition(param);
	}
	
	@Override
	public int updateReportBoardCondition(Map<String, Object> param) {
		return adminDao.updateReportBoardCondition(param);
	}

	@Override
	public List<Chart> selectChart() {
		return adminDao.selectChart();
	}

	@Override
	public List<Chart> selectChartDay(String month) {
		return adminDao.selectChartDay(month);
	}

	@Override
	public List<Inquire> selectAllInquire(Map<String, Object> param) {
		return adminDao.selectAllInquire(param);
	}

	@Override
	public int selectTotalInquire() {
		return adminDao.selectTotalInquire();
	}

	@Override
	public Inquire selectOneInquire(int no) {
		return adminDao.selectOneInquire(no);
	}

	@Override
	public AdminInquire selectOneAdminInquire(int no) {
		return adminDao.selectOneAdminInquire(no);
	}

	@Override
	public List<ReportUser> selectAllReportUser(Map<String, Object> param) {
		return adminDao.selectAllReportUser(param);
	}

	@Override
	public List<ReportBoard> selectAllReportBoard(Map<String, Object> param) {
		return adminDao.selectAllReportBoard(param);
	}

	@Override
	public int selectTotalReport() {
		return adminDao.selectTotalReport();
	}

	@Override
	public int enableUser(String reportee) {
		return adminDao.enableUser(reportee);
	}

	@Override
	public int selectTotalReportBoard() {
		return adminDao.selectTotalReportBoard();
	}

	@Override
	public List<Chart> selectCashChart() {
		return adminDao.selectCashChart();
	}

	@Override
	public List<Member> selectAllMembers(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return adminDao.selectAllMembers(param);
	}

	@Override
	public int getTotalMember() {
		// TODO Auto-generated method stub
		return adminDao.getTotalMember();
	}

	@Override
	public int deleteYn(Map<String, Object> param) {
		return adminDao.deleteYn(param);
	}

	@Override
	public int selectAuthority(String userId) {

		return adminDao.selectAuthority(userId);
	}

	@Override
	public int insertAuthority(String userId) {

		return adminDao.insertAuthority(userId);
	}

	@Override
	public int deleteAuthority(String userId) {
		return adminDao.deleteAuthority(userId);
	}

	@Override
	public int insertAuthority_ADMIN(String userId) {
		// TODO Auto-generated method stub
		return adminDao.insertAuthority_ADMIN(userId);
	}



}
