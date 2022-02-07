package com.finale.bookit.collection.model.service;

import java.util.List;
import java.util.Map;

import com.finale.bookit.collection.model.vo.BookCollection;

public interface CollectionService {

	List<BookCollection> selectAllCollection(Map<String, Object> param);

	List<BookCollection> selectCollectionDetail(int no);

	int collectionDetailDelete(String no);

	int selectTotalCollection();

}
