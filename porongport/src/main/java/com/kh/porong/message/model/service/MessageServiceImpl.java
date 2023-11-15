package com.kh.porong.message.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.message.model.dao.MessageDao;
import com.kh.porong.message.model.vo.Message;

@Service
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

	
	@Override
	public int insertMessage(Message m) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Message detailMessage(int messageNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateMessage(int messageNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMessage(int messageNo) {
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

}	// end class
