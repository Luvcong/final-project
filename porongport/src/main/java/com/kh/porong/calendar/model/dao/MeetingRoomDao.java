package com.kh.porong.calendar.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
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

	public ArrayList<MeetingRoomVO> timeCheck(SqlSessionTemplate sqlSession, String checkTime, String checkTimes) {
		return (ArrayList)sqlSession.selectList("meetingRoomMapper.timeCheck");
	}

	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("meetingRoomMapper.selectListCount");
	}

	public ArrayList<MeetingRoomVO> selectList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("meetingRoomMapper.selectList", null, rowBounds);
	}

	public int dbtimeCheck(SqlSessionTemplate sqlSession, String checkId) {
		return sqlSession.selectOne("meetingRoomMapper.dbtimeCheck",checkId);
	}

	public MeetingRoomVO selectDetailApprovalList(SqlSessionTemplate sqlSession, int mno) {
		return null;
	}

	public MeetingRoomVO selectDetailReservation(SqlSessionTemplate sqlSession, int mno) {
		return sqlSession.selectOne("meetingRoomMapper.selectDetailReservation", mno);
		
	}
	public int updatemeet(SqlSessionTemplate sqlSession, int mno) {
		return sqlSession.update("meetingRoomMapper.updatemeet", mno);
	}
	
	public int notupdatemeet(SqlSessionTemplate sqlSession, int mno) {
		return sqlSession.update("meetingRoomMapper.notupdatemeet", mno);
	}

	public ArrayList<MeetingRoomVO> selectTopMeet(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("meetingRoomMapper.selectTopMeet");
	}

	
	
}
