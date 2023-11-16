package com.kh.porong.employee.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.porong.employee.model.service.EmployeeServiceImpl;
import com.kh.porong.employee.model.vo.Employee;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeServiceImpl empService;
	
	//@Autowired
	//private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender sender;
	
	/*
	@PostMapping("insert.emp")
	public String insertEmp(Employee emp, Model model) {
		String encPwd = bcryptPasswordEncoder.encode(emp.getEmpPwd());
		emp.setEmpPwd(encPwd);
		
		if(empService.insertEmp(emp) > 0) {
			return "redirect:mypage";
		}
		else {
			model.addAttribute("errorMsg", "입사자 등록에 실패하셨습니다.");
			return "redirect:insert";
		}
	}
	*/
	@GetMapping("login.em")
	public ModelAndView loginEmp(Employee emp, ModelAndView mv, HttpSession session) {
		
		Employee loginEmp = empService.loginEmp(emp);
		
		if(loginEmp != null) {
			session.setAttribute("loginUser", loginEmp);
			mv.setViewName("mypage/myPageAttendance");
		} else {
			mv.addObject("errorMsg", "로그인 실패, 다시 시도해주세요.").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	@GetMapping("logout.em")
	public String logoutEmp(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
