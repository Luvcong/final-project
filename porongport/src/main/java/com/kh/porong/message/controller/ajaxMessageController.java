package com.kh.porong.message.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.kh.porong.employee.model.vo.Employee;
import com.kh.porong.message.model.service.MessageService;

@Controller
public class ajaxMessageController {
	
	@Autowired
	private MessageService messageService;
	
	
	// ==================================================================================
	// 메시지함 - 받은 메시지 관련
	// ==================================================================================
	
	/**
	 * 메시지 삭제 - 휴지통 이동
	 * @param messageNoList : 삭제하려고 하는 메시지 번호 (messageNo)
	 * @return 메시지 삭제 성공 여부 (MESSAGE_STATUS = N 으로 변경 완료 여부) 반환
	 * @author JH
	 * @Date : 2023. 11. 16
	 */
	@ResponseBody
	@GetMapping(value="deleteMessage", produces="application/json; charset=UTF-8")
	public String deleteMessage(@RequestParam(value="messageNoList[]") ArrayList<String> messageNoList) {
		
		JsonArray deleteList = new JsonArray();
		
		for(String arr : messageNoList) {
			int messageNo = Integer.parseInt(arr);
			int result = messageService.deleteMessage(messageNo);
			if(result > 0)
				deleteList.add(messageNo);
		}
		return new Gson().toJson(deleteList);
	}	// deleteMessage
	
	/**
	 * 메시지 북마크 설정
	 * @param messageNo : 북마크하려고 하는 메시지 번호
	 * @param bookmarkYN : 선택한 메시지 번호의 북마크 설정 유무 여부 (Y : 북마크 설정 / N : 북마크 미설정)
	 * @return 메시지 북마크 설정 성공 여부
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	@ResponseBody
	@GetMapping("bookmarkMsg")
	public boolean bookmarkMsg(int messageNo, boolean bookmarkYN) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("messageNo", messageNo);
		map.put("bookmarkYN", bookmarkYN ? "N" : "Y");
		// System.out.println(bookmarkYN ? "N" : "Y");
		messageService.bookmarkMsg(map);
		
		return !bookmarkYN;
	}	// bookmarkMsg
	
	/**
	 * 받은 메시지 보관함 이동
	 * @param messageList : 메시지 보관함으로 이동하려는 메시지 번호
	 * @return 보관함 이동 성공 여부 (MESSAGE_STATUS = S 업데이트 성공 여부)
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	@ResponseBody
	@GetMapping(value="receivedStorageMessage", produces="application/json; charset=UTF-8")
	public String receivedStorageMessage(@RequestParam(value="messageList[]") ArrayList<String> messageList) {
		
		JsonArray storageList = new JsonArray();
		
		for(String arr : messageList) {
			int messageNo = Integer.parseInt(arr);
			int result = messageService.storageMessage(messageNo);
				if(result > 0)
					storageList.add(messageNo);
		}
		return new Gson().toJson(storageList);
	}	// storeMessage
	
	
	
	
	

}	// end class
