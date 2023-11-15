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
		return null;
	}

	@Override
	public int insertMeetingRoom(MeetingRoomVO mr) {
		return 0;
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
	public int updateAccept(String schStatus) {
		return 0;
	}

	@Override
	public int updateRejection(String schStatus) {
		return 0;
	}

	@Override
	public int updateCancel(String schStatus) {
		return 0;
	}

	@Override
	public MeetingRoomVO selectDetailMeetingRoom(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MeetingRoomVO selectDetailReservation(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MeetingRoomVO selectDetailApprovalList(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MeetingRoomVO selectDetailApproval(MeetingRoomVO room) {
		// TODO Auto-generated method stub
		return null;
	}



}
