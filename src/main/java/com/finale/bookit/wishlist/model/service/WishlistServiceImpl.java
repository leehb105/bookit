package com.finale.bookit.wishlist.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.wishlist.model.dao.WishlistDao;
import com.finale.bookit.wishlist.model.vo.Wishlist;

@Service
public class WishlistServiceImpl implements WishlistService {

	@Autowired
	private WishlistDao wishlistDao;

	@Override
	public List<Wishlist> selectAllWishlist(Map<String, Object> param) {
		return wishlistDao.selectAllWishlist(param);
	}

	@Override
	public List<BookCollection> selectAllCollection(Map<String, Object> param) {
		return wishlistDao.selectAllCollection(param);
	}

	@Override
	public int wishlistDelete(String no) {
		return wishlistDao.wishlistDelete(no);
	}

	@Override
	public int wishlistEnroll(Map<String, Object> param) {
		return wishlistDao.wishlistEnroll(param);
	}

	@Override
	public int collectionInsert(Map<String, Object> param) {
		return wishlistDao.collectionInsert(param);
	}

	@Override
	public int collectionDelete(String no) {
		return wishlistDao.collectionDelete(no);
	}

	@Override
	public int selectTotalWishlist(Member loginMember) {
		return wishlistDao.selectTotalWishlist(loginMember);
	}

	@Override
	public int wishlistCancel(Map<String, Object> param) {
		return wishlistDao.wishlistCancel(param);
	}
	
}
