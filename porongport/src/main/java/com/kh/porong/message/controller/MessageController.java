package com.kh.porong.message.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.common.template.Pagination;
import com.kh.porong.employee.model.vo.Employee;
import com.kh.porong.message.model.service.MessageService;

@Controller
public class MessageController {
	
	@Autowired
	private MessageService messageService;
	
	
	// ==================================================================================
	// 메시지함 - 받은 메시지 관련
	// ==================================================================================
	
	/**
	 *  받은 메시지 전체 리스트 조회
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 로그인한 회원의 정보
	 * @param model
	 * @return 받은 메시지 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 14
	 */
	@RequestMapping("receivedMessage")
	public String receivedMessage(@RequestParam(value="page", defaultValue="1") int currentPage,
								  @SessionAttribute(name = "loginUser", required = false) Employee loginUser,
								  Model model) {
		
		int empNo = loginUser.getEmpNo();
		int listCount = messageService.receivedListCount(empNo);
		int boardLimit = 10;
		int pageLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
		
		
		model.addAttribute("list", messageService.receivedMessageList(pi, empNo));
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
	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param condition : 검색분류 (이름/직급/내용)
	 * @param keyword : 사용자가 입력한 검색하고자 하는 키워드 값 (input value)
	 * @param model
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 16
	 */
	@RequestMapping("searchReceivedMessage")
	public String searchReceivedMessage(@RequestParam(value="page", defaultValue="1") int currentPage,
										String condition,
										String keyword,
										@SessionAttribute(name = "loginUser", required = false) Employee loginUser,
										Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("empNo", loginUser.getEmpNo());
		
		PageInfo pi = Pagination.getPageInfo(messageService.searchReceivedListCount(map), currentPage, 10, 10);
		
		model.addAttribute("list", messageService.searchReceivedMessage(map, pi));
		model.addAttribute("pi", pi);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "message/receivedMessage";
	}	// searchReceivedMessage
	
	
	// ==================================================================================
	// 메시지함 - 휴지통 관련
	// ==================================================================================
	
	/**
	 * 휴지통 메시지 전체 리스트 조회
	 * @param currentPage : 현재 페이지
 	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param model
	 * @return 휴지통 메시지 전체 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 17
	 */
	@RequestMapping("deleteMessageBox")
	public String deleteMessageBox(@RequestParam(value="page", defaultValue="1") int currentPage,
			 					   @SessionAttribute(name = "loginUser", required = false) Employee loginUser,
			 					   Model model) {
		
		int empNo = loginUser.getEmpNo();
		int listCount = messageService.deleteListCount(empNo);
		int boardLimit = 10;
		int pageLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
		
		model.addAttribute("list", messageService.deleteMessageBoxList(pi, empNo));
		model.addAttribute("pi", pi);
		
		return "message/deleteMessageBox";
	}	// deleteMessageBox
	
	
	/**
	 * 휴지통 메시지 검색 리스트 조회
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param condition : 검색분류 (이름/직급/내용)
	 * @param keyword : 사용자가 입력한 검색하고자 하는 키워드 값 (input value)
	 * @param model
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 반환
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	@RequestMapping("searchDeleteMessage")
	public String searchDeleteMessage(@RequestParam(value="page", defaultValue="1") int currentPage, 
									  @SessionAttribute(name = "loginUser", required = false) Employee loginUser,
									  String condition, String keyword, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("empNo", loginUser.getEmpNo());
		
		PageInfo pi = Pagination.getPageInfo(messageService.searchDeleteListCount(map), currentPage, 10, 10);
		
		model.addAttribute("list", messageService.searchDeleteMessage(map, pi));
		model.addAttribute("pi", pi);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "message/deleteMessageBox";
	}	// searchDeleteMessage
	
	
	
	
	

	

}	// end class
