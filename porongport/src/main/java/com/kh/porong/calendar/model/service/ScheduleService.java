package com.kh.porong.calendar.model.service;

import java.util.ArrayList;

import com.kh.porong.calendar.model.vo.ScheduleVO;

public interface ScheduleService {
	// -------- 조회 --------
	// 부서 스케줄 조회
	ArrayList<ScheduleVO> selectDepartment(ScheduleVO schedule);
	// 개인 스케줄 조회
	ArrayList<ScheduleVO> selectIndividual(ScheduleVO schedule);
	
	// 스케줄 입력
	int insertSchedule(ScheduleVO schedule);
	
	// 스케줄 수정
	int updateSchedule(ScheduleVO schedule);
	
	// 스케줄 삭제
	int deleteSchedule(ScheduleVO schedule);
	
}
