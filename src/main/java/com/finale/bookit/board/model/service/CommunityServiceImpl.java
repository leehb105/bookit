package com.finale.bookit.board.model.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finale.bookit.board.model.dao.CommunityDao;
import com.finale.bookit.board.model.vo.Comment;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.CommunityTest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao communityDao;

	@Override
	public Community getCommunity(int no, String memberId) {
		Community community = new Community();

		// 게시물 기본 정보
		Map<String, Object> communityMap = communityDao.selectCommunityContent(no);
		Map<String, Object> likeMap = new HashMap<>();
		likeMap.put("memberId", memberId);
		likeMap.put("communityNo", no);	
		
	//	boolean isLike = communityDao.isUserLikeCommunity(likeMap) > 0;
		
		community.setCommunityNo(Integer.parseInt(communityMap.get("communityNo").toString()));
		community.setCategory(communityMap.get("category").toString());
		community.setTitle(communityMap.get("title").toString());
		community.setReadCount(Integer.parseInt(communityMap.get("readCount").toString()));
		community.setLikeCount(Integer.parseInt(communityMap.get("likeCount").toString()));
		community.setMemberId(communityMap.get("memberId").toString());
		community.setContent(communityMap.get("content").toString());
		community.setCommentCount(Integer.parseInt(communityMap.get("commentCount").toString()));
		community.setNickname(communityMap.get("nickname").toString());
		community.setUserLikeCommunity(communityDao.isUserLikeCommunity(likeMap));
		
		
		if (communityMap.get("profileImage") != null) {
			community.setProfileImage(communityMap.get("profileImage").toString());
		}

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-ddHH:mm");
		String str = communityMap.get("regDate").toString();
		Date date = new Date();

		try {
			date = format.parse(str);

		} catch (ParseException e) {
			e.printStackTrace();
		}

		community.setRegDate(date);

		log.info("------------------ community 세팅 전------------------ ");
		log.info("--> {} ", community);

		// 댓글-대댓글 연관관계 설정
		// 1. 댓글 중 부모인 댓글만 반복
		// 2. 반복문 내에서 대댓글 조회
		// 3. 대댓글 ref가 부모 댓글 no와 동일하다면
		// 4. 댓글 객체 내 대댓글 프로퍼티 객체에 할당

		// 댓글
		List<Comment> commentList = communityDao.getCommentList(no);
		community.setComment(commentList);

		log.info("commentList {}", commentList);

		for (Comment comment : commentList) {

			List<Comment> childCommentList = new ArrayList<>();

			// 1. 댓글 중 부모인 댓글만 반복
			if (comment.getIsParent().equalsIgnoreCase("y")) {
				log.info("parent comment no {}", comment.getNo());

				// 게시물 대댓글
				// TODO: List 포문에서 빼기
				List<Comment> reCommentList = communityDao.getReCommentList(comment.getNo());

				log.info("reCommentList size {} ", reCommentList.size());

				// 2. 반복문 내에서 대댓글 조회
				for (Comment reComment : reCommentList) {
					log.info("recomment no {} ", reComment.getNo());

					log.info("equal test {}", comment.getNo() == reComment.getCommentRef());
					log.info("comment.getno {}", comment.getNo());
					log.info("recomm.getref {}", reComment.getCommentRef());

					log.info("string equal test {}",
							Integer.toString(comment.getNo()).equals(Integer.toString(reComment.getCommentRef())));

					// 3. 대댓글 ref가 부모 댓글 no와 동일하다면
					if (comment.getNo() == reComment.getCommentRef()) {

						// 3-1. 댓글 리스트에 담기
						childCommentList.add(reComment);
					}
				}

				log.info("childCommentList size {}", childCommentList.size());
			}
			// 4. 댓글 객체 내 대댓글 프로퍼티 객체에 할당
			comment.setReComments(childCommentList);
		}

		// 파일
		List<CommunityAttachment> fileList = communityDao.getAttachmentList(no);
		community.setFile(fileList);

		log.info("------------------ community 세팅 후------------------ ");
		log.info("--> {} ", community);

		return community;
	}

	@Override
	public void deleteCommunityContent(int no, String memberId) throws Exception {
		communityDao.deleteCommunityContent(no);
	}

	@Override
	public void updateCommunityContent(String memberId, CommunityTest communityDto) throws Exception {

		int no = communityDto.getCommunityNo();

		List<CommunityAttachment> attachments = communityDto.getFiles();

		//int communityResult = communityDao.getCommunityNoCurrval();
		String writer = communityDao.writerCheck(no);

		log.info("writer {}, memberId {}", writer, memberId);
		
		if (memberId.trim().equals(writer.trim())) {

			if (attachments != null) {
				for (CommunityAttachment attach : attachments) {
					// 3. 리턴값으로 받은 커뮤니티 넘버 할당해주기
					attach.setCommunityNo(no);
					// 4. 파일 테이블에 데이터 인서트
					insertCommunityAttachment(attach);
				}

				communityDao.updateCommunityContent(communityDto);
			}

		} else {
			throw new Exception("Unauthorized!");
		}
	}

	@Override
	public List<Community> getCommunityList(Map<String, Object> param) {
		return communityDao.getCommunityList(param);
	}

	@Override
	public int getTotalCommunityContent() {
		return communityDao.getTotalCommunityContent();
	}

	@Override
	public void insertCommunity(CommunityTest communityTest) {
		// 커뮤니티 테이블의 pk가 파일 테이블 커뮤니티 넘버의 부모로서,
		// 커뮤니티 테이블의 데이터가 먼저 만들어져야한다.

		// 1. 커뮤니티 테이블에 데이터 인서트
		communityDao.insertCommunity(communityTest);

		// 2. 업로드된 커뮤니티 넘버 조회 (currval이용)
		int communityResult = communityDao.getCommunityNoCurrval();

		List<CommunityAttachment> attachments = communityTest.getFiles();

		if (attachments != null) {
			for (CommunityAttachment attach : attachments) {
				// 3. 리턴값으로 받은 커뮤니티 넘버 할당해주기
				attach.setCommunityNo(communityResult);
				// 4. 파일 테이블에 데이터 인서트
				insertCommunityAttachment(attach);
			}
		}

	}

	public int insertCommunityAttachment(CommunityAttachment attach) {
		return communityDao.insertCommunityAttachment(attach);
	}

	@Override
	public CommunityAttachment selectOneCommunityAttachment(int no) {
		return communityDao.selectOneCommunityAttachment(no);
	}

	@Override
	public int updateReadCount(int no) {
		return communityDao.updateReadCount(no);
	}

	@Override
	public int getCommunityNoCurrval() {
		return communityDao.getCommunityNoCurrval();
	}

	@Override
	public void insertComment(Comment comment) throws Exception {
		communityDao.insertComment(comment);
	}

	@Override
	public int deleteComment(int no) throws Exception {
		return communityDao.deleteComment(no);
	}

	@Override
	public List<Comment> getCommentList(int no) {
		List<Comment> commentList = communityDao.getCommentList(no);

		for (Comment comment : commentList) {

			List<Comment> childCommentList = new ArrayList<>();

			// 1. 댓글 중 부모인 댓글만 반복
			if (comment.getIsParent().equalsIgnoreCase("y")) {
				log.info("parent comment no {}", comment.getNo());

				// 게시물 대댓글
				// TODO: List 포문에서 빼기
				List<Comment> reCommentList = communityDao.getReCommentList(comment.getNo());

				log.info("reCommentList size {} ", reCommentList.size());

				// 2. 반복문 내에서 대댓글 조회
				for (Comment reComment : reCommentList) {
					log.info("recomment no {} ", reComment.getNo());

					log.info("equal test {}", comment.getNo() == reComment.getCommentRef());
					log.info("comment.getno {}", comment.getNo());
					log.info("recomm.getref {}", reComment.getCommentRef());

					log.info("string equal test {}",
							Integer.toString(comment.getNo()).equals(Integer.toString(reComment.getCommentRef())));

					// 3. 대댓글 ref가 부모 댓글 no와 동일하다면
					if (comment.getNo() == reComment.getCommentRef()) {

						// 3-1. 댓글 리스트에 담기
						childCommentList.add(reComment);
					}
				}

				log.info("childCommentList size {}", childCommentList.size());
			}
			// 4. 댓글 객체 내 대댓글 프로퍼티 객체에 할당
			comment.setReComments(childCommentList);
		}

		return commentList;
	}

	@Override
	public void insertReComment(Comment reComment) {
		
		Comment comment = new Comment();
	
		comment.setIsParent("Y");
		comment.setNo(reComment.getCommentRef());
		
		communityDao.isParent(comment);
		communityDao.insertReComment(reComment);
	}

	@Override
	public List<Community> searchCommuntiy(Map<String, Object> map) {

		return communityDao.searchCommuntiy(map);
	}

	@Override
	public void updateComment(Comment comment) {
		communityDao.updateComment(comment);
	}

	@Override
	public int getSearchCommuntiyContentCount(Map<String, Object> param) {
		return communityDao.getSearchCommuntiyContentCount(param);

	}

	@Override
	public void likeCountUp(Map<String, Object> param) {
		communityDao.likeCountUp(Integer.parseInt(param.get("communityNo").toString()));
		communityDao.communityLike(param);
	}

	@Override
	public void likeCountDown(Map<String, Object> param) {
		communityDao.likeCountDown(Integer.parseInt(param.get("communityNo").toString()));
		communityDao.communityLikeCancel(param);
	}

}
