package com.finale.bookit.inquire.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.inquire.model.dao.InquireDao;
import com.finale.bookit.inquire.model.vo.Inquire;
import com.finale.bookit.member.model.vo.MemberEntity;

@Service
public class InquireServiceImple implements InquireService {

	@Autowired
	private InquireDao inquireDao;

	@Override
	public List<Inquire> selectAllInquire(Map<String, Object> param) {
		return inquireDao.selectAllInquire(param);
	}

	@Override
	public int selectTotalContent(MemberEntity loginMember) {
		return inquireDao.selectTotalContent(loginMember);
	}

	@Override
	public int insertInquire(Inquire inquire) {
		return inquireDao.insertInquire(inquire);
	}

	@Override
	public Inquire selectOneInquire(int no) {
		return inquireDao.selectOneInquire(no);
	}

	@Override
	public AdminInquire selectOneAdminInquire(int no) {
		return inquireDao.selectOneAdminInquire(no);
	}
	
	
	
	
}
