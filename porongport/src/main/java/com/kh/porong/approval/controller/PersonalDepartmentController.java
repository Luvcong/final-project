package com.kh.porong.approval.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.porong.approval.model.service.EdmsService;
import com.kh.porong.approval.model.vo.EdmsLineVO;
import com.kh.porong.approval.model.vo.EdmsVO;
import com.kh.porong.approval.model.vo.GeneralVO;

@Controller
public class PersonalDepartmentController {
	
	@Autowired
	private EdmsService edmsService;
	
	@RequestMapping("department")
	public String selectVacationDetail() {
		
		return "approval/personalDepartmentForm";
	}
	
	@ResponseBody
	@PostMapping(value="insertEdms", produces="application/json; charset=UTF-8")
	public String insertEdms(EdmsLineVO el, EdmsVO ed, GeneralVO ge, HttpSession session, String empNo1, String empNo2, String empNo3) {
		
//		System.out.println(empNo1);
//		System.out.println(empNo2);
//		System.out.println(empNo3);
		
//		System.out.println(ed);
//		System.out.println(ge);
		
		
		
		if (edmsService.insertEdms(ed) > 0) {
			
			
			
			 session.setAttribute("alertMsg", "서류작성성공");
	      } else { 
	    	  session.setAttribute("alertMsg", "서류작성실패");
	      }
		return "redirect:department";
	   }
	

}
