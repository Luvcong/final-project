package com.kh.porong.notice.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.notice.model.dao.NoticeDao;
import com.kh.porong.notice.model.vo.Notice;
import com.kh.porong.notice.model.vo.NoticeAttachment;
import com.kh.porong.reply.vo.Reply;

@Service
@EnableTransactionManagement
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// ==================================================================================
	// 공지사항 게시판 - 리스트 조회 페이지 관련
	// ==================================================================================
	
	// 1) 공지사항 전체 리스트 조회
	@Override
	public ArrayList<Notice> noticeList(PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return noticeDao.noticeList(sqlSession, rowBounds);
	}	// noticeList
	
	// 2) 공지사항 리스트 전체 개수 조회
	@Override
	public int noticeListCount() {
		return noticeDao.noticeListCount(sqlSession);
	}	// noticeListCount
	
	// 공지사항 게시글 검색 리스트 조회
	@Override
	public ArrayList<Notice> searchNoticeList(Map<String, Object> map, PageInfo pi) {
		// TODO Auto-generated method stub
		return null;
	}

	// 공지사항 게시글 검색 개수 조회
	@Override
	public int searchNoticeCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	// ==================================================================================
	// 공지사항 게시판 - 작성 페이지 관련
	// ==================================================================================
	
	// 1) 공지사항 게시글 작성
	@Override
	public int insertNotice(Notice n) {
		return noticeDao.insertNotice(sqlSession, n);
	}	// insertNotice
	
	
	// 2) 공지사항 게시글 작성 - 첨부파일 추가
	@Override
	public int insertAttachment(NoticeAttachment at) {
		return noticeDao.insertAttachment(sqlSession, at);
	}	// insertAttachment
	
	
	// ==================================================================================
	// 공지사항 게시판 - 상세보기 페이지 관련
	// ==================================================================================
		
	// 1) 공지사항 게시글 상세보기
	@Override
	public List<Notice> detailNotice(Map<String, Object> map) {
		return noticeDao.detailNotice(sqlSession, map);
	}	// detailNotice

	// 2) 공지사항 게시글 좋아요 여부 체크
	@Override
	public int checkNoticeLike(Map<String, Object> map) {
		return noticeDao.checkNoticeLike(sqlSession, map);
	}	// noticeLikeCheck

	// 3) 공지사항 게시글 좋아요 취소(삭제)
	@Override
	public int deleteNoticeLike(Map<String, Object> map) {
		return noticeDao.deleteNoticeLike(sqlSession, map);
	}	// deleteNoticeLike
	
	// 4) 공지사항 게시글 좋아요 추가
	@Override
	public int insertNoticeLike(Map<String, Object> map) {
		return noticeDao.insertNoticeLike(sqlSession, map);
	}	// insertNoticeLike
	
	// 5) 공지사항 게시글 조회 수 증가
	@Override
	public int increaseCount(int noticeNo) {
		return noticeDao.increaseCount(sqlSession, noticeNo);
	}	// increaseCount

	// 공지사항 게시글 수정
	@Override
	public int updateNotice(int noticeNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 7) 공지사항 게시글 삭제
	@Override
	public int deleteNotice(Map<String, Object> map) {
		return noticeDao.deleteNotice(sqlSession, map);
	}	// deleteNotice
	
	// 8) 공지사항 게시글 첨부파일 삭제
	@Override
	public int deleteNoticeAttach(Map<String, Object> map) {
		return noticeDao.deleteNoticeAttach(sqlSession, map);
	}	// deleteNoticeAttach

	// 공지사항 게시글 댓글 리스트 조회
	@Override
	public ArrayList<Reply> selectReplyList(int noticeNo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 공지사항 게시글 댓글 작성
	@Override
	public ArrayList<Reply> insertReply(Reply r) {
		// TODO Auto-generated method stub
		return null;
	}


	
}	// end class
