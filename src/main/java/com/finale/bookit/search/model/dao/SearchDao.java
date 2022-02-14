package com.finale.bookit.search.model.dao;

import java.util.HashMap;
import java.util.List;

import com.finale.bookit.search.model.vo.BookReview;
import com.finale.bookit.search.model.vo.BookReviewEntity;

public interface SearchDao {

	List<BookReview> selectBookReviewByIsbn(HashMap<String, Object> param);

	int selectTotalBookReviewCount(HashMap<String, Object> param);

	int selectReviewIdCount(HashMap<String, Object> param);

	int bookReviewEnroll(HashMap<String, Object> param);

	
}
