package com.kh.porong.employee.controller;

import java.util.ArrayList;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	
	// 입사자 등록
	@PostMapping("insert.emp")
	public String insertEmp(Employee emp, HttpSession session) throws MessagingException{
		// String encPwd = bcryptPasswordEncoder.encode(emp.getEmpPwd());
		// emp.setEmpPwd(encPwd);
		
		if(empService.insertEmp(emp) > 0) {
			MimeMessage msg = sender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, false, "UTF-8");
			
			// 관리자들한테 메일 보내기
			String[] to = {"kwondy1892@gmail.com"};
			helper.setTo(to);
			
			helper.setSubject("입사자 등록 완료건");
			
			DataSource source = new FileDataSource("resources/mail.html");
			helper.addAttachment(source.getName(), source);
			
			sender.send(msg);
			
			session.setAttribute("alertMsg", "입사자 등록에 성공하였습니다.");
			return "mypage/myPageAttendance";
		} else {
			session.setAttribute("errorMsg", "입사자 등록에 실패하였습니다.");
			return "common/errorPage";
		}
	}
	
	// 아이디 중복체크
	@ResponseBody
	@GetMapping("idCheck.em")
	public String idCheck(int checkId) {
		return empService.idCheck(checkId) > 0 ? "N" : "Y"; 
	}
	
	// 로그인
	@PostMapping("login.em")
	public ModelAndView loginEmp(Employee emp, ModelAndView mv, HttpSession session) {
		Employee loginEmp = empService.loginEmp(emp);
		
		if(loginEmp != null) {
			session.setAttribute("loginUser", loginEmp);
			
			ArrayList<Attendance> attList = empService.attList(loginEmp.getEmpNo());
			
			// mv.addObject("attList", attList).setViewName("mypage/myPageAttendance");
			session.setAttribute("attList", attList);
			mv.setViewName("mypage/myPageAttendance");
			
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
