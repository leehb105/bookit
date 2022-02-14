package com.finale.bookit.board.model.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finale.bookit.board.model.dao.UsedDao;
import com.finale.bookit.board.model.vo.CommunityAttachment;
import com.finale.bookit.board.model.vo.Used;
import com.finale.bookit.board.model.vo.UsedAttachment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class UsedServiceImpl implements UsedService{
	
	@Autowired 
	private UsedDao usedDao;
	
	public Used getUsed(int no) {
		Used used = new Used();
		
		Map<String, Object> usedMap = usedDao.selectUsedContent(no);
		
		used.setCategory(usedMap.get("category").toString());
		used.setTitle(usedMap.get("title").toString());
		used.setReadCount(Integer.parseInt(usedMap.get("readCount").toString()));
		used.setWriter(usedMap.get("writer").toString());
		used.setContent(usedMap.get("content").toString());
		used.setNickname(usedMap.get("nickname").toString());
	    
	    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-ddHH:mm");
	    String str =  usedMap.get("regDate").toString();
	    Date date = new Date();
	   
		try {
			date = format.parse(str);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		used.setRegDate(date); 
	    
	    
	    //파일 
	    List<UsedAttachment> fileList = usedDao.getUsedAttachmentList(no);
	    used.setFiles(fileList);

	    return used;
	}

	@Override
	public void updateUsedContent(Map<String, Object> param) {
		usedDao.updateUsedContent(param);
	}
	
	@Override
	public List<Used> getUsedList(Map<String, Object> param) {
		return usedDao.getUsedList(param);
	}

	@Override
	public int getTotalUsedContent() {
		return usedDao.getTotalUsedContent();
	}

	@Override
	public void deleteUsedContent(int no, String id) {
		usedDao.deleteUsedContent(no);
	}

	@Override
	public void insertUsed(Used used) {
		usedDao.insertUsed(used);
		
		int usedResult = usedDao.getUsedNoCurrval();
		List<UsedAttachment> attachments = used.getFiles();
		
		if(attachments != null) {
			for(UsedAttachment attach : attachments) {
				// 3. 리턴값으로 받은 커뮤니티 넘버 할당해주기
				attach.setUsedBoardNo(usedResult);
				// 4. 파일 테이블에 데이터 인서트
				insertUsedAttachment(attach);
			}
		}
	
	}
	
	public int insertUsedAttachment(UsedAttachment attach) {
		return usedDao.insertUsedAttachment(attach);
	}


	@Override
	public UsedAttachment selectOneUsedAttachment(int no) {
		return usedDao.selectOneUsedAttachment(no);
	}


	@Override
	public int getSearchUsedContentCount(Map<String, Object> param) {
		return usedDao.getSearchUsedContentCount(param);
	}

	@Override
	public int getUsedNoCurrval() {
		return usedDao.getUsedNoCurrval();
	}
	
}
