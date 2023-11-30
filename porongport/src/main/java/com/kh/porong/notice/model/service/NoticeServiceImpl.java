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
	
	
	// 공지사항 전체 리스트 조회
	@Override
	public ArrayList<Notice> noticeList(PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return noticeDao.noticeList(sqlSession, rowBounds);
	}	// noticeList
	
	// 공지사항 리스트 전체 개수 조회
	@Override
	public int noticeListCount() {
		return noticeDao.noticeListCount(sqlSession);
	}	// noticeListCount

	@Override
	public ArrayList<Notice> searchNoticeList(Map<String, Object> map, PageInfo pi) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int searchNoticeCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	// 공지사항 작성
	@Override
	public int insertNotice(Notice n) {
		
		
		return noticeDao.insertNotice(sqlSession, n);
	}	// insertNotice
	
	
	// 공지사항 작성 - 첨부파일
	@Override
	public int insertAttachment(NoticeAttachment at) {
		
		
		return noticeDao.insertAttachment(sqlSession, at);
	}	// insertAttachment
	
	@Override
	public int deleteNotice(int noticeNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	// 공지사항 상세보기
	@Override
	public List<Notice> detailNotice(Map<String, Object> map) {
		return noticeDao.detailNotice(sqlSession, map);
	}	// detailNotice

	
	@Override
	public int increaseCount(int noticeNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int likeCount(int noticeNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateNotice(int noticeNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Reply> selectReplyList(int noticeNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Reply> insertReply(Reply r) {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 공지사항 게시글 좋아요 여부 체크
	@Override
	public int checkNoticeLike(Map<String, Object> map) {
		return noticeDao.checkNoticeLike(sqlSession, map);
	}	// noticeLikeCheck

	
	// 공지사항 게시글 좋아요 취소(삭제)
	@Override
	public int deleteNoticeLike(Map<String, Object> map) {
		return noticeDao.deleteNoticeLike(sqlSession, map);
	}	// deleteNoticeLike
	
	// 공지사항 게시글 좋아요 추가
	@Override
	public int insertNoticeLike(Map<String, Object> map) {
		return noticeDao.insertNoticeLike(sqlSession, map);
	}	// insertNoticeLike


}	// end class
