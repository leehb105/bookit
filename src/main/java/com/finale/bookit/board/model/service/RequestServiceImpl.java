package com.finale.bookit.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.board.model.dao.RequestDao;
import com.finale.bookit.board.model.vo.Request;

@Service
public class RequestServiceImpl implements RequestService{

	@Autowired
	private RequestDao requestDao;

	@Override
	public List<Request> selectAllRequest(Map<String, Object> param) {
		return requestDao.selectAllRequest(param);
	}

	@Override
	public int selectTotalRequest() {
		return requestDao.selectTotalRequest();
	}

	@Override
	public int requestEnroll(Map<String, Object> param) {
		return requestDao.requestEnroll(param);
	}

	@Override
	public int requestDelete(int requestNo) {
		return requestDao.requestDelete(requestNo);
	}
	
	
}
