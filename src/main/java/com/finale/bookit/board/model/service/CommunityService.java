package com.finale.bookit.board.model.service;



import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Community;


public interface CommunityService {
	
	 Community getCommunity(int no);

	void deleteCommunityContent(int no);

	void updateCommunityContent(Map<String, Object> param);

	List<Community> getCommunityList(Map<String, Object> param);

	int getTotalCommunityContent();
	
}
