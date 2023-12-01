package com.kh.porong.employee.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.kh.porong.employee.model.dao.EmployeeDao;
import com.kh.porong.employee.model.vo.Attachment;
import com.kh.porong.employee.model.vo.Attendance;
import com.kh.porong.employee.model.vo.Employee;

import lombok.RequiredArgsConstructor;

@Service
@EnableTransactionManagement
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService {
	
	private final EmployeeDao empDao;
	private final SqlSessionTemplate sqlSession;
	
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

	@Override
	public int insertDept(Employee emp) {
		return empDao.insertDept(sqlSession, emp);
	}

	@Override
	public int dcCheck(String checkDc) {
		return empDao.dcCheck(sqlSession, checkDc);
	}

	@Override
	public int insertProfile(Attachment profile) {
		return empDao.insertProfile(sqlSession, profile);
	}

	@Override
	public int updateProfile(Attachment profile) {
		return empDao.updateProfile(sqlSession, profile);
	}

	@Override
	public Attachment selectProfile(int refEmpNo) {
		return empDao.selectProfile(sqlSession, refEmpNo);
	}

	@Override
	public int findPwd(Employee emp) {
		return empDao.findPwd(sqlSession, emp);
	}

	@Override
	public int pwdAlert(Map<String, Object> empNo) {
		return empDao.pwdAlert(sqlSession, empNo);
	}


	

}
