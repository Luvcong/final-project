package com.kh.porong.calendar.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.porong.calendar.model.dao.MeetingRoomDao;
import com.kh.porong.calendar.model.vo.MeetingRoomVO;
import com.kh.porong.common.model.vo.PageInfo;

@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {

	@Autowired
	private MeetingRoomDao MeetingRoomDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<MeetingRoomVO> selectMeetingRoomList(MeetingRoomVO room) {
		return MeetingRoomDao.selectMeetingRoomList(sqlSession,room);
	}

	@Override
	public int insertMeetingRoom(MeetingRoomVO mr) {
		return MeetingRoomDao.insertMeeting(sqlSession,mr);
	}
	
	@Override
	public ArrayList<MeetingRoomVO> timeCheck(String checkTime, String checkTimes) {
		return MeetingRoomDao.timeCheck(sqlSession, checkTime, checkTimes) ;
	}
	
	@Override
	public int dbtimeCheck(String checkId) {
		return MeetingRoomDao.dbtimeCheck(sqlSession, checkId);
	}
	
	@Override
	public MeetingRoomVO selectDetailMeetingRoom(MeetingRoomVO room) {
		return null;
	}

	@Override
	public ArrayList<MeetingRoomVO> selectReservationList(MeetingRoomVO room) {
		return null;
	}

	@Override
	public ArrayList<MeetingRoomVO> selectApprovalList(MeetingRoomVO room) {
		return null;
	}

	@Override
	public MeetingRoomVO selectDetailReservation(int mno) {
		return MeetingRoomDao.selectDetailReservation(sqlSession, mno);
	}

	@Override
	public MeetingRoomVO selectDetailApprovalList(MeetingRoomVO room) {
		return null;
	}

	@Override
	public int updateAccept(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateRejection(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateCancel(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int selectListCount() {
		return MeetingRoomDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<MeetingRoomVO> selectList(PageInfo pi) {
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return MeetingRoomDao.selectList(sqlSession, rowBounds);
	}

	@Override
	public int updatemeet(int mno) {
		return MeetingRoomDao.updatemeet(sqlSession,mno);
	}

	@Override
	public int notupdatemeet(int mno) {
		return MeetingRoomDao.notupdatemeet(sqlSession,mno);
	}

	@Override
	public ArrayList<MeetingRoomVO> selectTopMeet() {
		return MeetingRoomDao.selectTopMeet(sqlSession);
	}



	






}
