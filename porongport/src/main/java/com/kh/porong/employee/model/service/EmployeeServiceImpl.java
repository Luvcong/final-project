package com.kh.porong.employee.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.kh.porong.employee.model.dao.EmployeeDao;
import com.kh.porong.employee.model.vo.Attendance;
import com.kh.porong.employee.model.vo.Employee;

@EnableTransactionManagement
@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired
	private EmployeeDao empDao;

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Employee loginEmp(Employee emp) {
		return empDao.loginEmp(sqlSession, emp);
	}

	@Override
	public int insertEmp(Employee emp) {
		return empDao.insertEmp(sqlSession, emp);
	}

	@Override
	public void workToday(Attendance att) {
		empDao.workToday(sqlSession, att);
	}

	

}
