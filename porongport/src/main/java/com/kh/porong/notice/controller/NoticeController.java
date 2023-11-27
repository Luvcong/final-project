package com.kh.porong.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.common.template.Pagination;
import com.kh.porong.notice.model.service.NoticeService;
import com.kh.porong.notice.model.vo.Notice;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	
	/**
	 * 공지사항 리스트 전체 리스트 및 개수 조회
	 * @return 공지사항 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 24
	 */
	@RequestMapping("notice")
	public String noticeList(@RequestParam(value="page", defaultValue="1") int currentPage, Model model) {
		
		int listCount = noticeService.noticeListCount();
		int boardLimit = 10;
		int pageLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
		
		
		model.addAttribute("list", noticeService.noticeList(pi));
		model.addAttribute("pi", pi);
		
		return "notice/noticeList";
	}	// noticeList
	
	
	/**
	 * 공지사항 작성 (empAdmin == 'A' 인 사원만 작성 가능)
	 * @return 공지사항 작성 성공 여부 반환
	 * @author JH
	 * @Date : 2023. 11. 24
	 */
	@GetMapping("noticeWrite")
	public String noticeWrite_ck(Notice n, Model model) {
		return "notice/insertNotice";
	}
	

}	// end class
