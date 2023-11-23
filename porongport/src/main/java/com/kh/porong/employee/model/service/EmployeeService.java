package com.kh.porong.employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.porong.employee.model.vo.Attendance;
import com.kh.porong.employee.model.vo.Employee;

public interface EmployeeService {
	

	// 로그인
	Employee loginEmp(Employee emp);
	// 근태 리스트 조회
	ArrayList<Attendance> attList(int empNo);
	// 최초 로그인 판별
	int firstLogin(Employee emp);
	
	// 최초 로그인 판별 후 update
	
	
	// 출근기록 insert
	int insertAtt(Attendance att);
	// 근태기록 조회
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
	
	// 유저 정보 update
	int updateEmp(Employee emp);


}
