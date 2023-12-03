package com.kh.porong.message.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.kh.porong.common.controller.IFileHandler;
import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.common.template.Pagination;
import com.kh.porong.employee.model.vo.Employee;
import com.kh.porong.message.model.service.MessageService;
import com.kh.porong.message.model.vo.Message;

@Controller
public class MessageController implements IFileHandler {
	
	@Autowired
	private MessageService messageService;
	
	// ==================================================================================
	// 메시지함 - 공통 기능
	// ==================================================================================
	
	/**
	 * 1) 받은 메시지 상세보기
	 * @param mno : 메시지 상세보기 메시지 번호 - MESSAGE_NO
	 * @param model
	 * @return MESSAGE_NO 에 해당하는 일자, 작성자, 직급, 메시지내용, 첨부파일 반환
	 * @author JH
	 * @Date : 2023. 11. 21
	 */
	@RequestMapping("detailMessage")
	public String detailMessage(int mno,
								@SessionAttribute(name="loginUser", required=false) Employee loginUser,
								Model model) {
		
		int empNo = loginUser.getEmpNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("messageNo", mno);
		
		Message m = messageService.detailMessage(map);
		
		if(m.getReadYN().equals("N")){
			map.put("readYN", "Y");
			messageService.readMsg(map);
		}
		
		model.addAttribute("list", m);
		model.addAttribute("userList", messageService.selectAllEmployee());
		
		// System.out.println("messageDetailmessgeNo : " + mno);
		return "message/detailMessage";
	}	// detailMessage
	
	
	/**
	 * 메시지 작성하기
	 * @param m
	 * @param upfile
	 * @param session
	 * @param model
	 * @return
	 * @author JH
	 * @Date : 2023. 11. 23
	 */
	@RequestMapping("insertMessage")
	public String insertMessage(Message m,
								MultipartFile upfile,
								HttpSession session) {
		
//		System.out.println(m);
//		System.out.println(upfile);
//		System.out.println(upfile.getOriginalFilename());
		// m.setSendUser(loginUser.getEmpNo());
		
		if(!upfile.getOriginalFilename().equals("")) {
			m.setOriginFileName(upfile.getOriginalFilename());
			m.setChangeFileName(saveFile(upfile, session, "message/"));
		}
		
		if(messageService.insertMessage(m) > 0){
			session.setAttribute("successMsg", "메시지 전송에 성공했습니다!");
		} else {
			session.setAttribute("failMsg", "메시지 전송에 실패했습니다");
		}
		return "redirect:receivedMessage";
	}	// insertMessage
	
	
	
	
	
	// ==================================================================================
	// 메시지함 - 받은 메시지 관련
	// ==================================================================================
	
	/**
	 *  1) 받은 메시지 전체 리스트 및 개수 조회
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 로그인한 회원의 정보
	 * @param model
	 * @return 받은 메시지 전체 리스트 및 개수 반환
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
		model.addAttribute("userList", messageService.selectAllEmployee());
		
		
		return "message/receivedMessage";
	}	// messageReceived
	
	
	/**
	 * 2) 받은 메시지 검색 및 개수 조회
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param condition : 검색분류 (이름/직급/부서/내용)
	 * @param keyword : 사용자가 입력한 검색하고자 하는 키워드 값 (input value)
	 * @param model
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 및 개수 반환
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
		
		// System.out.println(map);
		
		PageInfo pi = Pagination.getPageInfo(messageService.searchReceivedCount(map), currentPage, 10, 10);
		
		model.addAttribute("list", messageService.searchReceivedMessage(map, pi));
		model.addAttribute("pi", pi);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "message/receivedMessage";
	}	// searchReceivedMessage
	
	
	// ==================================================================================
	// 메시지함 - 받은 메시지 보관함 관련
	// ==================================================================================
	
	/**
	 * 1) 받은 메시지 보관함 전체 리스트 및 개수 조회
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param model
	 * @return 받은 메시지 보관함 전체 리스트 및 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	@RequestMapping("receivedStorageMessage")
	public String receivedStorageMessage(@RequestParam(value="page", defaultValue="1") int currentPage,
			 					   		 @SessionAttribute(name= "loginUser", required= false) Employee loginUser,
			 					   		 Model model) {
		
		int empNo = loginUser.getEmpNo();
		int listCount = messageService.receivedStorageCount(empNo);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		
		
		model.addAttribute("list", messageService.receivedStorageList(pi, empNo));
		model.addAttribute("pi", pi);
		model.addAttribute("userList", messageService.selectAllEmployee());
		
		return "message/receivedStorageMessage";
	}	// receivedStorageMessage
	
	
	/**
	 * 2) 받은 메시지 보관함 검색 리스트 및 개수 조회
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param condition : 검색분류 (이름/직급/부서/내용)
	 * @param keyword : 사용자가 입력한 검색하고자 하는 키워드 값 (input value)
	 * @param model
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 및 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	@RequestMapping("searchReceivedStorageMsg")
	public String searchReceivedStorageMsg(@RequestParam(value="page", defaultValue="1") int currentPage,
											   @SessionAttribute(name="loginUser", required= false) Employee loginUser,
											   String condition,
											   String keyword,
											   Model model){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("empNo", loginUser.getEmpNo());
		
		int listCount = messageService.searchReceivedStorageCount(map);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		
		model.addAttribute("list", messageService.searchReceivedStorageMsg(map, pi));
		model.addAttribute("pi", pi);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "message/receivedStorageMessage";							   
   }	// searchReceiveStoragedMessage
	
	
	// ==================================================================================
	// 메시지함 - 보낸 메시지 관련
	// ==================================================================================
	
	/**
	 * 1) 보낸 메시지 전체 리스트 및 개수 조회
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 로그인한 회원의 정보
	 * @param model
	 * @return 보낸 메시지 전체 리스트 및 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 21
	 */
	@RequestMapping("sendMessage")
	public String sendMessage(@RequestParam(value="page", defaultValue="1") int currentPage,
								  @SessionAttribute(name = "loginUser", required = false) Employee loginUser,
								  Model model) {
		
		int empNo = loginUser.getEmpNo();
		int listCount = messageService.sendListCount(empNo);
		int boardLimit = 10;
		int pageLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);
		
		
		model.addAttribute("list", messageService.sendMessageList(pi, empNo));
		model.addAttribute("pi", pi);
		model.addAttribute("userList", messageService.selectAllEmployee());
		
		return "message/sendMessage";
	}	// sendMessage
		
	
	/**
	 * 2) 보낸 메시지 검색 조회 및 개수 반환
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param condition : 검색분류 (이름/직급/부서/내용)
	 * @param keyword : 사용자가 입력한 검색하고자 하는 키워드 값 (input value)
	 * @param model
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 및 개수 반환
	 * @author JH
	 * @Date : 2023. 11. 21
	 */
	@RequestMapping("searchSendMessage")
	public String searchSendMessage(@RequestParam(value="page", defaultValue="1") int currentPage,
										String condition,
										String keyword,
										@SessionAttribute(name = "loginUser", required = false) Employee loginUser,
										Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("empNo", loginUser.getEmpNo());
		
		PageInfo pi = Pagination.getPageInfo(messageService.searchSendCount(map), currentPage, 10, 10);
		
		model.addAttribute("list", messageService.searchSendMessage(map, pi));
		model.addAttribute("pi", pi);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "message/sendMessage";
	}	// searchSendMessage
	
	
	// ==================================================================================
	// 메시지함 - 보낸 메시지 보관함 관련
	// ==================================================================================
		
		/**
		 * 1) 보낸 메시지 보관함 전체 리스트 및 개수 조회
		 * @param currentPage : 현재 페이지
		 * @param loginUser : 현재 로그인한 회원의 정보
		 * @param model
		 * @return 보낸 메시지 보관함 전체 리스트 및 개수 반환
		 * @author JH
		 * @Date : 2023. 11. 20
		 */
		@RequestMapping("sendStorageMessage")
		public String sendStorageMessage(@RequestParam(value="page", defaultValue="1") int currentPage,
				 					   		 @SessionAttribute(name= "loginUser", required= false) Employee loginUser,
				 					   		 Model model) {
			
			int empNo = loginUser.getEmpNo();
			int listCount = messageService.sendStorageListCount(empNo);
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
			
			
			model.addAttribute("list", messageService.sendStorageList(pi, empNo));
			model.addAttribute("pi", pi);
			model.addAttribute("userList", messageService.selectAllEmployee());
			
			return "message/sendStorageMessage";
		}	// sendStorageMessage
		
		
		/**
		 * 2) 보낸 메시지 보관함 검색 리스트 및 개수 조회
		 * @param currentPage : 현재 페이지
		 * @param loginUser : 현재 로그인한 회원의 정보
		 * @param condition : 검색분류 (이름/직급/부서/내용)
		 * @param keyword : 사용자가 입력한 검색하고자 하는 키워드 값 (input value)
		 * @param model
		 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 및 개수 반환
		 * @author JH
		 * @Date : 2023. 11. 20
		 */
		@RequestMapping("searchSendStorageMsg")
		public String searchSendStorageMsg(@RequestParam(value="page", defaultValue="1") int currentPage,
												   @SessionAttribute(name="loginUser", required= false) Employee loginUser,
												   String condition,
												   String keyword,
												   Model model){
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("condition", condition);
			map.put("keyword", keyword);
			map.put("empNo", loginUser.getEmpNo());
			
			int listCount = messageService.searchSendStorageCount(map);
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
			
			model.addAttribute("list", messageService.searchSendStorageMsg(map, pi));
			model.addAttribute("pi", pi);
			model.addAttribute("condition", condition);
			model.addAttribute("keyword", keyword);
			
			return "message/sendStorageMessage";							   
	   }	// searchSendStoragedMessage
	
	
	// ==================================================================================
	// 메시지함 - 휴지통 관련
	// ==================================================================================
	
	/**
	 * 1) 휴지통 메시지 전체 리스트 및 개수 조회
	 * @param currentPage : 현재 페이지
 	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param model
	 * @return 휴지통 메시지 전체 리스트 및 개수 반환
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
		model.addAttribute("userList", messageService.selectAllEmployee());
		
		return "message/deleteMessageBox";
	}	// deleteMessageBox
	
	
	/**
	 * 2) 휴지통 메시지 검색 리스트 및 개수 조회
	 * @param currentPage : 현재 페이지
	 * @param loginUser : 현재 로그인한 회원의 정보
	 * @param condition : 검색분류 (이름/직급/부서/내용)
	 * @param keyword : 사용자가 입력한 검색하고자 하는 키워드 값 (input value)
	 * @param model
	 * @return 사용자가 검색한 키워드와 일치하는 조건의 리스트 및 개수 반환
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
