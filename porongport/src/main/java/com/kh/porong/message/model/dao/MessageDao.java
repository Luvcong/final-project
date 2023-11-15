package com.kh.porong.message.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

}	// end class
