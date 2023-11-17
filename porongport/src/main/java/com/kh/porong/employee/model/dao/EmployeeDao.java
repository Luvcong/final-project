package com.kh.porong.employee.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.employee.model.vo.Attendance;
import com.kh.porong.employee.model.vo.Employee;

@Repository
public class EmployeeDao {
	
	public Employee loginEmp(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.selectOne("empMapper.loginEmp", emp);
	}

	public int insertEmp(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.insert("empMapper.insertEmp", emp);
	}

	public void workToday(SqlSessionTemplate sqlSession, Attendance att) {
		sqlSession.insert("empMapper.workToday", att);
	}
	

}
