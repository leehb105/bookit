package com.finale.bookit.inquire.model.dao;

import java.util.List;
import java.util.Map;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.inquire.model.vo.Inquire;

public interface InquireDao {

	List<Inquire> selectAllInquire(Map<String, Object> param);

	int selectTotalContent();

	int insertInquire(Inquire inquire);

	Inquire selectOneInquire(int no);

	AdminInquire selectOneAdminInquire(int no);

	int updateCondition(int no);


}
