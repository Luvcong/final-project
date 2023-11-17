package com.kh.porong.calendar.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.calendar.model.vo.ScheduleVO;

@Repository
public class ScheduleDao {
	
	public int insertIndividual(SqlSessionTemplate sqlSession, ScheduleVO schedule) {
		return sqlSession.insert("scheduleMapper.insertIndividual", schedule);
	}

	public int insertDepartment(SqlSessionTemplate sqlSession, ScheduleVO schedule) {
		return sqlSession.insert("scheduleMapper.insertDepartment", schedule);
	}


}
