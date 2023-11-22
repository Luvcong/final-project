package com.kh.porong.approval.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.porong.approval.model.dao.EdmsDao;
import com.kh.porong.approval.model.vo.EdmsVO;
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
	public ArrayList<VacationVO> selectOrganiztionChart() {

		return EdmsDao.selectOrganiztionChart(sqlSession);
	}

	@Override
	public ArrayList<VacationVO> selectOrganiztion() {
		return EdmsDao.selectOrganiztion(sqlSession);
	}



}
