package com.finale.bookit.admin.model.dao;

import java.util.Map;

import com.finale.bookit.admin.model.vo.AdminInquire;

public interface AdminDao {

	int insertAdminReply(AdminInquire adminInquire);

	int updateCondition(Map<String, Object> param);

}
