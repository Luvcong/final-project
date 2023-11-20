package com.kh.porong.message.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.kh.porong.common.model.vo.PageInfo;
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
	
	// 1) 받은 메시지 보관함 / 휴지통 > 받은 메시지함으로 이동
	@Override
	public int moveMessageBox(int messageNo) {
		return messageDao.moveMessageBox(sqlSession, messageNo);
	}	// moveMessageBox

	
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

	
	// 3) 받은 메시지 - 메시지 작성
	@Override
	public int insertMessage(Message m) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	// 4) 받은 메시지 - 메시지 삭제(휴지통 이동)
	@Override
	public int deleteMessage(int messageNo) {
		return messageDao.deleteMessage(sqlSession, messageNo);
	}	// deleteMessage
	
	
	// 5) 받은 메시지 검색 조회
	@Override
	public ArrayList<Message> searchReceivedMessage(Map<String, Object> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.searchReceivedMessage(sqlSession, map, rowBounds);
	}	// searchReceivedMessage
	
	
	// 6) 받은 메시지 검색 개수 조회
	@Override
	public int searchReceivedListCount(Map<String, Object> map) {
		return messageDao.searchReceivedListCount(sqlSession, map);
	}
	
	
	// 7) 받은 메시지 북마크 설정
	@Override
	public int bookmarkMsg(Map<String, Object> map) {
		return messageDao.bookmarkMsg(sqlSession, map);
	}	// bookmarkMsg
	
	
	// 8) 받은 메시지 보관함 이동
	@Override
	public int storageMessage(int messageNo) {
		return messageDao.storageMessage(sqlSession, messageNo);
	}	// storageMessage
	
	
	
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
	public int receivedStorageListCount(int empNo) {
		return messageDao.receivedStorageListCount(sqlSession, empNo);
	}	// storageListCount

	
	// 3) 받은 메시지 보관함 검색 리스트 조회
	@Override
	public ArrayList<Message> searchReceivedStorageMessage(Map<String, Object> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.searchReceivedStorageMessage(sqlSession, map, rowBounds);
	}	// searchReceivedStorageMessage
	
	
	// 4) 받은 메시지 보관함 검색 개수 조회
	@Override
	public int searchReceivedStorageListCount(Map<String, Object> map) {
		return messageDao.searchReceivedStorageListCount(sqlSession, map);
	}	// searchReceivedStorageListCount
	

	
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
	
	

	
	
	
	
	@Override
	public Message detailMessage(int messageNo) {
		// TODO Auto-generated method stub
		return null;
	}









}	// end class
