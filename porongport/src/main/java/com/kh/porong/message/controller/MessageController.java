package com.kh.porong.message.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.common.template.Pagination;
import com.kh.porong.message.model.service.MessageService;

@Controller
public class MessageController {
	
	@Autowired
	private MessageService messageService;
	
	/**
	 * 받은 메시지 전체 리스트 조회
	 * @return 받은 메시지 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 14
	 */
	@RequestMapping("receivedMessage")
	public String receivedMessage(@RequestParam(value="page", defaultValue="1") int currentPage, String condition, String keyword, Model model) {
		
		int listCount = messageService.receivedListCount();
		int boardLimit = 10;
		int pageLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
		
		model.addAttribute("list", messageService.receivedMessageList(pi));
		model.addAttribute("pi", pi);
		
		/*
		 * if(keyword != null) { Map<String, String> map = new HashMap<String,
		 * String>(); map.put("condition", condition);
		 * 
		 * map.put("keyword", keyword);
		 * 
		 * PageInfo keywordPage =
		 * Pagination.getPageInfo(messageService.searchReceivedListCount(map),
		 * currentPage, boardLimit, pageLimit);
		 * 
		 * model.addAttribute("list", messageService.searchReceivedMessage(map,
		 * keywordPage)); model.addAttribute("pi", keywordPage);
		 * model.addAttribute("condition", condition); model.addAttribute("keyword",
		 * keyword); }
		 */
		
		return "message/receivedMessage";
	}	// messageReceived
	
	
	/**
	 * 받은 메시지 검색 조회
	 * @param currentPage : 현재 페이지
	 * @param condition : 검색분류 (발신자/내용)
	 * @param keyword : 사용자가 입력한 검색하고자 하는 키워드 값 (input value)
	 * @param model
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 16
	 */
	@RequestMapping("searchReceivedMessage")
	public String searchReceivedMessage(@RequestParam(value="page", defaultValue="1") int currentPage, String condition, String keyword, Model model) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		PageInfo pi = Pagination.getPageInfo(messageService.searchReceivedListCount(map), currentPage, 10, 10);
		
		model.addAttribute("list", messageService.searchReceivedMessage(map, pi));
		model.addAttribute("pi", pi);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "message/receivedMessage";
	}	// searchReceivedMessage
	
	
	
//	@RequestMapping("storeMessageBox")
//	public String receivedMessageBox(@RequestParam(value="page", defaultValue="1") int currentPage, int messageNo, Model model) {
//		
//		PageInfo pi = Pagination.getPageInfo(messageService.receivedListCount(), currentPage, 10, 10);
//		
//		 model.addAttribute("list", messageService.storeMessage(pi, messageNo));
//
//		return "message/storeMessageBox";
//	}	// receivedMessageBox
	
	
	
	
	
	
	
	

	

}	// end class
