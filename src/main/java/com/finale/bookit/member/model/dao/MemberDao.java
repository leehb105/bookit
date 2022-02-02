package com.finale.bookit.member.model.dao;

import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.Member;

public interface MemberDao {

	int insertMember(Member member);

	Member selectOneMember(String id);

	int insertAddress(Address address);

}
