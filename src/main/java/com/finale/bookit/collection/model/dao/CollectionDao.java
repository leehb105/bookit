package com.finale.bookit.collection.model.dao;

import java.util.List;
import java.util.Map;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.collection.model.vo.BookCollectionList;

public interface CollectionDao {

	List<BookCollection> selectAllCollection(Map<String, Object> param);

	List<BookCollection> selectCollectionDetail(Map<String, Object> param);

	int collectionDetailDelete(String no);

	int selectTotalCollection();

	List<BookCollectionList> selectAllBookList(int no);

	int selectTotalBookList(int no);

	int insertBook(Map<String, Object> param);

}
