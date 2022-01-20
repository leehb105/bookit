package com.finale.bookit.member.model.service;

import com.finale.bookit.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectOneMember(String id);

}
