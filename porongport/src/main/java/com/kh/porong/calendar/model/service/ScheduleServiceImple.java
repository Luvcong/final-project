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
		return null;
	}

	@Override
	public ArrayList<ScheduleVO> selectIndividual(ScheduleVO schedule) {
		return null;
	}

	@Override
	public int insertDepartment(ScheduleVO schedule) {
		return 0;
	}

	@Override
	public int insertIndividual(ScheduleVO schedule) {
		return 0;
	}

	@Override
	public int updateDepartment(ScheduleVO schedule) {
		return 0;
	}

	@Override
	public int updateIndividual(ScheduleVO schedule) {
		return 0;
	}

	@Override
	public int deleteDepartment(ScheduleVO schedule) {
		return 0;
	}

	@Override
	public int deleteIndividual(ScheduleVO schedule) {
		// TODO Auto-generated method stub
		return 0;
	}

}