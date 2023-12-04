package com.kh.porong.approval.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.porong.approval.model.dao.EdmsDao;
import com.kh.porong.approval.model.vo.EdmsLineVO;
import com.kh.porong.approval.model.vo.EdmsVO;
import com.kh.porong.approval.model.vo.GeneralVO;
import com.kh.porong.approval.model.vo.VacationVO;

@Service
public class EdmsServiceImpl implements EdmsService{
	
	@Autowired
	private EdmsDao EdmsDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<EdmsVO> selectEdmsEndList(EdmsVO edms) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<EdmsVO> selectEdmsIngList(EdmsVO edms) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public EdmsVO selectEdmsDetail(EdmsVO edms) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertVacation(VacationVO vacation) {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public ArrayList<VacationVO> selectOrganiztion() {
		return EdmsDao.selectOrganiztion(sqlSession);
	}

	@Override
	public ArrayList<VacationVO> selectOrganiztionChart(String deptName) {
		return EdmsDao.selectOrganiztionChart(sqlSession, deptName);
	}

	@Override
	public ArrayList<VacationVO> selectApprover(String deptName) {
		return EdmsDao.selectApprover(sqlSession, deptName);
	}

	@Override
	public int insertEdms(EdmsVO ed) {
		return EdmsDao.insertEdms(sqlSession, ed);
	}
	
	@Override
	public int insertGeneralDocument(GeneralVO general) {
		return EdmsDao.insertGeneralDocument(sqlSession, general);
	}

	@Override
	public int insertFirstEdmsLine(EdmsLineVO el) {
		return EdmsDao.insertFirstEdmsLine(sqlSession, el);
	}
	
	@Override
	public int insertSecondEdmsLine(EdmsLineVO el) {
		return EdmsDao.insertSecondEdmsLine(sqlSession, el);
	}

	@Override
	public int insertThirdEdmsLine(EdmsLineVO el) {
		return EdmsDao.insertThirdEdmsLine(sqlSession, el);
	}

	@Override
	public int updateEdmsLine(EdmsLineVO el) {
		return EdmsDao.updateEdmsLine(sqlSession, el);
	}





}
