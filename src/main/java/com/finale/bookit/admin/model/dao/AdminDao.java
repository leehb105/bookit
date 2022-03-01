package com.finale.bookit.admin.model.dao;

import java.util.Map;
import java.util.List;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;
import com.finale.bookit.inquire.model.vo.Inquire;
import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.report.model.vo.ReportBoard;
import com.finale.bookit.report.model.vo.ReportUser;

public interface AdminDao {

	int insertAdminReply(AdminInquire adminInquire);

	int updateReportUserCondition(Map<String, Object> param);
	
	int updateReportBoardCondition(Map<String, Object> param);
	
	List<Chart> selectChart();

	List<Chart> selectChartDay(String month);

	List<Inquire> selectAllInquire(Map<String, Object> param);

	int selectTotalInquire();

	Inquire selectOneInquire(int no);

	AdminInquire selectOneAdminInquire(int no);

	List<ReportUser> selectAllReportUser(Map<String, Object> param);

	List<ReportBoard> selectAllReportBoard(Map<String, Object> param);

	int selectTotalReport();

	int enableUser(String reportee);

	int selectTotalReportBoard();

	List<Chart> selectCashChart();

	List<Member> selectAllMembers(Map<String, Object> param);

	int getTotalMember();

	int deleteYn(Map<String, Object> param);

	int selectAuthority(String userId);

	int insertAuthority(String userId);

	int deleteAuthority(String userId);

	int insertAuthority_ADMIN(String userId);


}
