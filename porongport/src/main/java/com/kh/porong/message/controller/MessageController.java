package com.kh.porong.message.controller;

import java.util.HashMap;
import java.util.Map;

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
	 * @return 
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
		
		if(keyword != null) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("condition", condition);
			
			map.put("keyword", keyword);
			
			PageInfo keywordPage = Pagination.getPageInfo(messageService.searchReceivedListCount(map), currentPage, boardLimit, pageLimit);
			
			model.addAttribute("list", messageService.searchReceivedMessage(map, keywordPage));
			model.addAttribute("pi", keywordPage);
			model.addAttribute("condition", condition);
			model.addAttribute("keyword", keyword);
		}
		
		
		return "message/receivedMessage";
	}	// messageReceived
	
	
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
	
	
	
	
	
	@RequestMapping("storeMessageBox")
	public String receivedMessageBox(@RequestParam(value="page", defaultValue="1") int currentPage, int messageNo, Model model) {
		
		PageInfo pi = Pagination.getPageInfo(messageService.receivedListCount(), currentPage, 10, 10);
		
		 model.addAttribute("list", messageService.storeMessage(pi, messageNo));

		 
		 
		
		
		return "message/storeMessageBox";
	}	// receivedMessageBox
	
	
	
	
	
	
	
	

	

}	// end class
