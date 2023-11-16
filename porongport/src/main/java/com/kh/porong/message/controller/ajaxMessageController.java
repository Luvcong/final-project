package com.kh.porong.message.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.kh.porong.message.model.service.MessageService;

@Controller
public class ajaxMessageController {
	
	@Autowired
	private MessageService messageService;
	
	/**
	 * 메시지 삭제 - 휴지통 이동
	 * @param messageNoList : 삭제하려고 하는 메시지 번호 (messageNo)
	 * @return 메시지 삭제 성공 여부 (MESSAGE_STATUS = N 으로 변경 완료 여부) 반환
	 * @author JH
	 * @Date : 2023. 11. 16
	 */
	@ResponseBody
	@GetMapping(value="deleteMessageBox", produces="application/json; charset=UTF-8")
	public String deleteMessage(@RequestParam(value="messageNoList[]") ArrayList<String> messageNoList) {
		
		JsonArray successList = new JsonArray();
		for(String arr : messageNoList) {
			int messageNo = Integer.parseInt(arr);
			int result = messageService.deleteMessage(messageNo);
			if(result > 0)
				successList.add(messageNo);
		}
		return new Gson().toJson(successList);
	}	// deleteMessage

}	// end class
