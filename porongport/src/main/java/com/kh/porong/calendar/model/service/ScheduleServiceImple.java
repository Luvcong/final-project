package com.kh.porong.calendar.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.porong.calendar.model.dao.ScheduleDao;
import com.kh.porong.calendar.model.vo.ScheduleVO;

@Service
public class ScheduleServiceImple implements ScheduleService {
	
	@Autowired
	private ScheduleDao scheduleDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<ScheduleVO> selectDepartment(ScheduleVO schedule) {
		return scheduleDao.selectDepartment(sqlSession, schedule);
	}

	@Override
	public ArrayList<ScheduleVO> selectIndividual(ScheduleVO schedule) {
		return scheduleDao.selectIndividual(sqlSession, schedule);
	}

	@Override
	public int insertSchedule(ScheduleVO schedule) {
		return scheduleDao.insertSchedule(sqlSession, schedule);
	}


	@Override
	public int updateSchedule(ScheduleVO schedule) {
		return scheduleDao.updateSchedule(sqlSession, schedule);
	}

	@Override
	public int deleteSchedule(ScheduleVO schedule) {
		return scheduleDao.deleteSchedule(sqlSession, schedule);
	}

}
