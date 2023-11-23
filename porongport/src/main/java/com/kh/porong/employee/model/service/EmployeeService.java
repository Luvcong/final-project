package com.kh.porong.employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.porong.employee.model.vo.Attendance;
import com.kh.porong.employee.model.vo.Employee;

public interface EmployeeService {
	
	// 로그인
	Employee loginEmp(Employee emp);
	
	// 최초 로그인 판별
	int firstLogin(Employee emp);
	
	// 아이디 중복체크
	int idCheck(int checkId);

	// 비밀번호 찾기
	
	// --- 마이페이지 ---
	// 유저 정보 변경
	int updateEmp(Employee emp);
	
	// 입사자 등록
	int insertEmp(Employee emp);

	
	// --- 근태관련 ---
	// 근태 리스트 조회
	ArrayList<Attendance> attList(int empNo);
	
	// 출근기록 insert
	int insertAtt(Attendance att);
	
	// 근태기록 조회
	Attendance selectAtt(Attendance att);
	
	// 퇴근기록 update
	int updateAtt(Attendance att);

	
	// --- 주소록(조직도) 관련 ---
	// 조직도 조회
	ArrayList<Employee> selectJojigdo(String deptCode);
	
	// 부서 추가
	int insertDept(Employee emp);


}
