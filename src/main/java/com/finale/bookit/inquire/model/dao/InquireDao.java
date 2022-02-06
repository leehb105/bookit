package com.finale.bookit.inquire.model.dao;

import java.util.List;
import java.util.Map;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.inquire.model.vo.Inquire;
import com.finale.bookit.member.model.vo.Member;

public interface InquireDao {

	List<Inquire> selectAllInquire(Map<String, Object> param);

	int selectTotalContent(Member loginMember);

	int insertInquire(Inquire inquire);

	Inquire selectOneInquire(int no);

	AdminInquire selectOneAdminInquire(int no);


}
