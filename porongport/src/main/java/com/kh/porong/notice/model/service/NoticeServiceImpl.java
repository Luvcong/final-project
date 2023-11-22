package com.kh.porong.notice.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.notice.model.dao.NoticeDao;
import com.kh.porong.notice.model.vo.Notice;
import com.kh.porong.reply.vo.Reply;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	

	@Override
	public ArrayList<Notice> noticeList(PageInfo pi, int empNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int noticeListCount(int empNo) {
		// TODO Auto-generated method stub
		return 0;
	}

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

	@Override
	public int insertNotice(Notice n) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteNotice(int noticeNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Notice> detailNotice(int noticeNo) {
		// TODO Auto-generated method stub
		return null;
	}

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

}	// end class
