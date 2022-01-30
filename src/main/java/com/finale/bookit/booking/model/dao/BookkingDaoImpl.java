package com.finale.bookit.booking.model.dao;

import com.finale.bookit.booking.model.vo.Booking;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BookkingDaoImpl implements BookingDao{
    @Autowired
    private SqlSessionTemplate session;

    @Override
    public int selectTotalBookingCount() {
        return session.selectOne("booking.selectTotalBookingCount");
    }

    @Override
    public List<Booking> selectBookInfo(Map<String, Object> param) {
        return session.selectList("booking.selectBookInfo", param);
    }
}
