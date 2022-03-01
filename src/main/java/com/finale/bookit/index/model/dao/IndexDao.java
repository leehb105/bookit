package com.finale.bookit.index.model.dao;

import java.util.List;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.wishlist.model.vo.Wishlist;

public interface IndexDao {

	List<BookCollection> selectAllCollection();

	Wishlist selectOneBestWishBook();

}
