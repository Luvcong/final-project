package com.kh.porong.notice.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.notice.model.vo.Notice;

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
	
	
	public int insertNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("notice-mapper.insertNotice", n);
	}	// insertNotice

	
	

}	// end class
