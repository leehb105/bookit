package com.finale.bookit.member.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finale.bookit.member.model.dao.MemberDao;
import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor=Exception.class)
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}
	
	@Override
	public int insertMember(Member member, Address address) {
		int result = memberDao.insertMember(member);
		if (result > 0) {
			result = insertAddress(address);
		}
		
		return result;
	}

	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	@Override
	public int insertAddress(Address address) {
		return memberDao.insertAddress(address);
	}

	@Override
	public int memberUpdate(Map<String, Object> param) {
		return memberDao.memberUpdate(param);
	}

	@Override
	public int selectOneMemberCount(String id) {
		return memberDao.selectOneMemberCount(id);
	}

	@Override
	public int selectOneMemberNicknameCount(String nickname) {
		return memberDao.selectOneMemberNicknameCount(nickname);
	}

	
}
