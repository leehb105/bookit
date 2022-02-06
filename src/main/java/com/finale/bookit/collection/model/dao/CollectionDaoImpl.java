package com.finale.bookit.collection.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.collection.model.vo.BookCollection;

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
	public List<BookCollection> selectCollectionDetail(int no) {
		return session.selectList("bookCollection.selectCollectionDetail", no);
	}

	@Override
	public int collectionDetailDelete(String no) {
		return session.delete("bookCollection.collectionDetailDelete", no);
	}

	@Override
	public int selectTotalCollection() {
		return session.selectOne("bookCollection.selectTotalCollection");
	}

}
