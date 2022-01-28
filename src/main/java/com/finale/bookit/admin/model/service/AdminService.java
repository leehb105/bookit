package com.finale.bookit.admin.model.service;

import java.util.Map;

import com.finale.bookit.admin.model.vo.AdminInquire;

public interface AdminService {

	int insertAdminReply(AdminInquire adminInquire);

	int updateCondition(Map<String, Object> param);

}
