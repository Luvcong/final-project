package com.kh.porong.message.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.employee.model.vo.Employee;
import com.kh.porong.message.model.vo.Message;

@Repository
public class MessageDao {
	
	// ==================================================================================
	// 메시지함 - 공통 기능
	// ==================================================================================
	
	/**
	 * 1) 메시지 북마크 설정
	 * @param sqlSession
	 * @param map - messageNo(북마크 설정하려고 하는 메시지 번호), bookmarkYN(북마크 유무 여부)
	 * @return 메시지 북마크 설정 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 19
	 */
	public int bookmarkMsg(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("messageMapper.bookmarkMsg", map);
	}	// bookmarkMsg
	
	
	/**
	 * 2) 받은 메시지 삭제 - 휴지통 이동
	 * @param messageNo : 휴지통으로 이동하려고 하는 메시지 번호
	 * @return 삭제 성공 여부 반환
	 * @author JH
	 * @param sqlSession 
	 * @Date : 2023. 11. 16
	 */
	public int deleteMessage(SqlSessionTemplate sqlSession, int messageNo) {
		return sqlSession.update("messageMapper.deleteMessage", messageNo);
	}	// deleteMessage
	
	
	/**
	 * 3) 메시지 보관함으로 이동
	 * @param sqlSession
	 * @param messageNo : 메시지 보관함으로 이동하려는 메시지 번호
	 * @return 보관함 이동 성공 여부 (MESSAGE_STATUS = S 업데이트 성공 여부)
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public int storageMessage(SqlSessionTemplate sqlSession, int messageNo) {
		return sqlSession.update("messageMapper.storageMessage", messageNo);
	}	// storageMessage
	
	
	/**
	 * 4) 메시지 보관함 & 휴지통 메시지 > 기존 메시지함으로 이동
	 * @param sqlSession
	 * @param messageList : 보관함 및 휴지통 메시지를 기존 메시지함으로 이동하려는 메시지 번호
	 * @return 메시지함 이동 성공 여부 (MESSAGE_STATUS = Y 업데이트 성공 여부)
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public int moveMessageBox(SqlSessionTemplate sqlSession, int messageNo) {
		return sqlSession.update("messageMapper.moveMessageBox", messageNo);
	}	// moveMessageBox
	
	
	/**
	 * 5) 받은 메시지 상세보기
	 * @param sqlSession
	 * @param messageNo : 메시지 상세보기 메시지 번호 - MESSAGE_NO
	 * @return MESSAGE_NO 에 해당하는 일자, 작성자, 직급, 메시지내용 반환
	 * @author JH
	 * @Date : 2023. 11. 21
	 */
	public Message detailMessage(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("messageMapper.detailMessage", map);
	}	// detailMessage
	
	
	/**
	 * 6) 메시지 작성
	 * @param sqlSession
	 * @param m
	 * @return
	 * @author JH
	 * @Date : 2023. 11. 23
	 */
	public int insertMessage(SqlSessionTemplate sqlSession, Message m) {
		return sqlSession.insert("messageMapper.insertMessage", m);
	}	// insertMessage
	
	
	/**
	 * 7) 메시지 읽음 설정
	 * @param sqlSession
	 * @param map - messageNo(읽음 메시지 번호), bookmarkYN(읽음 유무 여부)
	 * @return 메시지 읽음 설정 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 23
	 */
	public int readMsg(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.update("messageMapper.readMsg", map);
	}	// readMsg

	
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
	 * 3) 받은 메시지 검색 조회
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
	 * 4) 받은 메시지 검색 개수 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @return 사용자가 검색한 키워드와 일치하는 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 15
	 */
	public int searchReceivedCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("messageMapper.searchReceivedCount", map);
	}	// searchReceivedListCount


	
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
	public int receivedStorageCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("messageMapper.receivedStorageCount", empNo);
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
	public ArrayList<Message> searchReceivedStorageMsg(SqlSessionTemplate sqlSession, Map<String, Object> map, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.searchReceivedStorageMsg", map, rowBounds);
	}	// searchReceivedStorageListCount

	
	/**
	 * 4) 받은 메시지 보관함 검색 개수 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @return 받은 메시지 보관함 검색 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	public int searchReceivedStorageCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("messageMapper.searchReceivedStorageCount", map);
	}	// searchReceivedStorageListCount

	
	// ==================================================================================
	// 메시지함 - 보낸 메시지 관련
	// ==================================================================================
	
	/**
	 * 1) 보낸 메시지 전체 리스트 조회
	 * @param sqlSession
	 * @param empNo : 현재 로그인한 사용자의 사원번호
	 * @param rowBounds
	 * @return 보낸 메시지 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 21
	 */
	public ArrayList<Message> sendMessageList(SqlSessionTemplate sqlSession, int empNo, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.sendMessageList", empNo, rowBounds);
	}	// sendMessageList

	
	/**
	 * 2) 보낸 메시지 전체 개수 조회
	 * @param empNo : 현재 로그인한 사용자의 사원번호
	 * @return 보낸 메시지 전채 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 21
	 */
	public int sendListCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("messageMapper.sendListCount", empNo);
	}	// sendListCount

	
	/**
	 * 3) 보낸 메시지 검색 리스트 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @param rowBounds
	 * @return 보낸 메시지 검색 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 21
	 */
	public ArrayList<Message> searchSendMessage(SqlSessionTemplate sqlSession, Map<String, Object> map,
			RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.searchSendMessage", map);
	}	// searchSendMessage

	
	/**
	 * 4) 보낸 메시지 검색 리스트 개수 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @return 보낸 메시지 검색 리스트 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 21
	 */
	public int searchSendCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("messageMapper.searchSendCount", map);
	}	// searchSendListCount
	
	
	// ==================================================================================
	// 메시지함 - 보낸 메시지 보관함 관련
	// ==================================================================================
	
	/**
	 * 1) 보낸 메시지 보관함 전체 리스트 조회
	 * @param sqlSession
	 * @param empNo : 현재 로그인한 사용자의 사원번호
	 * @param rowBounds
	 * @return 보낸 메시지 보관함 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 22
	 */
	public ArrayList<Message> sendStorageList(SqlSessionTemplate sqlSession, int empNo, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.sendStorageList", empNo, rowBounds);
	}	// sendStorageList

	
	/**
	 * 2) 보낸 메시지 보관함 전체 개수 조회
	 * @param sqlSession
	 * @param empNo : 현재 로그인한 사용자의 사원번호
	 * @return 보낸 메시지 보관함 전체 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 22
	 */
	public int sendStorageListCount(SqlSessionTemplate sqlSession, int empNo) {
		return sqlSession.selectOne("messageMapper.sendStorageListCount", empNo);
	}	// sendStorageListCount

	
	/**
	 * 3) 보낸 메시지 보관함 검색 리스트 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @param rowBounds
	 * @return 보낸 메시지 보관함 검색 개수 반환
//	 * @author JH
	 * @Date : 2023. 11. 22
	 */
	public ArrayList<Message> searchSendStorageMsg(SqlSessionTemplate sqlSession, Map<String, Object> map,
			RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("messageMapper.searchSendStorageMsg", map, rowBounds);
	}	// searchSendStorageMessage

	
	/**
	 * 4) 보낸 메시지 보관함 검색 개수 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @return 보낸 메시지 보관함 검색 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 22
	 */
	public int searchSendStorageCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("messageMapper.searchSendStorageCount", map);
	}	// searchSendStorageListCount


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


	public List<Employee> selectAllEmployee(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("messageMapper.selectAllEmployee");
	}	// selectAllEmployee



	


	





	
	
	
	
	
	
	
	

}	// end class