package com.finale.bookit.admin.model.dao;

import java.util.List;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;

public interface AdminDao {

	int insertAdminReply(AdminInquire adminInquire);

	List<Chart> selectChart();

	List<Chart> selectChartDay(String month);

}
