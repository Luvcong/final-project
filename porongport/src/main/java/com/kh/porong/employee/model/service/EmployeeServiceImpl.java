package com.kh.porong.employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;

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
	public int insertAtt(Attendance att) {
		return empDao.insertAtt(sqlSession, att);
	}

	@Override
	public ArrayList<Attendance> attList(int empNo) {
		return empDao.attList(sqlSession, empNo);
	}

	@Override
	public Attendance selectAtt(Attendance att) {
		return empDao.selectAtt(sqlSession, att);
	}

	@Override
	public int updateAtt(Attendance att) {
		return empDao.updateAtt(sqlSession, att);
	}

	@Override
	public int idCheck(int checkId) {
		return empDao.idCheck(sqlSession, checkId);
	}
	
	@Override
	public ArrayList<Employee> selectJojigdo(String deptCode) {
		return empDao.selectJojigdo(sqlSession, deptCode);
	}

	@Override
	public int firstLogin(Employee emp) {
		return empDao.firstLogin(sqlSession, emp);
	}

	@Override
	public int updateEmp(Employee emp) {
		return empDao.updateEmp(sqlSession, emp);
	}

	

}
