package com.kh.porong.calendar.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.calendar.model.vo.MeetingRoomVO;

@Repository
public class MeetingRoomDao {

	public int insertMeeting(SqlSessionTemplate sqlSession, MeetingRoomVO mr) {
		return sqlSession.insert("meetingRoomMapper.insertMeeting", mr);
	}

	public ArrayList<MeetingRoomVO> selectMeetingRoomList(SqlSessionTemplate sqlSession, MeetingRoomVO room) {
		return (ArrayList)sqlSession.selectList("meetingRoomMapper.selectMeetingRoomList", room);
	}

	
}
