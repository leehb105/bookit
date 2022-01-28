package com.finale.bookit.admin.model.service;

import java.util.Map;
import java.util.List;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;

public interface AdminService {

	int insertAdminReply(AdminInquire adminInquire);

	int updateCondition(Map<String, Object> param);

	List<Chart> selectChart();

	List<Chart> selectChartDay(String month);


}
