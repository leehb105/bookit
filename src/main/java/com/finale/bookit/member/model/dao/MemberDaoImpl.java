package com.finale.bookit.member.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertMember(Member member) {
		return session.insert("member.insertMember", member);
	}

	@Override
	public Member selectOneMember(String id) {
		return session.selectOne("member.selectOneMember", id);
	}

	@Override
	public int insertAddress(Address address) {
		return session.insert("member.insertAddress", address);
	}

	@Override
	public int updateAddress(Address address) {
		return session.update("member.updateAddress", address);
	}

	@Override
	public int memberUpdate(Map<String, Object> param) {
		return session.update("member.memberUpdate", param);
	}

	@Override
	public int selectOneMemberCount(String id) {
		return session.selectOne("member.selectOneMemberCount", id);
	}

	@Override
	public int selectOneMemberNicknameCount(String nickname) {
		return session.selectOne("member.selectOneMemberNicknameCount", nickname);
	}

	@Override
	public int kakaoinsert(HashMap<String, Object> userInfo) {
		return session.insert("member.kakaoInsert",userInfo);
		
	}

	@Override
	public Member findkakao(HashMap<String, Object> userInfo) {
		return session.selectOne("member.findKakao", userInfo);
	}

}
