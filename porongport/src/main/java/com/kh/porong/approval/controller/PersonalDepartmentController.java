package com.kh.porong.approval.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.porong.approval.model.service.EdmsService;
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
	@GetMapping("insertGeneralDocument")
	public String insertGeneralDocument(GeneralVO ge, HttpSession session) {
		
		String generalTitle = ge.getGenTitle();
		String generalContent = ge.getGenContent();
		
		if (edmsService.insertGeneralDocument(ge) > 0) { 
	         return "redirect:department";
	      } else { 
	    	  session.setAttribute("alertMsg", "결재실패");
	         return "redirect:department";
	      }
	   }
	

}
