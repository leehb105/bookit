package com.finale.bookit.member.model.dao;

import java.util.HashMap;
import java.util.Map;

import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.Member;

public interface MemberDao {

	int insertMember(Member member);

	Member selectOneMember(String id);

	int insertAddress(Address address);

	int updateAddress(Address address);

	int memberUpdate(Map<String, Object> param);

	int selectOneMemberCount(String id);

	int selectOneMemberNicknameCount(String nickname);

	int kakaoinsert(HashMap<String, Object> userInfo);

	Member findkakao(HashMap<String, Object> userInfo);

}
