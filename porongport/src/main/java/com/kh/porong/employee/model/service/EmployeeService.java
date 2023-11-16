package com.kh.porong.employee.model.service;

import com.kh.porong.employee.model.vo.Employee;

public interface EmployeeService {
	
	// 로그인
	Employee loginEmp(Employee emp);
	
	// 비밀번호 찾기(+메일 인증)
	
	// 입사자 등록
	int insertEmp(Employee emp);

}
