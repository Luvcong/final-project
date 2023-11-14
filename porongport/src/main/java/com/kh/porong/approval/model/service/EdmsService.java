package com.kh.porong.approval.model.service;

import java.util.ArrayList;

import com.kh.porong.approval.model.vo.EdmsVO;
import com.kh.porong.approval.model.vo.VacationVO;

public interface EdmsService {
	
	// 결재중인 서류 리스트 조회
	ArrayList<EdmsVO> selectEdmsEndList(EdmsVO edms);
	
	// 결재서류 리스트 조회
	ArrayList<EdmsVO> selectEdmsIngList(EdmsVO edms);
	
	// ---------결재서류 상세보기-------
	// 휴가신청서 상세보기
	EdmsVO selectEdmsDetail(EdmsVO edms);
	
	// 지출결의서 상세보기
	
	// 인사발령서 상세보기
	
	// 출장보고서 상세보기
	
	// --------결재서류 등록----------
	// 휴가신청서 등록
	int insertVacation(VacationVO vacation);
	// 지출결의서 등록 
	
	// 인사발령서 등록
	
	// 출장보고서 등록
	
	
	// ---------결재상태------------
	// 결재승인
	
	// 결재반려

}
