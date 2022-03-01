package com.finale.bookit.index.model.service;

import java.util.List;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.wishlist.model.vo.Wishlist;

public interface IndexService {

	List<BookCollection> selectAllCollection();

	Wishlist selectOneBestWishBook();

}
