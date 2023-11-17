package com.kh.porong.employee.model.service;

import java.util.Map;

import com.kh.porong.employee.model.vo.Employee;

public interface EmployeeService {
	

	// 로그인
	Employee loginEmp(Employee emp);
	// 로그인 즉시, 근태테이블 insert
	void workToday(Map<String, Object> workToday);
	
	// 입사자 등록
	int insertEmp(Employee emp);
	
	// 비밀번호 찾기(+메일 인증)
	


}
