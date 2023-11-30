package com.kh.porong.employee.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.employee.model.vo.Attachment;
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

	public int insertAtt(SqlSessionTemplate sqlSession, Attendance att) {
		return sqlSession.insert("empMapper.insertAtt", att);
	}

	public ArrayList<Attendance> attList(SqlSessionTemplate sqlSession, int empNo) {
		return (ArrayList)sqlSession.selectList("empMapper.attList", empNo);
	}

	public Attendance selectAtt(SqlSessionTemplate sqlSession, Attendance att) {
		return sqlSession.selectOne("empMapper.selectAtt", att);
	}

	public int updateAtt(SqlSessionTemplate sqlSession, Attendance att) {
		return sqlSession.update("empMapper.updateAtt", att);
	}

	public int idCheck(SqlSessionTemplate sqlSession, int checkId) {
		return sqlSession.selectOne("empMapper.idCheck", checkId);
	}

	public ArrayList<Employee> selectJojigdo(SqlSessionTemplate sqlSession, String deptCode) {
		return (ArrayList)sqlSession.selectList("empMapper.selectJojigdo", deptCode);
	}

	public int firstLogin(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.selectOne("empMapper.firstLogin", emp);
	}
	
	public int updateEmp(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.update("empMapper.updateEmp", emp);
	}

	public int insertDept(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.insert("empMapper.insertDept", emp);
	}

	public int dcCheck(SqlSessionTemplate sqlSession, String checkDc) {
		return sqlSession.selectOne("empMapper.dcCheck", checkDc);
	}

	public int insertProfile(SqlSessionTemplate sqlSession, Attachment profile) {
		return sqlSession.insert("empMapper.insertProfile", profile);
	}

	public Attachment selectProfile(SqlSessionTemplate sqlSession, int refEmpNo) {
		return sqlSession.selectOne("empMapper.selectProfile", refEmpNo);
	}

	public int findPwd(SqlSessionTemplate sqlSession, Employee emp) {
		return sqlSession.update("empMapper.findPwd", emp);
	}

	public int updateProfile(SqlSessionTemplate sqlSession, Attachment profile) {
		return sqlSession.update("empMapper.updateProfile", profile);
	}

	public int pwdAlert(SqlSessionTemplate sqlSession, Map<String, Object> empNo) {
		return sqlSession.selectOne("empMapper.pwdAlert", empNo);
	}

}
