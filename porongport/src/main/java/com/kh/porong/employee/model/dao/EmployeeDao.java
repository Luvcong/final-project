package com.kh.porong.employee.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

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

	public Attendance checkAtt(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("empMapper.checkAtt", map);
	}

	public ArrayList<Employee> selectJojigdo(SqlSessionTemplate sqlSession, String deptCode) {
		return (ArrayList)sqlSession.selectList("empMapper.selectJojigdo", deptCode);
	}
	

}
