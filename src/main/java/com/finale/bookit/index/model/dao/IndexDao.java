package com.finale.bookit.index.model.dao;

import java.util.List;

import com.finale.bookit.collection.model.vo.BookCollection;

public interface IndexDao {

	List<BookCollection> selectAllCollection();

}
