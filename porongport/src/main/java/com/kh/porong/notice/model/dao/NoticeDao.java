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

@Repository
public class NoticeDao {
	
	/**
	 * 공지사항 전체 리스트 조회
	 * @param sqlSession
	 * @param pi
	 * @return 공지사항 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 24
	 */
	public ArrayList<Notice> noticeList(SqlSessionTemplate sqlSession, RowBounds rowBounds) {
		return (ArrayList)sqlSession.selectList("noticeMapper.noticeList", null, rowBounds);
	}	// noticeList
	
	/**
	 * 공지사항 리스트 전체 개수 조회
	 * @param sqlSession
	 * @return 공지사항 전체 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 24
	 */
	public int noticeListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.noticeListCount");
	}	// noticeListCount
	
	
	/**
	 * 공지사항 작성
	 * @param sqlSession
	 * @param n
	 * @return 공지사항 작성 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	public int insertNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("noticeMapper.insertNotice", n);
	}	// insertNotice
	
	
	/**
	 * 공지사항 작성 - 첨부파일
	 * @param sqlSession
	 * @param at
	 * @return
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	public int insertAttachment(SqlSessionTemplate sqlSession, NoticeAttachment at) {
		return sqlSession.insert("noticeMapper.insertAttachment", at);
	}	// insertAttachment
	
	
	/**
	 * 공지사항 상세보기
	 * @param sqlSession
	 * @param map
	 * @return
	 * @author JH
	 * @Date : 2023. 11. 27
	 */
	public List<Notice> detailNotice(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectList("noticeMapper.detailNotice", map);
	}	// detailNotice
	
	
	/**
	 * 공지사항 좋아요 여부 체크
	 * @param sqlSession
	 * @param map
	 * @return 로그인한 사용자가 해당 게시글 번호에 좋아요를 했는지에 대한 체크 여부 (1: 좋아요O / 0: 좋아요X)
	 * @author JH
	 * @Date : 2023. 11. 29
	 */
	public int checkLikeNotice(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.selectOne("noticeMapper.checkLikeNotice", map);
	}	// noticeLikeCheck

	
	

}	// end class
