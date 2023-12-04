package com.kh.porong.approval.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.porong.approval.model.vo.EdmsLineVO;
import com.kh.porong.approval.model.vo.EdmsVO;
import com.kh.porong.approval.model.vo.GeneralVO;
import com.kh.porong.approval.model.vo.VacationVO;
import com.kh.porong.employee.model.vo.Employee;

public interface EdmsService {
	
	// 결재중인 서류 리스트 조회
	ArrayList<EdmsVO> selectEdmsEndList(EdmsVO edms);
	
	// 결재서류 리스트 조회
	ArrayList<EdmsVO> selectEdmsIngList(EdmsVO edms);
	
	// ---------결재서류 상세보기-------
	// 휴가신청서 상세보기
	EdmsVO selectEdmsDetail(EdmsVO edms);
	
	// --------결재서류 등록----------
	// 휴가신청서 등록
	int insertVacation(VacationVO vacation);
	
	ArrayList<VacationVO> selectOrganiztionChart(String deptName);
	
	ArrayList<VacationVO> selectOrganiztion();
	
	ArrayList<VacationVO> selectApprover(String deptName);
	
	int insertEdms(EdmsVO ed);
	
	int insertGeneralDocument(GeneralVO general);

	int insertFirstEdmsLine(EdmsLineVO el);
	int insertSecondEdmsLine(EdmsLineVO el);
	int insertThirdEdmsLine(EdmsLineVO el);
	
	int updateEdmsLine(EdmsLineVO el);
	


}
