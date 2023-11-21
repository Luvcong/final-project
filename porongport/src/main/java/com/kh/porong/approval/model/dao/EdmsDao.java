package com.kh.porong.approval.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.approval.model.vo.VacationVO;

@Repository
public class EdmsDao {

	public ArrayList<VacationVO> selectOrganiztionChart(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectOrganiztionChart");
	}

}
