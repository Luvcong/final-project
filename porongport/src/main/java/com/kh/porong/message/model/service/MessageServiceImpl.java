package com.kh.porong.message.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.employee.model.vo.Employee;
import com.kh.porong.message.model.dao.MessageDao;
import com.kh.porong.message.model.vo.Message;

@Service
@EnableTransactionManagement
public class MessageServiceImpl implements MessageService {
	
	@Autowired
	private MessageDao messageDao;;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// ==================================================================================
	// 메시지함 - 공통 기능
	// ==================================================================================
	
	// 1) 받은 메시지 북마크 설정
	@Override
	public int bookmarkMsg(Map<String, Object> map) {
		return messageDao.bookmarkMsg(sqlSession, map);
	}	// bookmarkMsg
	
	// 2) 받은 메시지 - 메시지 삭제(휴지통 이동)
	@Override
	public int deleteMessage(int messageNo) {
		return messageDao.deleteMessage(sqlSession, messageNo);
	}	// deleteMessage
	
	// 3) 메시지 보관함으로 이동
	@Override
	public int storageMessage(int messageNo) {
		return messageDao.storageMessage(sqlSession, messageNo);
	}	// storageMessage
	
	// 4) 메시지 보관함 & 휴지통 > 받은 메시지함으로 이동
	@Override
	public int moveMessageBox(int messageNo) {
		return messageDao.moveMessageBox(sqlSession, messageNo);
	}	// moveMessageBox
	
	// 5) 메시지 상세보기
	@Override
	public Message detailMessage(Map<String, Object> map) {
		return messageDao.detailMessage(sqlSession, map);
	}	// detailMessage
	
	// 6) 메시지 작성
	@Override
	public int insertMessage(Message m) {
		return messageDao.insertMessage(sqlSession, m);
	}	// insertMessage
	
	// 7) 메시지 읽음 설정
	@Override
	public int readMsg(Map<String, Object> map) {
		return messageDao.readMsg(sqlSession, map);
	}	// readMsg
	
	
	// 8) 전체 회원 목록 조회
	@Override
	public List<Employee> selectAllEmployee() {
		return messageDao.selectAllEmployee(sqlSession);
	}	// selectAllEmployee


	
	// ==================================================================================
	// 메시지함 - 받은 메시지 관련
	// ==================================================================================
	
	// 1) 받은 메시지 - 전체 리스트 조회
	@Override
	public ArrayList<Message> receivedMessageList(PageInfo pi, int empNo) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.receivedMessageList(sqlSession, empNo, rowBounds);
	}	// receivedMessage
	
	
	// 2) 받은 메시지 - 전체 개수 조회
	@Override
	public int receivedListCount(int empNo) {
		return messageDao.receivedListCount(sqlSession, empNo);
	}	// receivedListCount

	
	// 3) 받은 메시지 검색 조회
	@Override
	public ArrayList<Message> searchReceivedMessage(Map<String, Object> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.searchReceivedMessage(sqlSession, map, rowBounds);
	}	// searchReceivedMessage
	
	
	// 4) 받은 메시지 검색 개수 조회
	@Override
	public int searchReceivedCount(Map<String, Object> map) {
		return messageDao.searchReceivedCount(sqlSession, map);
	}
	

	// ==================================================================================
	// 메시지함 - 받은 메시지 보관함 관련
	// ==================================================================================
	
	// 1) 받은 메시지 보관함 전체 리스트 조회
	@Override
	public ArrayList<Message> receivedStorageList(PageInfo pi, int empNo) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.receivedStorageList(sqlSession, empNo, rowBounds);
	}	// receivedStorageList

	
	// 2) 받은 메시지 보관함 전체 개수 조회
	@Override
	public int receivedStorageCount(int empNo) {
		return messageDao.receivedStorageCount(sqlSession, empNo);
	}	// storageListCount

	
	// 3) 받은 메시지 보관함 검색 리스트 조회
	@Override
	public ArrayList<Message> searchReceivedStorageMsg(Map<String, Object> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.searchReceivedStorageMsg(sqlSession, map, rowBounds);
	}	// searchReceivedStorageMessage
	
	
	// 4) 받은 메시지 보관함 검색 개수 조회
	@Override
	public int searchReceivedStorageCount(Map<String, Object> map) {
		return messageDao.searchReceivedStorageCount(sqlSession, map);
	}	// searchReceivedStorageListCount
	

	// ==================================================================================
	// 메시지함 - 보낸 메시지 관련
	// ==================================================================================
	
	// 1) 보낸 메시지 리스트 전체 조회
	@Override
	public ArrayList<Message> sendMessageList(PageInfo pi, int empNo) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.sendMessageList(sqlSession, empNo, rowBounds);
	}	// sendMessageList

	
	// 2) 보낸 메시지 리스트 개수 조회
	@Override
	public int sendListCount(int empNo) {
		return messageDao.sendListCount(sqlSession, empNo);
	}	// sendListCount

	
	// 3) 보낸 메시지 검색 조회
	@Override
	public ArrayList<Message> searchSendMessage(Map<String, Object> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.searchSendMessage(sqlSession, map, rowBounds);
	}	// searchSendMessage

	
	// 4) 보낸 메시지 검색 개수 조회
	@Override
	public int searchSendCount(Map<String, Object> map) {
		return messageDao.searchSendCount(sqlSession, map);
	}	// searchSenddListCount

	
	// ==================================================================================
	// 메시지함 - 보낸 메시지 보관함 관련
	// ==================================================================================
	
	// 1) 보낸 메시지 보관함 전체 리스트 조회
	@Override
	public ArrayList<Message> sendStorageList(PageInfo pi, int empNo) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.sendStorageList(sqlSession, empNo, rowBounds);
	}	// sendStorageList
	
	// 2) 보낸 메시지 보관함 전체 개수 조회
	@Override
	public int sendStorageListCount(int empNo) {
		return messageDao.sendStorageListCount(sqlSession, empNo);
	}	// sendStorageListCount
	
	// 3) 보낸 메시지 보관함 검색 리스트 조회
	@Override
	public ArrayList<Message> searchSendStorageMsg(Map<String, Object> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.searchSendStorageMsg(sqlSession, map, rowBounds);
	}	// searchSendStorageMessage
	
	// 4) 보낸 메시지 보관함 검색 개수 조회
	@Override
	public int searchSendStorageCount(Map<String, Object> map) {
		return messageDao.searchSendStorageCount(sqlSession, map);
	}	// searchSendStorageListCount
	
	
	// ==================================================================================
	// 메시지함 - 휴지통 관련
	// ==================================================================================
	
	// 1) 휴지통 메시지 전체 리스트 조회
	@Override
	public ArrayList<Message> deleteMessageBoxList(PageInfo pi, int empNo) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.deleteMessageBoxList(sqlSession, empNo, rowBounds);
	}	// deleteMessageBoxList
	
	
	// 2) 휴지통 메시지 전체 개수 조회
	@Override
	public int deleteListCount(int empNo) {
		return messageDao.deleteListCount(sqlSession, empNo);
	}	// deleteListCount
	
	
	// 3) 휴지통 메시지 검색 조회
	@Override
	public ArrayList<Message> searchDeleteMessage(Map<String, Object> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.searchDeleteMessage(sqlSession, map, rowBounds);
	}	// searchDeleteMessage
	
	
	// 4) 휴지통 메시지 검색 개수 조회
	@Override
	public int searchDeleteListCount(Map<String, Object> map) {
		return messageDao.searchDeleteListCount(sqlSession, map);
	}	// searchDeleteListCount
	
	
	// 5) 휴지통 메시지 영구 삭제
	@Override
	public int deletePermanentlyMessage(int messageNo) {
		return messageDao.deletePermanentlyMessage(sqlSession, messageNo);
	}	// deletePermanentlyMessage



}	// end class
