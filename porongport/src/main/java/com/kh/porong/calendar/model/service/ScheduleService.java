package com.kh.porong.calendar.model.service;

import java.util.ArrayList;

import com.kh.porong.calendar.model.vo.ScheduleVO;

public interface ScheduleService {
	// -------- 조회 --------
	// 부서 스케줄 조회
	ArrayList<ScheduleVO> selectDepartment(ScheduleVO schedule);
	// 개인 스케줄 조회
	ArrayList<ScheduleVO> selectIndividual(ScheduleVO schedule);
	
	// 스케줄 디테일뷰
	ScheduleVO selectDatilView(ScheduleVO schedule);
	
	// -------- 입력--------
	// 부서스케줄 입력
	int insertDepartment(ScheduleVO schedule);
	
	// 개인스케줄 입력
	int insertIndividual(ScheduleVO schedule);
	
	// -------- 수정 --------
	// 부서 스케줄 수정
	int updateDepartment(ScheduleVO schedule);
	
	// 개인 스케줄 수정
	int updateIndividual(ScheduleVO schedule);
	
	// -------- 삭제 --------
	// 부서 스케줄 삭제
	int deleteDepartment(ScheduleVO schedule);
	
	// 개인 스케줄 삭제
	int deleteIndividual(ScheduleVO schedule);
}
