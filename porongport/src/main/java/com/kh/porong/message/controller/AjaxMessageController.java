package com.kh.porong.message.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.kh.porong.message.model.service.MessageService;

@Controller
public class AjaxMessageController {
	
	@Autowired
	private MessageService messageService;
	
	// ==================================================================================
	// 메시지함 - 공통 기능
	// ==================================================================================
	
	/**
	 * 1) 메시지 북마크 설정
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
	 * 2) 메시지 삭제 - 휴지통 이동
	 * @param messageNoList : 삭제하려고 하는 메시지 번호 (messageNo)
	 * @return 메시지 삭제 성공 여부 (MESSAGE_STATUS = N 으로 변경 완료 여부) 반환
	 * @author JH
	 * @Date : 2023. 11. 16
	 */
	@ResponseBody
	@GetMapping(value="deleteMessage", produces="application/json; charset=UTF-8")
	public String deleteMessage(@RequestParam(value="messageNoList[]") List<Integer> messageNoList) {
		
		JsonArray deleteList = new JsonArray();
		
		for(int arr : messageNoList) {
			int messageNo = arr;
			int result = messageService.deleteMessage(messageNo);
			if(result > 0)
				deleteList.add(messageNo);
		}
		
		return new Gson().toJson(deleteList);
	}	// deleteMessage
	
	/**
	 * 3) 메시지 보관함으로 이동
	 * @param messageList : 메시지 보관함으로 이동하려는 메시지 번호
	 * @return 보관함 이동 성공 여부 (MESSAGE_STATUS = S 업데이트 성공 여부)
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	@ResponseBody
	@GetMapping(value="storageMessage", produces="application/json; charset=UTF-8")
	public String storageMessage(@RequestParam(value="messageList[]") List<Integer> messageList) {
		
		JsonArray storageList = new JsonArray();
		
		for(int arr : messageList) {
			int messageNo = arr;
			int result = messageService.storageMessage(messageNo);
				if(result > 0)
					storageList.add(messageNo);
		}
		return new Gson().toJson(storageList);
	}	// storeMessage
	
	/**
	 * 4) 메시지 보관함 & 휴지통 메시지 > 기존 메시지함으로 이동
	 * @param messageList : 보관함 및 휴지통 메시지를 기존 메시지함으로 이동하려는 메시지 번호
	 * @return 메시지함 이동 성공 여부 (MESSAGE_STATUS = Y 업데이트 성공 여부)
	 * @author JH
	 * @Date : 2023. 11. 20
	 */
	@ResponseBody
	@GetMapping(value="moveMessageBox", produces="application/json; charset=UTF-8")
	public String moveMessgaeBox(@RequestParam(value="message_list[]") List<Integer> messageList) {
		
		JsonArray moveList = new JsonArray();
		
		for(int arr : messageList) {
			int messageNo = arr;
			int result = messageService.moveMessageBox(messageNo);
				if(result > 0)
					moveList.add(messageNo);
		}
		return new Gson().toJson(moveList);
	}	// moveMessageBox

	
	/**
	 * 5) 메시지 읽음 설정
	 * @param messageNo : 읽음 유무 설정하려는 메시지 번호
	 * @param bookmarkYN : 선택한 메시지 번호의 읽음 설정 유무 여부 (Y : 읽음 설정 / N : 안읽음 미설정)
	 * @return 메시지 북마크 설정 성공 여부
	 * @author JH
	 * @Date : 2023. 11. 25
	 */
	@ResponseBody
	@GetMapping("readMessage")
	public boolean readMsg(@RequestParam(value="messageNoList[]") List<Integer> messageList, boolean readYN) {
		
		int messageNo = 0;
		int result    = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("readYN", readYN ? "Y" : "N");
		
		for(int arr : messageList) {
			messageNo = arr;
			map.put("messageNo", messageNo);
			result += messageService.readMsg(map);
		}
		
		return result == messageList.size();
	}	// readYN
	
	
	// ==================================================================================
	// 메시지함 - 휴지통 관련
	// ==================================================================================
	
	
	/**
	 * 1) 휴지통 메시지 영구 삭제
	 * @param messageList : 영구 삭제 하려고 하는 메시지 번호
	 * @return 영구 삭제 성공 여부 반환 (DELETE)
	 * @author JH
	 * @Date : 2023. 11. 21
	 */
	@ResponseBody
	@GetMapping("deletePermanentlyMessage")
	public String deletePermanentlyMessage(@RequestParam(value="message_list[]") List<Integer> messageList) {
		
		JsonArray permanentDeleteList = new JsonArray();
		
		for(int arr : messageList) {
			int messageNo = arr;
			int result = messageService.deletePermanentlyMessage(messageNo);
				if(result > 0)
					permanentDeleteList.add(messageNo);
		}
		return new Gson().toJson(permanentDeleteList);
	}	// permanentDelete
	
	

}	// end class
