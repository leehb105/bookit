package com.finale.bookit.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Posts;
import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.search.model.vo.BookReview;

public interface MemberService {

	int insertMember(MemberEntity member);

	int insertMember(MemberEntity member, Address address);

	MemberEntity selectOneMember(String id);

	int selectAddress(Address address);

	int insertAddress(Address address);

	int updateAddress(Address address);

	int memberUpdate(Map<String, Object> param, Address address);

	int selectOneMemberCount(String id);

	int selectOneMemberNicknameCount(String nickname);

	String getAccessToken(String code);

	MemberEntity getUserInfo(String access_Token);

	int insertAuthority(String id);

	List<BookReview> selectBookReviewList(HashMap<String, Object> param);

	int selectTotalBookReviewCountById(HashMap<String, Object> param);

	int selectMemberCash(HashMap<String, Object> param);

	int bookReviewDelete(HashMap<String, Object> param);

	int selectMyPostsTotalCount(String member);
	
	List<Posts> selectMyPosts(String member);
	
	void deleteCommunityContent(int no);
	
	void deleteUsedContent(int no);

	int selectMemberRating(HashMap<String, Object> param);

	int selectOneMemberEmailCount(String email);

	int selectOneMemberPhoneCount(String phone);


}
