package com.kh.porong.message.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.message.model.vo.Message;

@Repository
public class MessageDao {
	
	
	/**
	 * 받은 메시지 전체 리스트 조회
	 * @param sqlSession
	 * @param rowBounds
	 * @return
	 * @author JH
	 * @Date : 2023. 11. 14
	 */
	public ArrayList<Message> receivedMessageList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.receivedMessageList", null, rowBounds);
	}	// receivedMessage
	
	
	/**
	 * 받은 메시지 전체 개수 조회
	 * @param sqlSession
	 * @return
	 * @author JH
	 * @Date : 2023. 11. 15
	 */
	public int receivedListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("messageMapper.receivedListCount");
	}

	
	/**
	 * 받은 메시지 검색 조회
	 * @param sqlSession
	 * @param map
	 * @param rowBounds
	 * @return
	 * @author JH
	 * @Date : 2023. 11. 15
	 */
	public ArrayList<Message> searchReceivedMessage(SqlSessionTemplate sqlSession, Map<String, String> map, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.searchReceivedMessage", map, rowBounds);
	}
	
	
	/**
	 * 받은 메시지 검색 개수 조회
	 * @param sqlSession
	 * @param map
	 * @return
	 * @author JH
	 * @Date : 2023. 11. 15
	 */
	public int searchReceivedListCount(SqlSessionTemplate sqlSession, Map<String, String> map) {
		return sqlSession.selectOne("messageMapper.searchReceivedListCount", map);
	}	// searchReceivedListCount
	
	
	
	public ArrayList<Message> storeMessage(SqlSessionTemplate sqlSession, int messageNo, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.store", messageNo, rowBounds);
	}	// storeMessage


	


	
	
	
	
	
	
	
	
	
	
	
	

}	// end class
