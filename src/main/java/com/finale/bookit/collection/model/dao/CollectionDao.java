package com.finale.bookit.collection.model.dao;

import java.util.List;

import com.finale.bookit.collection.model.vo.BookCollection;

public interface CollectionDao {

	List<BookCollection> selectAllCollection();

	BookCollection selectOneCollection(int no);

}
