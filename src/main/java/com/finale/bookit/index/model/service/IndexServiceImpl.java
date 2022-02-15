package com.finale.bookit.index.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.index.model.dao.IndexDao;
import com.finale.bookit.wishlist.model.vo.Wishlist;

@Service
public class IndexServiceImpl implements IndexService {
	
	@Autowired
	private IndexDao indexDao;

	@Override
	public List<BookCollection> selectAllCollection() {
		return indexDao.selectAllCollection();
	}

	@Override
	public Wishlist selectOneBestWishBook() {
		return indexDao.selectOneBestWishBook();
	}

}
