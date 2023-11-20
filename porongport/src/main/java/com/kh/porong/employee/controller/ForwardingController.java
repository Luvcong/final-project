package com.kh.porong.employee.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.porong.employee.model.service.EmployeeService;

@Controller
public class ForwardingController {
	
	@Autowired
	EmployeeService empService;

	@GetMapping("myPageAtt")
	public String myPageAttendance() {
		return "mypage/myPageAttendance";
	}
	
	@GetMapping("myPageIn")
	public String myPageInsertEmp() {
		return "mypage/myPageInsertEmp";
	}
	
	@GetMapping("myPageUp")
	public String myPageUpdateForm() {
		return "mypage/myPageUpdateForm";
	}
	
}
