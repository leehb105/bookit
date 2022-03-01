package com.finale.bookit.wishlist.model.service;

import java.util.List;
import java.util.Map;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.wishlist.model.vo.Wishlist;

public interface WishlistService {

	List<Wishlist> selectAllWishlist(Map<String, Object> param);

	List<BookCollection> selectAllCollection(Map<String, Object> param);

	int wishlistDelete(String no);

	int wishlistEnroll(Map<String, Object> param);

	int collectionInsert(Map<String, Object> param);

	int collectionDelete(String no);

	int selectTotalWishlist(Member loginMember);

	int wishlistCancel(Map<String, Object> param);


}
