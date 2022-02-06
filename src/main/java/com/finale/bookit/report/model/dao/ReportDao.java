package com.finale.bookit.report.model.dao;

import java.util.List;
import java.util.Map;

import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.report.model.vo.ReportBoard;
import com.finale.bookit.report.model.vo.ReportUser;

public interface ReportDao {

	List<ReportUser> selectAllReportUser(Map<String, Object> param);

	int selectTotalReportUser(Member loginMember);

	List<ReportBoard> selectAllReportBoard(Map<String, Object> param);

	int selectTotalReportBoard(Member loginMember);

	ReportUser selectOneReportUser(int no);

}
