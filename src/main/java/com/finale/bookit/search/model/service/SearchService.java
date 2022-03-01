package com.finale.bookit.search.model.service;

import java.util.HashMap;
import java.util.List;

import com.finale.bookit.search.model.vo.BookReview;
import com.finale.bookit.search.model.vo.BookReviewEntity;


public interface SearchService {
	
	public String searchBookByTitle(String keyword);
	public int searchBookPageByIsbn13(String isbn13);
	
	public int searchBookPageByIsbn10(String isbn10);
	public String searchBookByIsbn13(String isbnNum);

	public List<BookReview> selectBookReviewByIsbn(HashMap<String, Object> param);
	public int selectTotalBookReviewCount(HashMap<String, Object> param);
	public int selectReviewIdCount(HashMap<String, Object> param);
	public int bookReviewEnroll(HashMap<String, Object> param);
	public float selectAvgRating(HashMap<String, Object> param);
}
