package com.kh.porong.calendar.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.porong.calendar.model.dao.MeetingRoomDao;
import com.kh.porong.calendar.model.vo.MeetingRoomVO;

@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {

	@Autowired
	private MeetingRoomDao meetinRoomDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<MeetingRoomVO> selectMeetingRoomList(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertMeetingRoom(MeetingRoomVO mr) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<MeetingRoomVO> selectReservationList(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<MeetingRoomVO> selectApprovalList(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateAccept(String schStatus) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateRejection(String schStatus) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateCancel(String schStatus) {
		// TODO Auto-generated method stub
		return 0;
	}

}
