package com.kh.porong.employee.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.employee.model.vo.Employee;

@Repository
public class EmployeeDao {
	
	public Employee loginEmp(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.selectOne("empMapper.loginEmp", emp);
	}

	public int insertEmp(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.insert("empMapper.insertEmp", emp);
	}

	public void workToday(SqlSessionTemplate sqlSession, Map<String, Object> workToday) {
		sqlSession.insert("empMapper.workToday", workToday);
	}
	

}
