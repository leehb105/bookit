package com.finale.bookit.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.member.model.dao.MemberDao;
import com.finale.bookit.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	
}
