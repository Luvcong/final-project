package com.kh.porong.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ApprovalLineController {
	
	@RequestMapping("line")
	public String updateApprovalLine() {
		
		return "appoval/approvalLine";
	}
	
	@RequestMapping("test")
	public String test() {
		return "appoval/testForm";
	}

}
