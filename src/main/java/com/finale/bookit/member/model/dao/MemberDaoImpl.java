package com.finale.bookit.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.board.model.vo.Posts;
import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.MemberEntity;
import com.finale.bookit.search.model.vo.BookReview;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertMember(MemberEntity member) {
		return session.insert("member.insertMember", member);
	}

	@Override
	public MemberEntity selectOneMember(String id) {
		return session.selectOne("member.selectOneMember", id);
	}

	@Override
	public int selectAddress(Address address) {
		return session.selectOne("member.selectAddress", address);
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
	public int memberUpdateWithoutPassword(Map<String, Object> param) {
		return session.update("member.memberUpdateWithoutPassword", param);
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
	public int selectOneMemberEmailCount(String email) {
		return session.selectOne("member.selectOneMemberEmailCount", email);
	}
	
	@Override
	public int selectOneMemberPhoneCount(String phone) {
		return session.selectOne("member.selectOneMemberPhoneCount", phone);
	}

	@Override
	public int kakaoinsert(HashMap<String, Object> userInfo) {
		return session.insert("member.kakaoInsert", userInfo);

	}

	@Override
	public MemberEntity findkakao(HashMap<String, Object> userInfo) {
		return session.selectOne("member.findKakao", userInfo);
	}

	@Override
	public int insertAuthority(String id) {
		// TODO Auto-generated method stub
		return session.insert("member.insertAuthority", id);
	}

	@Override
	public int updateMemberCash(HashMap<String, Object> param) {
		return session.insert("member.updateMemberCash", param);
	}

	public List<BookReview> selectBookReviewList(HashMap<String, Object> param) {
		return session.selectList("search.selectBookReviewList", param);
	}

	@Override
	public int selectTotalBookReviewCountById(HashMap<String, Object> param) {
		return session.selectOne("search.selectTotalBookReviewCountById", param);
	}

	@Override
	public int selectMemberCash(HashMap<String, Object> param) {
		return session.selectOne("member.selectMemberCash", param);
	}

	public int bookReviewDelete(HashMap<String, Object> param) {
		return session.update("search.bookReviewDelete", param);
	}

	
	@Override
	public int selectMemberRating(HashMap<String, Object> param) {
		return session.selectOne("member.selectMemberRating", param);
	}

	@Override
	public int chargeMemberCash(HashMap<String, Object> param) {
		return session.update("member.chargeMemberCash", param);
	}

	@Override
	public int selectMemberCash2(HashMap<String, Object> param) {
		return session.selectOne("member.selectMemberCash2", param);
	}

	@Override
	public int updateReturnDeposit(HashMap<String, Object> param) {
		return session.update("member.updateReturnDeposit", param);
	}

	@Override
	public List<Posts> selectAllPosts(String loginMember) {
		return session.selectList("member.selectMyPosts", loginMember);
	}

	@Override
	public int selectTotalPosts(String loginMember) {
		return session.selectOne("member.selectMyPostsTotalCount", loginMember);
	}


}
