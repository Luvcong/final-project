package com.kh.porong.approval.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.approval.model.vo.GeneralVO;
import com.kh.porong.approval.model.vo.VacationVO;
import com.kh.porong.calendar.model.vo.ScheduleVO;

@Repository
public class EdmsDao {

	public ArrayList<VacationVO> selectOrganiztionChart(SqlSessionTemplate sqlSession, String deptName) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectOrganiztionChart", deptName);
	}

	public ArrayList<VacationVO> selectOrganiztion(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectOrganiztion");
	}
	
	public ArrayList<VacationVO> selectApprover(SqlSessionTemplate sqlSession, String deptName) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectApprover");
	}
	
	public int insertGeneralDocument(SqlSessionTemplate sqlSession, GeneralVO general) {
		return sqlSession.insert("approvalMapper.insertGeneralDocument", general);
	}


}
