package com.finale.bookit.board.model.service;

import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Request;

public interface RequestService {

	List<Request> selectAllRequest(Map<String, Object> param);

	int selectTotalRequest();

}
