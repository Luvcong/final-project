package com.kh.porong.notice.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.notice.model.vo.Notice;
import com.kh.porong.notice.model.vo.NoticeAttachment;
import com.kh.porong.reply.model.vo.Reply;

@Repository
public class NoticeDao {
	
	// ==================================================================================
	// 공지사항 게시판 - 리스트 조회 페이지 관련
	// ==================================================================================

	/**
	 * 1) 공지사항 전체 리스트 조회
	 * @param sqlSession
	 * @param pi
	 * @return 공지사항 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 24
	 */
	public List<Notice> noticeList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("noticeMapper.noticeList", null, rowBounds);
	}	// noticeList
	
	/**
	 * 2) 공지사항 리스트 전체 개수 조회
	 * @param sqlSession
	 * @return 공지사항 전체 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 24
	 */
	public int noticeListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.noticeListCount");
	}	// noticeListCount
	
	/**
	 * 3) 공지사항 게시글 검색 리스트 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @param rowBounds
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 반환
	 * @author JH
	 * @Date : 2023. 12. 3
	 */
	public List<Notice> searchNoticeList(SqlSessionTemplate sqlSession, Map<String, Object> map, RowBounds rowBounds) {
		return sqlSession.selectList("noticeMapper.searchNoticeList", map, rowBounds);
	}	// searchNoticeList
	
	/**
	 * 4) 공지사항 게시글 검색 개수 조회
	 * @param sqlSession
	 * @param map - condition(사용자가 선택한 검색 옵션), keyword(사용자가 검색한 키워드명), empNo(현재 로그인한 사용자의 사원번호)
	 * @return 사용자가 검색한 키워드와 일치하는 개수 반환
	 * @author JH
	 * @Date : 2023. 12. 3
	 */
	public int searchNoticeCount(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("noticeMapper.searchNoticeCount", map);
	}	// searchNoticeCount
	
	// ==================================================================================
	// 공지사항 게시판 - 작성 페이지 관련
	// ==================================================================================
	
	/**
	 * 1) 공지사항 작성
	 * @param sqlSession
	 * @param n 공지사항 VO 객체
	 * @return 공지사항 작성 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	public int insertNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("noticeMapper.insertNotice", n);
	}	// insertNotice
	
	
	/**
	 * 2) 공지사항 작성 - 첨부파일
	 * @param sqlSession
	 * @param at 첨부파일 VO 객체
	 * @return 공지사항 작성시 첨부파일 추가 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	public int insertAttachment(SqlSessionTemplate sqlSession, NoticeAttachment attach) {
		return sqlSession.insert("noticeMapper.insertAttachment", attach);
	}	// insertAttachment
	
	
	// ==================================================================================
	// 공지사항 게시판 - 상세보기 페이지 관련
	// ==================================================================================
	
	/**
	 * 1) 공지사항 상세보기
	 * @param sqlSession
	 * @param map - empNo(로그인한 사용자의 사원번호), noticeNo(공지사항 번호)
	 * @return 공지사항 번호에 해당하는 상세 글 정보 반환
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	public List<Notice> detailNotice(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
		return sqlSession.selectList("noticeMapper.detailNotice", map);
	}	// detailNotice
	
	/**
	 * 2) 공지사항 게시글 첨부파일 상세조회
	 * @param sqlSession
	 * @param noticeNo - 공지사항 번호
	 * @return 공지사항 번호에 해당하는 첨부파일 정보 반환
	 * @author JH
	 * @Date : 2023. 12. 1
	 */
	public List<NoticeAttachment> selectAttachment(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectList("noticeMapper.selectAttachment", noticeNo);
	}	// selectAttachment

	/**
	 * 3) 공지사항 좋아요 여부 체크
	 * @param sqlSession
	 * @param map - empNo(로그인한 사용자의 사원번호), noticeNo(공지사항 번호)
	 * @return 로그인한 사용자가 해당 게시글 번호에 좋아요를 했는지에 대한 체크 여부 (1: 좋아요O / 0: 좋아요X)
	 * @author JH
	 * @Date : 2023. 11. 29
	 */
	public int checkNoticeLike(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
		return sqlSession.selectOne("noticeMapper.checkNoticeLike", map);
	}	// noticeLikeCheck
	
	/**
	 * 4) 공지사항 좋아요 취소(삭제)
	 * @param sqlSession
	 * @param map - empNo(로그인한 사용자의 사원번호), noticeNo(공지사항 번호), getLike(좋아요 유무 - Y : 좋아요 상태 / N : 좋아요 미상태)
	 * @return 좋아요 취소 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 30
	 */
	public int deleteNoticeLike(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.delete("noticeMapper.deleteNoticeLike", map);
	}	// deleteNoticeLike
	
	/**
	 * 5) 공지사항 좋아요 추가
	 * @param sqlSession
	 * @param map - empNo(로그인한 사용자의 사원번호), noticeNo(공지사항 번호), getLike(좋아요 유무 - Y : 좋아요 상태 / N : 좋아요 미상태)
	 * @return 좋아요 추가 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 30
	 */
	public int insertNoticeLike(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.insert("noticeMapper.insertNoticeLike", map);
	}	// insertNoticeLike
	
	/**
	 * 6) 공지사항 조회수 증가
	 * @param sqlSession
	 * @param noticeNo - 조회 수 증가하는 공지사항 게시글 번호
	 * @return 조회수 증가 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 30
	 */
	public int increaseCount(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.increaseCount", noticeNo);
	}	// increaseCount
	
	/**
	 * 7) 공지사항 게시글 수정
	 * @param sqlSession
	 * @param n - 공지사항 VO 객체
	 * @return
	 * @author JH
	 * @Date : 2023. 12. 1
	 */
	public int updateNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.update("noticeMapper.updateNotice", n);
	}	// updateNotice
	
	/**
	 * 8) 공지사항 게시글 첨부파일 수정
	 * @param sqlSession
	 * @param attach - 첨부파일 VO 객체
	 * @return
	 * @author JH
	 * @Date : 2023. 12. 1
	 */
	public int updateAttachment(SqlSessionTemplate sqlSession, NoticeAttachment attach) {
		return sqlSession.update("noticeMapper.updateAttachment", attach);
	}	// updateAttachment
	
	/**
	 * 9) 공지사항 게시글 삭제
	 * @param sqlSession
	 * @param map - empNo(로그인한 사용자의 사원번호), noticeNo(공지사항 번호), changeFileName(첨부되어 있는 파일명), noticeFileNo(첨부파일SEQ)
	 * @return 공지사항 번호에 해당하는 글 삭제 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 30
	 */
	public int deleteNotice(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
		return sqlSession.update("noticeMapper.deleteNotice", map);
	}	// deleteNotice
	
	/**
	 * 10) 공지사항 게시글 첨부파일 삭제
	 * @param sqlSession
	 * @param map - empNo(로그인한 사용자의 사원번호), noticeNo(공지사항 번호), changeFileName(첨부되어 있는 파일명), noticeFileNo(첨부파일SEQ)
	 * @return 공지사항 번호에 해당하는 글의 첨부파일 삭제 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 30
	 */
	public int deleteNoticeAttach(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
		return sqlSession.delete("noticeMapper.deleteNoticeAttach", map);
	}	// deleteNoticeAttach
	
	/**
	 * 11) 공지사항 게시글 댓글 리스트 조회
	 * @param sqlSession
	 * @param noticeNo : 공지사항 게시글 번호
	 * @return 공지사항 게시글 번호에 해당하는 댓글 리스트 반환
	 * @author JH
	 * @Date : 2023. 12. 2
	 */
	public List<Reply> selectReplyList(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectList("noticeMapper.selectReplyList", noticeNo);
	}	// selectReplyList
	
	/**
	 * 12) 공지사항 게시글 댓글 작성
	 * @param sqlSession
	 * @param r : reply VO 객체
	 * @return 공지사항 댓글 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 12. 2
	 */
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("noticeMapper.insertReply", r);
	}	// insertReply
	
	/**
	 * 13) 공지사항 게시글 댓글 삭제
	 * @param sqlSession
	 * @param replyNo : 삭제하려는 댓글 SEQ번호
	 * @return 공지사항 댓글 삭제 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 12. 3
	 */
	public int deleteReply(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.update("noticeMapper.deleteReply", replyNo);
	}	// deleteReply





	
	

}	// end class
