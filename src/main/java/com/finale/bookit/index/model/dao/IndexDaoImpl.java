package com.finale.bookit.index.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.wishlist.model.vo.Wishlist;

@Repository
public class IndexDaoImpl implements IndexDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<BookCollection> selectAllCollection() {
		return session.selectList("index.selectAllCollection");
	}

	@Override
	public Wishlist selectOneBestWishBook() {
		return session.selectOne("index.selectOneBestWishBook");
	}
	
	
}
