package com.kh.porong.employee.model.service;

import java.util.ArrayList;

import com.kh.porong.employee.model.vo.Attendance;
import com.kh.porong.employee.model.vo.Employee;

public interface EmployeeService {
	

	// 로그인
	Employee loginEmp(Employee emp);
	
	// 출근기록 리스트
	ArrayList<Attendance> attList(int empNo);
	
	// 출근기록 조회
	Attendance checkAtt(int empNo);
	
	// 출근기록 insert
	int insertAtt(Attendance att);
	
	// 마지막 출근기록 조회
	Attendance selectAtt(Attendance att);
	
	// 퇴근기록 update
	int updateAtt(Attendance att);

	// 입사자 등록
	int insertEmp(Employee emp);
	
	// 아이디 중복체크
	int idCheck(int checkId);
	
	// 비밀번호 찾기
	
	// 조직도 조회
	ArrayList<Employee> selectJojigdo(String deptCode);
	
	


}
