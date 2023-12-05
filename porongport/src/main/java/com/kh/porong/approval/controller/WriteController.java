package com.kh.porong.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WriteController {


	
	@RequestMapping("form")
	public String form() {
		
		return "approval/form";
	}
	
}
