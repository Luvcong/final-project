package com.kh.porong.message.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class messageController {
	
	@RequestMapping("message")
	public String messageReceived() {
		return "message/messageReceived";
	}

	

}	// end class
