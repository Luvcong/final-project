package com.kh.porong.employee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class ForwardingController {

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
	
	@GetMapping("jojigdo")
	public String jojigdo() {
		return "common/jojigdo";
	}
	
	@GetMapping("findPwd")
	public String findPwd() {
		return "common/findPwd";
	}
	
}
