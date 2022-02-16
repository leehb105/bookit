package com.finale.bookit.search.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.search.model.vo.BookReview;
import com.finale.bookit.search.model.vo.BookReviewEntity;

@Repository
public class SearchDaoImpl implements SearchDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<BookReview> selectBookReviewByIsbn(HashMap<String, Object> param) {
		return session.selectList("search.selectBookReviewByIsbn", param);
	}

	@Override
	public int selectTotalBookReviewCount(HashMap<String, Object> param) {
		return session.selectOne("search.selectTotalBookReviewCount", param);
	}

	@Override
	public int selectReviewIdCount(HashMap<String, Object> param) {
		return session.selectOne("search.selectReviewIdCount", param);
	}

	@Override
	public int bookReviewEnroll(HashMap<String, Object> param) {
		return session.insert("search.bookReviewEnroll", param);
	}

	@Override
	public float selectAvgRating(HashMap<String, Object> param) {
		return session.selectOne("search.selectAvgRating", param);
	}
	
	
}
