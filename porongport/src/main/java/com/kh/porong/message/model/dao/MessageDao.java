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
	
	// ==================================================================================
	// 메시지함 - 공통 기능
	// ==================================================================================
	
	/**
	 * 받은 메시지 보관함 > 받은 메시지함으로 이동
	 * @param sqlSession
	 * @param messageNo : 보관함에서 받은 메시지함으로 이동하려는 메시지 번호
	 * @return 메시지함 이동 성공 여부 (MESSAGE_STATUS = Y 업데이트 성공 여부)
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public int moveMessageBox(SqlSessionTemplate sqlSession, int messageNo) {
		return sqlSession.update("messageMapper.moveMessageBox", messageNo);
	}	// moveMessageBox
	
	
	
	// ==================================================================================
	// 메시지함 - 받은 메시지 관련
	// ==================================================================================
	
	/**
	 * 1) 받은 메시지 전체 리스트 조회
	 * @param sqlSession
	 * @param rowBounds
	 * @param empNo : 현재 로그인한 사용자의 사원번호
	 * @return 받은 메시지 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 14
	 */
	public ArrayList<Message> receivedMessageList(SqlSessionTemplate sqlSession, int empNo, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.receivedMessageList", empNo, rowBounds);
	}	// receivedMessage
	
	
	/**
	 * 2) 받은 메시지 전체 개수 조회
	 * @param sqlSession
	 * @param empNo : 현재 로그인한 사용자의 사원번호
	 * @return 받은 메시지 전체 개수 반한
	 * @author JH
	 * @Date : 2023. 11. 15
	 */
	public int receivedListCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("messageMapper.receivedListCount", empNo);
	}

	
	/**
	 * 4) 받은 메시지 삭제 - 휴지통 이동
	 * @param messageNo : 휴지통으로 이동하려고 하는 메시지 번호
	 * @return 메시지 삭제 성공 여부 반환
	 * @author JH
	 * @param sqlSession 
	 * @Date : 2023. 11. 16
	 */
	public int deleteMessage(SqlSessionTemplate sqlSession, int messageNo) {
		return sqlSession.update("messageMapper.deleteMessage", messageNo);
	}	// deleteMessage
	
	
	/**
	 * 5) 받은 메시지 검색 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @param rowBounds
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 15
	 */
	public ArrayList<Message> searchReceivedMessage(SqlSessionTemplate sqlSession, Map<String, Object> map, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.searchReceivedMessage", map, rowBounds);
	}
	
	
	/**
	 * 6) 받은 메시지 검색 개수 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @return 사용자가 검색한 키워드와 일치하는 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 15
	 */
	public int searchReceivedListCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("messageMapper.searchReceivedListCount", map);
	}	// searchReceivedListCount
	
	
	/**
	 * 7) 받은 메시지 북마크 설정
	 * @param sqlSession
	 * @param messageNo : 북마크 설정하려고 하는 메시지 번호
	 * @return 받은 메시지 북마크 설정 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 19
	 */
	public int bookmarkMsg(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("messageMapper.bookmarkMsg", map);
	}	// bookmarkMsg
	
	
	/**
	 * 8) 받은 메시지 보관함 이동
	 * @param sqlSession
	 * @param messageNo : 메시지 보관함으로 이동하려는 메시지 번호
	 * @return 보관함 이동 성공 여부 (MESSAGE_STATUS = S 업데이트 성공 여부)
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public int storageMessage(SqlSessionTemplate sqlSession, int messageNo) {
		return sqlSession.update("messageMapper.storageMessage", messageNo);
	}	// storageMessage

	
	// ==================================================================================
	// 메시지함 - 받은 메시지 보관함 관련
	// ==================================================================================
	
	/**
	 * 1) 받은 메시지 보관함 전체 리스트 조회
	 * @param sqlSession
	 * @param empNo : 현재 로그인한 사용자의 사원번호
	 * @param rowBounds
	 * @return 받은 메시지 보관함 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public ArrayList<Message> receivedStorageList(SqlSessionTemplate sqlSession, int empNo, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.receivedStorageList", empNo, rowBounds);
	}	// receivedStorageList

	
	/**
	 * 2) 받은 메시지 보관함 전체 개수 조회
	 * @param empNo : 현재 로그인한 사용자의 사원번호
	 * @return 받은 메시지 전체 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public int receivedStorageListCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("messageMapper.receivedStorageListCount", empNo);
	}	// receivedStorageListCount
	
	
	/**
	 * 3) 받은 메시지 보관함 검색 리스트 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @param rowBounds
	 * @return 받은 메시지 보관함 검색 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public ArrayList<Message> searchReceivedStorageMessage(SqlSessionTemplate sqlSession, Map<String, Object> map, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.searchReceivedStorageMessage", map, rowBounds);
	}	// searchReceivedStorageListCount

	
	/**
	 * 4) 받은 메시지 보관함 검색 개수 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @return 받은 메시지 보관함 검색 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public int searchReceivedStorageListCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("messageMapper.searchReceivedStorageListCount", map);
	}	// searchReceivedStorageListCount


	// ==================================================================================
	// 메시지함 - 휴지통 관련
	// ==================================================================================
	
	/**
	 * 1) 휴지통 메시지 전체 리스트 조회
	 * @param sqlSession
	 * @param pi
	 * @return 휴지통 전체 리스트 반환 (MESSAGE_STATUS = N)
	 * @author JH
	 * @Date : 2023. 11. 17
	 */
	public ArrayList<Message> deleteMessageBoxList(SqlSessionTemplate sqlSession, int empNo, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.deleteMessageBoxList", empNo, rowBounds);
	}	// deleteMessageBoxList
	

	/**
	 * 2) 휴지통 메시지 전체 개수 조회
	 * @param sqlSession
	 * @return 휴지통 전체 리스트 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 17
	 */
	public int deleteListCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("messageMapper.deleteListCount", empNo);
	}	// deleteListCount
	
	
	/**
	 * 3) 휴지통 메시지 검색 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명)
	 * @param rowBounds
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 17
	 */
	public ArrayList<Message> searchDeleteMessage(SqlSessionTemplate sqlSession, Map<String, Object> map, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.searchDeleteMessage", map, rowBounds);
	}	// searchDeleteMessage
	
	
	/**
	 * 4) 휴지통 메시지 검색 개수 조회
	 * @param sqlSession
	 * @return 사용자가 검색한 키워드와 일치하는 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 17
	 */
	public int searchDeleteListCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("messageMapper.searchDeleteListCount", map);	
	}	// searchDeleteListCount

	
	/**
	 * 5) 휴지통 메시지 영구 삭제
	 * @param sqlSession
	 * @param messageNo : 영구 삭제 하려고 하는 메시지 번호
	 * @return 영구 삭제 성공 여부 반환 (DELETE)
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public int deletePermanentlyMessage(SqlSessionTemplate sqlSession, int messageNo) {
		return sqlSession.delete("messageMapper.deletePermanentlyMessage", messageNo);
	}	// deletePermanentlyMessage

	





	
	
	
	
	
	
	
	

}	// end class