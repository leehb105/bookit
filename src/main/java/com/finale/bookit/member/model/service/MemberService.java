package com.finale.bookit.member.model.service;

import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	int insertMember(Member member, Address address);

	Member selectOneMember(String id);

	int insertAddress(Address address);

}
