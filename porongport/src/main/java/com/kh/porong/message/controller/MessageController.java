package com.kh.porong.message.controller;

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
	public String messageReceived(@RequestParam(value="page", defaultValue="1") int currentPage, Model model) {
		
		int listCount = messageService.receivedListCount();
		int boardLimit = 5;
		int pageLimit = 5;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
		
		model.addAttribute("list", messageService.receivedMessageList(pi));
		model.addAttribute("pi", pi);
		
		return "message/receivedMessage";
	}	// messageReceived

	

}	// end class
