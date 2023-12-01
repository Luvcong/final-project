package com.kh.porong.notice.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.notice.model.vo.Notice;
import com.kh.porong.notice.model.vo.NoticeAttachment;
import com.kh.porong.reply.vo.Reply;

public interface NoticeService {
	
	// ==================================================================================
	// 공지사항 게시판 - 리스트 조회 페이지 관련
	// ==================================================================================
	
	// 1) 공지사항 게시글 전체 리스트 조회
	ArrayList<Notice> noticeList(PageInfo pi);
	
	// 2) 공지사항 게시글 전체 개수 조회
	int noticeListCount();
	
	// 공지사항 게시글 검색 리스트 조회
	ArrayList<Notice> searchNoticeList(Map<String, Object> map, PageInfo pi);
	
	// 공지사항 게시글 검색 개수 조회
	int searchNoticeCount(Map<String, Object> map);
	
	
	// ==================================================================================
	// 공지사항 게시판 - 작성 페이지 관련
	// ==================================================================================
	
	// 1) 공지사항 게시글 작성
	int insertNotice(Notice n);
	
	// 2) 공지사항 게시글 작성 - 첨부파일 추가
	int insertAttachment(NoticeAttachment at);
	
	
	// ==================================================================================
	// 공지사항 게시판 - 상세보기 페이지 관련
	// ==================================================================================
	
	// 1) 공지사항 게시글 상세보기
	List<Notice> detailNotice(Map<String, Integer> map);
	
	// 2) 공지사항 게시글 좋아요 여부 체크
	int checkNoticeLike(Map<String, Integer> map);
	
	// 3) 공지사항 게시글 좋아요 취소
	int deleteNoticeLike(Map<String, Object> map);
	
	// 4) 공지사항 게시글 좋아요 추가
	int insertNoticeLike(Map<String, Object> map);
	
	// 5) 공지사항 게시글 조회 수 증가
	int increaseCount(int noticeNo);
	
	// 공지사항 게시글 수정
	int updateNotice(int noticeNo);
	
	// 7) 공지사항 게시글 삭제
	int deleteNotice(Map<String, Integer> map);
	
	// 8) 공지사항 게시글 첨부파일 삭제
	int deleteNoticeAttach(Map<String, Integer> map);
	
	// 공지사항 게시글 댓글 리스트 조회
	ArrayList<Reply> selectReplyList(int noticeNo);
	
	// 공지사항 게시글 댓글 작성
	ArrayList<Reply> insertReply(Reply r);
	
}	// end class
