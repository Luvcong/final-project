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
	
	
	// 받은 메시지 전체 리스트 조회
	@Override
	public ArrayList<Message> receivedMessageList(PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.receivedMessageList(sqlSession, rowBounds);
	}	// receivedMessage
	
	
	// 받은 메시지 전체 개수 조회
	@Override
	public int receivedListCount() {
		return messageDao.receivedListCount(sqlSession);
	}	// receivedListCount

	
	// 메시지 작성
	@Override
	public int insertMessage(Message m) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	// 메시지 삭제 - 휴지통 이동
	@Override
	public int deleteMessage(int messageNo) {
		return messageDao.deleteMessage(sqlSession, messageNo);
	}	// deleteMessage

	
	// 메시지 삭제 - 휴지통에서 영구 삭제
	@Override
	public int deletePermanentlyMessage(int messageNo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	// 받은 메시지 보관
	@Override
	public ArrayList<Message> storeMessage(PageInfo pi, int messageNo) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.storeMessage(sqlSession, messageNo, rowBounds);
	}	// storeMessage
	
	
	// 받은 메시지 검색 조회
	@Override
	public ArrayList<Message> searchReceivedMessage(Map<String, String> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return messageDao.searchReceivedMessage(sqlSession, map, rowBounds);
	}	// searchReceivedMessage
	
	
	// 받은 메시지 검색 개수 조회
	@Override
	public int searchReceivedListCount(Map<String, String> map) {
		return messageDao.searchReceivedListCount(sqlSession, map);
	}


	@Override
	public Message detailMessage(int messageNo) {
		// TODO Auto-generated method stub
		return null;
	}

}	// end class
