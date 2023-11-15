package com.kh.porong.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class testController {

	@RequestMapping("/main")
	public String mainTest() {
		return "test/mainTest";
	}	// enrollForm
	
	@RequestMapping("main2")
	public String mainTest1() {
		return "test/mainTest2";
	}	// enrollForm
	
	@RequestMapping("main3")
	public String mainTest2() {
		return "test/mainTest3";
	}	// enrollForm
	
}	// end class
