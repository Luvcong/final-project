package com.kh.porong.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class testController {

	@RequestMapping("test.go")
	public String contentTest() {
		return "test/contentTest";
	}	// enrollForm
	
}	// end class
