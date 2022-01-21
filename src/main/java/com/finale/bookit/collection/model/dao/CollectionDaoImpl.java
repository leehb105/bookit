package com.finale.bookit.collection.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.collection.model.vo.BookCollection;

@Repository
public class CollectionDaoImpl implements CollectionDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<BookCollection> selectAllCollection() {
		return session.selectList("bookCollection.selectAllCollection");
	}

	@Override
	public BookCollection selectOneCollection(int no) {
		return session.selectOne("bookCollection.selectOneCollection", no);
	}

}
