package com.kh.porong.approval.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.approval.model.vo.EdmsLineVO;
import com.kh.porong.approval.model.vo.EdmsVO;
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
	
	public int insertEdms(SqlSessionTemplate sqlSession, EdmsVO ed) {
		return sqlSession.insert("approvalMapper.insertEdms", ed);
	}
	
	public int insertGeneralDocument(SqlSessionTemplate sqlSession, GeneralVO general) {
		return sqlSession.insert("approvalMapper.insertGeneralDocument", general);
	}
	
	public int insertFirstEdmsLine(SqlSessionTemplate sqlSession, EdmsLineVO el) {
		return sqlSession.insert("approvalMapper.insertFirstEdmsLine", el);
	}
	
	public int insertSecondEdmsLine(SqlSessionTemplate sqlSession, EdmsLineVO el) {
		return sqlSession.insert("approvalMapper.insertSecondEdmsLine", el);
	}
	
	public int insertThirdEdmsLine(SqlSessionTemplate sqlSession, EdmsLineVO el) {
		return sqlSession.insert("approvalMapper.insertThirdEdmsLine", el);
	}
	
	public int updateEdmsLine(SqlSessionTemplate sqlSession, EdmsLineVO el) {
		return sqlSession.update("approvalMapper.updateEdmsLine", el);
	}
	

}
