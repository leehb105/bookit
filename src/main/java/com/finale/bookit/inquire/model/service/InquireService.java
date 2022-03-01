package com.finale.bookit.inquire.model.service;

import java.util.List;
import java.util.Map;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.inquire.model.vo.Inquire;
import com.finale.bookit.member.model.vo.MemberEntity;

public interface InquireService {

	List<Inquire> selectAllInquire(Map<String, Object> param);

	int selectTotalContent(MemberEntity loginMember);

	int insertInquire(Inquire inquire);

	Inquire selectOneInquire(int no);

	AdminInquire selectOneAdminInquire(int no);



}
