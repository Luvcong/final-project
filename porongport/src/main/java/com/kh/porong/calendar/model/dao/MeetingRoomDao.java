package com.kh.porong.calendar.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.calendar.model.vo.MeetingRoomVO;

@Repository
public class MeetingRoomDao {

	public int insertMeeting(SqlSessionTemplate sqlSession, MeetingRoomVO mr) {
		return sqlSession.insert("meetingRoomMapper.insertMeeting", mr);
	}

	
}
