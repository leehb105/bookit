package com.finale.bookit.board.model.dao;

import java.util.List;
import java.util.Map;

import com.finale.bookit.board.model.vo.Request;

public interface RequestDao {

	List<Request> selectAllRequest(Map<String, Object> param);

	int selectTotalRequest();

	int requestEnroll(Map<String, Object> param);

	int requestDelete(int requestNo);

}
