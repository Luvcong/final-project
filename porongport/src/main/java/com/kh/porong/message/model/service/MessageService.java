package com.kh.porong.message.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.message.model.vo.Message;

public interface MessageService {
	
	// 받은 메시지 전체 리스트 조회
	ArrayList<Message> receivedMessageList(PageInfo pi, int empNo);
	
	// 받은 메시지 전체 개수 조회
	int receivedListCount(int empNo);
	
	// 메시지 작성
	int insertMessage(Message m);
	
	// 메시지 상세보기
	Message detailMessage(int messageNo);
	
	// 메시지 삭제 - 휴지통 이동
	int deleteMessage(int messageNo);
	
	// 메시지 영구삭제
	int deletePermanentlyMessage(int messageNo);
	
	// 메시지 보관
	ArrayList<Message> storeMessage(PageInfo pi, int messageNo);
	
	// 메시지 검색 리스트 조회
	ArrayList<Message> searchReceivedMessage(Map<String, Object> map, PageInfo pi);

	// 메시지 검색 개수 조회
	int searchReceivedListCount(Map<String, Object> map);
	
	// 휴지통 메시지 전체 리스트 조회
	ArrayList<Message> deleteMessageBoxList(PageInfo pi);
	
	// 휴지통 메시지 전체 개수 조회
	int deleteListCount();
	
	// 휴지통 메시지 검색 리스트 조회
	ArrayList<Message> searchDeleteMessage(Map<String, String> map, PageInfo pi);
	
	// 휴지통 메시지 검색 개수 조회
	int searchDeleteListCount(Map<String, String> map);
	
}	// end class
