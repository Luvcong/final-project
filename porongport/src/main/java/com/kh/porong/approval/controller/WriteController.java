package com.kh.porong.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WriteController {

	@RequestMapping("document1")
	public String insertDocument() {
		
		return "approval/writeForm";
	}
	
}
