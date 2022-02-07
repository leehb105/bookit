package com.finale.bookit.report.model.dao;

import java.util.List;
import java.util.Map;

import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.report.model.vo.ReportBoard;
import com.finale.bookit.report.model.vo.ReportUser;

public interface ReportDao {

	List<ReportUser> selectAllReportUser(Map<String, Object> param);

	int selectTotalReportUser(MemberEntity loginMember);

	List<ReportBoard> selectAllReportBoard(Map<String, Object> param);

	int selectTotalReportBoard(MemberEntity loginMember);

	ReportUser selectOneReportUser(int no);

}
