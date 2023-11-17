package com.kh.porong.employee.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.porong.employee.model.service.EmployeeServiceImpl;
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
	public ModelAndView loginEmp(Employee emp, ModelAndView mv, HttpSession session, String workStart) {
		Employee loginEmp = empService.loginEmp(emp);
		
		if(loginEmp != null) {
			session.setAttribute("loginUser", loginEmp);
			mv.setViewName("mypage/myPageAttendance");
			
			// 로그인 성공 시, 근태테이블 insert
			Map<String, Object> addAtt = new HashMap<>();
			addAtt.put("empNo", (Integer)emp.getEmpNo());
			addAtt.put("workStart", workStart);
			
			empService.workToday(addAtt);
			
			
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
}
