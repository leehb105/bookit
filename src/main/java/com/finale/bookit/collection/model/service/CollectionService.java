package com.finale.bookit.collection.model.service;

import java.util.List;

import com.finale.bookit.collection.model.vo.BookCollection;

public interface CollectionService {

	List<BookCollection> selectAllCollection();

	BookCollection selectOneCollection(int no);

}
