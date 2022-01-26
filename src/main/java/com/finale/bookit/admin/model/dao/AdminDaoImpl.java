package com.finale.bookit.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertAdminReply(AdminInquire adminInquire) {
		return session.insert("admin.insertAdminReply", adminInquire);
	}

	@Override
	public List<Chart> selectChart() {
		return session.selectList("admin.selectChart");
	}

}
