package com.finale.bookit.board.model.service;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finale.bookit.board.model.dao.CommunityDao;
import com.finale.bookit.board.model.vo.Comment;
import com.finale.bookit.board.model.vo.Community;
import com.finale.bookit.board.model.vo.CommunityAttachment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	private CommunityDao communityDao;
	
	@Override
	public Community getCommunity(int no) {
		Community community = new Community();
		
		// 게시물 기본 정보
		Map<String, Object> communityMap = communityDao.selectCommunityContent(no);
		
	    community.setCategory(communityMap.get("category").toString());
	    community.setTitle(communityMap.get("title").toString());
	    community.setReadCount(Integer.parseInt(communityMap.get("readCount").toString()));
	    community.setLikeCount(Integer.parseInt(communityMap.get("likeCount").toString()));
	    community.setMemberId(communityMap.get("memberId").toString());
	    community.setContent(communityMap.get("content").toString());
	    community.setCommentCount(Integer.parseInt(communityMap.get("commentCount").toString()));
	    community.setNickname(communityMap.get("nickname").toString());
	    
	    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-ddHH:mm");
	    String str =  communityMap.get("regDate").toString();
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
	    
	    //댓글 
	    List<Comment> commentList = communityDao.getCommentList(no);
	    community.setComment(commentList);
	    
	    log.info("commentList {}", commentList);
	    
	    
	    
	    for(Comment comment : commentList) {
	    	
	    	List<Comment> childCommentList = new ArrayList<>();
	    	
	    	// 1. 댓글 중 부모인 댓글만 반복
	    	if(comment.getIsParent().equalsIgnoreCase("y")) {
	    		log.info("parent comment no {}", comment.getNo());
	    		
	    		// 게시물 대댓글
	    		// TODO: List 포문에서 빼기 
	    	    List<Comment> reCommentList = communityDao.getReCommentList(comment.getNo());
	    	   
	    	    log.info("reCommentList size {} ", reCommentList.size());
	    	    
	    	    // 2. 반복문 내에서 대댓글 조회
	    	    for(Comment reComment : reCommentList) {
	    	    	log.info("recomment no {} ", reComment.getNo());
	    	
	    	    	log.info("equal test {}", comment.getNo() == reComment.getCommentRef());
	    	    	log.info("comment.getno {}", comment.getNo());
	    	    	log.info("recomm.getref {}", reComment.getCommentRef());
	    	    	
	    	    	log.info("string equal test {}", Integer.toString(comment.getNo()).equals(Integer.toString(reComment.getCommentRef()) )  );
	    	    	
	    	    	 // 3. 대댓글 ref가 부모 댓글 no와 동일하다면
	    	    	if(comment.getNo() == reComment.getCommentRef()) {
	    	    		
	    	    		// 3-1. 댓글 리스트에 담기
	    	    		childCommentList.add(reComment);	
	    	    	}
	    	 	}
	    	    
	    	    log.info("childCommentList size {}", childCommentList.size());
	    	}
	    	// 4. 댓글 객체 내 대댓글 프로퍼티 객체에 할당
	    	comment.setReComments(childCommentList);	
	    }
  
	    //파일 
	    List<CommunityAttachment> fileList = communityDao.getAttachmentList(no);
	    community.setFile(fileList);
	  
	 
	    
	    log.info("------------------ community 세팅 후------------------ ");
	    log.info("--> {} ", community);

	    return community;
	}

	@Override
	public void deleteCommunityContent(int no, String memberId) throws Exception {
		String writer = communityDao.writerCheck(no);
		
		if(memberId.equals(writer)) {
			communityDao.deleteCommunityContent(no);
		}else {
			throw new Exception("Unauthorized!");
		}
		
	
		
	}

	@Override
	public void updateCommunityContent(String memberId, Map<String, Object> param) throws Exception {
		
		int no = Integer.parseInt((String)param.get("no"));
		
		String writer = communityDao.writerCheck(no);
		if(memberId == writer) {
			communityDao.updateCommunityContent(param);
		}else {
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
