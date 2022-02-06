package com.finale.bookit.collection.model.service;

import java.util.List;
import java.util.Map;

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
	public List<BookCollection> selectAllCollection(Map<String, Object> param) {
		return collectionDao.selectAllCollection(param);
	}

	@Override
	public List<BookCollection> selectCollectionDetail(int no) {
		return collectionDao.selectCollectionDetail(no);
	}

	@Override
	public int collectionDetailDelete(String no) {
		return collectionDao.collectionDetailDelete(no);
	}

	@Override
	public int selectTotalCollection() {
		return collectionDao.selectTotalCollection();
	}

}
