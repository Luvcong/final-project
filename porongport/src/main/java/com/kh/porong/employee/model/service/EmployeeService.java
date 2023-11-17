package com.kh.porong.employee.model.service;

import java.util.ArrayList;

import com.kh.porong.employee.model.vo.Attendance;
import com.kh.porong.employee.model.vo.Employee;

public interface EmployeeService {
	

	// 로그인
	Employee loginEmp(Employee emp);
	
	// 출근기록 리스트
	ArrayList<Attendance> attList(int empNo);
	
	// 출근기록 insert
	int insertAtt(Attendance att);
	
	// 출근기록 select
	Attendance selectAtt(Attendance att);
	
	// 퇴근기록 update
	int updateAtt(Attendance att);
	
	// 입사자 등록
	int insertEmp(Employee emp);
	
	// 비밀번호 찾기(+메일 인증)
	


}
