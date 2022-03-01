package com.finale.bookit.collection.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.collection.model.vo.BookCollection;
import com.finale.bookit.collection.model.vo.BookCollectionList;

@Repository
public class CollectionDaoImpl implements CollectionDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<BookCollection> selectAllCollection(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("bookCollection.selectAllCollection", null, rowBounds);
	}

	@Override
	public List<BookCollection> selectCollectionDetail(Map<String, Object> param) {
		int no = (int) param.get("no");
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("bookCollection.selectCollectionDetail", no, rowBounds);
	}

	@Override
	public int collectionDetailDelete(String no) {
		return session.delete("bookCollection.collectionDetailDelete", no);
	}

	@Override
	public int selectTotalCollection() {
		return session.selectOne("bookCollection.selectTotalCollection");
	}

	@Override
	public List<BookCollectionList> selectAllBookList(int no) {
		return session.selectList("bookCollection.selectAllBookList", no);
	}

	@Override
	public int selectTotalBookList(int no) {
		return session.selectOne("bookCollection.selectTotalBookList", no);
	}

	@Override
	public int insertBook(Map<String, Object> param) {
		return session.insert("bookCollection.insertBook", param);
	}

}
