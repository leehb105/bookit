package com.finale.bookit.collection.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finale.bookit.collection.model.dao.CollectionDao;
import com.finale.bookit.collection.model.vo.BookCollection;

@Service
@Transactional(rollbackFor = Exception.class)
public class CollectionServiceImpl implements CollectionService {

	@Autowired
	private CollectionDao collectionDao;
	
	@Override
	public List<BookCollection> selectAllCollection() {
		return collectionDao.selectAllCollection();
	}

	@Override
	public BookCollection selectOneCollection(int no) {
		return collectionDao.selectOneCollection(no);
	}

}
