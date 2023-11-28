package com.kh.porong.approval.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.porong.approval.model.service.EdmsService;

@Controller
public class EdmsController {
	
	@Autowired
	private EdmsService edmsService;
	
	@RequestMapping("approval")
	public String selectEdmsList() {
		
		return "approval/personalDepartmentForm";
	}

}
