package com.finale.bookit.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.search.model.vo.BookReview;

public interface MemberDao {

	int insertMember(MemberEntity member);

	MemberEntity selectOneMember(String id);

	int selectAddress(Address address);

	int insertAddress(Address address);

	int updateAddress(Address address);

	int memberUpdate(Map<String, Object> param);

	int selectOneMemberCount(String id);

	int selectOneMemberNicknameCount(String nickname);

	int kakaoinsert(HashMap<String, Object> userInfo);

	MemberEntity findkakao(HashMap<String, Object> userInfo);

	int insertAuthority(String id);

	int updateMemberCash(HashMap<String, Object> param);

	List<BookReview> selectBookReviewList(HashMap<String, Object> param);

	int selectTotalBookReviewCountById(HashMap<String, Object> param);

	int selectMemberCash(HashMap<String, Object> param);

	int bookReviewDelete(HashMap<String, Object> param);

}
