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
import com.kh.porong.calendar.model.vo.ScheduleVO;

@Controller
public class PersonalDepartmentController {
	
	@Autowired
	private EdmsService edmsService;
	
	@RequestMapping("department")
	public String selectVacationDetail() {
		
		return "approval/personalDepartmentForm";
	}
	
	@RequestMapping("document1")
	public String insertDocument() {
		
		return "approval/personalDepartmentForm";
	}
	
	@ResponseBody
	@PostMapping(value="insertEdms", produces="application/json; charset=UTF-8")
	public String insertEdms(EdmsLineVO el, EdmsVO ed, GeneralVO ge, HttpSession session, String empNo1, String empNo2, String empNo3) {
	
		if (edmsService.insertEdms(ed) > 0) {
			
			if(edmsService.insertGeneralDocument(ge) > 0) {
				
				el.setEmpNo1(Integer.valueOf(empNo1));
				
				edmsService.insertFirstEdmsLine(el);
				
				el.setEmpNo2(Integer.valueOf(empNo2));
				edmsService.insertSecondEdmsLine(el);
				
				el.setEmpNo3(Integer.valueOf(empNo3));
				edmsService.insertThirdEdmsLine(el);
				
			}
			 session.setAttribute("alertMsg", "서류작성성공");
	      } else { 
	    	  session.setAttribute("alertMsg", "서류작성실패");
	      }
		return "redirect:department";
	   }
	
	@RequestMapping("document2")
	public String updateEdmsLine(EdmsLineVO el, HttpSession session) {
		
		if(edmsService.updateEdmsLine(el) > 0) {
			session.setAttribute("alertMsg", "수정이 완료되었습니다.");
			return "approval/paymentList";
		}else {
			session.setAttribute("errorMsg", "수정에 실패하였습니다.");
			return "common/errorPage";
		}
	}
	

}
