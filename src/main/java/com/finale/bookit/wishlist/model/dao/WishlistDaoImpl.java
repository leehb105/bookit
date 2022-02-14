package com.finale.bookit.wishlist.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.member.model.vo.Member;
import com.finale.bookit.wishlist.model.vo.Wishlist;

@Repository
public class WishlistDaoImpl implements WishlistDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Wishlist> selectAllWishlist(Map<String, Object> param) {
		String id = (String) param.get("id");
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("wishlist.selectAllWishlist", id, rowBounds);
	}

	@Override
	public List<BookCollection> selectAllCollection(Map<String, Object> param) {
		String id = (String) param.get("id");
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("wishlist.selectAllCollection", id, rowBounds);
	}

	@Override
	public int wishlistDelete(String no) {
		return session.delete("wishlist.wishlistDelete", no);
	}

	@Override
	public int wishlistEnroll(Map<String, Object> param) {
		return session.insert("wishlist.wishlistEnroll", param);
	}

	@Override
	public int collectionInsert(Map<String, Object> param) {
		return session.insert("wishlist.collectionInsert", param);
	}

	@Override
	public int collectionDelete(String no) {
		return session.delete("wishlist.collectionDelete", no);
	}

	@Override
	public int selectTotalWishlist(Member loginMember) {
		return session.selectOne("wishlist.selectTotalWishlist", loginMember);
	}

	@Override
	public int wishlistCancel(Map<String, Object> param) {
		return session.delete("wishlist.wishlistCancel", param);
	}
	
}
