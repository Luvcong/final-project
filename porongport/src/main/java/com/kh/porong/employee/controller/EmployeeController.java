package com.kh.porong.employee.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.porong.employee.model.service.EmployeeServiceImpl;
import com.kh.porong.employee.model.vo.Attendance;
import com.kh.porong.employee.model.vo.Employee;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeServiceImpl empService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender sender;
	
	@PostMapping("insert.emp")
	public String insertEmp(Employee emp, HttpSession session) {
		String encPwd = bcryptPasswordEncoder.encode(emp.getEmpPwd());
		emp.setEmpPwd(encPwd);
		
		if(empService.insertEmp(emp) > 0) {
			session.setAttribute("alertMsg", "입사자 등록에 성공하였습니다.");
			return "redirect:mypageAtt";
		}
		else {
			session.setAttribute("errorMsg", "입사자 등록에 실패하였습니다.");
			return "mypage/myPageUpdateForm";
		}
	}
	
	@PostMapping("login.em")
	public ModelAndView loginEmp(Employee emp, ModelAndView mv, HttpSession session) {
		Employee loginEmp = empService.loginEmp(emp);
		
		if(loginEmp != null) {
			session.setAttribute("loginUser", loginEmp);
			
			ArrayList<Attendance> attList = empService.attList(loginEmp.getEmpNo());
			mv.addObject("attList", attList).setViewName("mypage/myPageAttendance");
			
		} else {
			mv.addObject("errorMsg", "로그인 실패. 다시 시도해주세요.").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	
	@RequestMapping("logout.em")
	public String logoutEmp(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@ResponseBody
	@GetMapping(value="insert.at", produces="json/application; charset=UTF-8")
	public String insertAtt(Attendance att) {
		if(empService.insertAtt(att) > 0) {
			Attendance reAtt = empService.selectAtt(att);
			return new Gson().toJson(reAtt);
		} else {
			return "redirect:myPageAtt";
		}
		
	}
	
	@ResponseBody
	@GetMapping(value="update.at", produces="json/application; charset=UTF-8")
	public String updateAtt(Attendance att) {
		if(empService.updateAtt(att) > 0) {
			return new Gson().toJson(att.getWorkEnd());
		} else {
			return "redirect:myPageAtt";
		}
	}
	
}
