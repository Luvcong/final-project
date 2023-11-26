package com.kh.porong.message.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.employee.model.vo.Employee;
import com.kh.porong.message.model.vo.Message;

public interface MessageService {
	
	// ==================================================================================
	// 메시지함 - 공통 기능
	// ==================================================================================

	// 1) 메시지 북마크 설정
	int bookmarkMsg(Map<String, Object> map);
	
	// 2) 메시지 삭제 - 휴지통 이동
	int deleteMessage(int messageNo);

	// 3) 메시지 보관함 이동
	int storageMessage(int messageNo);
	
	// 4) 메시지 보관함 & 휴지통 > 받은 메시지함으로 이동
	int moveMessageBox(int messageNo);
	
	// 5) 메시지 상세보기
	Message detailMessage(Map<String, Object> map);
	
	// 6) 메시지 작성
	int insertMessage(Message m);
	
	// 7) 메시지 읽음 설정
	int readMsg(Map<String, Object> map);
	
	// 8) 전체 회원 목록 조회
	List<Employee> selectAllEmployee();

	
	// ==================================================================================
	// 메시지함 - 받은 메시지 관련
	// ==================================================================================
	
	// 1) 받은 메시지 전체 리스트 조회
	ArrayList<Message> receivedMessageList(PageInfo pi, int empNo);
	
	// 2) 받은 메시지 전체 개수 조회
	int receivedListCount(int empNo);

	// 3) 메시지 검색 리스트 조회
	ArrayList<Message> searchReceivedMessage(Map<String, Object> map, PageInfo pi);
	
	// 4) 메시지 검색 개수 조회
	int searchReceivedCount(Map<String, Object> map);

	
	// ==================================================================================
	// 메시지함 - 보낸 메시지 관련
	// ==================================================================================
	
	// 1) 받은 메시지 전체 리스트 조회
	ArrayList<Message> sendMessageList(PageInfo pi, int empNo);
	
	// 2) 받은 메시지 전체 개수 조회
	int sendListCount(int empNo);
	
	// 3) 메시지 검색 리스트 조회
	ArrayList<Message> searchSendMessage(Map<String, Object> map, PageInfo pi);
	
	// 4) 메시지 검색 개수 조회
	int searchSendCount(Map<String, Object> map);

	// ==================================================================================
	// 메시지함 - 받은 메시지 보관함 관련
	// ==================================================================================
	
	// 1) 받은 메시지 보관함 전체 리스트 조회
	ArrayList<Message> receivedStorageList(PageInfo pi, int empNo);
	
	// 2) 받은 메시지 보관함 전체 개수 조회
	int receivedStorageCount(int empNo);
	
	// 3) 받은 메시지 보관함 검색 리스트 조회
	ArrayList<Message> searchReceivedStorageMsg(Map<String, Object> map, PageInfo pi);
	
	// 4) 받은 메시지 보관함 검색 개수 조회
	int searchReceivedStorageCount(Map<String, Object> map);
	
	// ==================================================================================
	// 메시지함 - 보낸 메시지 보관함 관련
	// ==================================================================================
	
	// 1) 보낸 메시지 보관함 전체 리스트 조회
	ArrayList<Message> sendStorageList(PageInfo pi, int empNo);
	
	// 2) 보낸 메시지 보관함 전체 개수 조회
	int sendStorageListCount(int empNo);
	
	// 3) 보낸 메시지 보관함 검색 리스트 조회
	ArrayList<Message> searchSendStorageMsg(Map<String, Object> map, PageInfo pi);
	
	// 4) 보낸 메시지 보관함 검색 개수 조회
	int searchSendStorageCount(Map<String, Object> map);
	

	
	// ==================================================================================
	// 메시지함 - 휴지통 관련
	// ==================================================================================
	
	// 1) 휴지통 메시지 전체 리스트 조회
	ArrayList<Message> deleteMessageBoxList(PageInfo pi, int empNo);
	
	// 2) 휴지통 메시지 전체 개수 조회
	int deleteListCount(int empNo);
	
	// 3) 휴지통 메시지 검색 리스트 조회
	ArrayList<Message> searchDeleteMessage(Map<String, Object> map, PageInfo pi);
	
	// 4) 휴지통 메시지 검색 개수 조회
	int searchDeleteListCount(Map<String, Object> map);
	
	// 5) 메시지 영구삭제
	int deletePermanentlyMessage(int messageNo);
	
}	// end class
