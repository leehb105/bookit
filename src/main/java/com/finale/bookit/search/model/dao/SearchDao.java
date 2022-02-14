package com.finale.bookit.search.model.dao;

import java.util.HashMap;
import java.util.List;

import com.finale.bookit.search.model.vo.BookReview;

public interface SearchDao {

	List<BookReview> selectBookReviewByIsbn(HashMap<String, Object> param);

	int selectTotalBookReviewCount(HashMap<String, Object> param);

	
}
