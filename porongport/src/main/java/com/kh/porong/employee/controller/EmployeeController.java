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
	public String insertEmp(Employee emp, HttpSession session) /*throws MessagingException*/{
		String encPwd = bcryptPasswordEncoder.encode(emp.getEmpPwd());
		emp.setEmpPwd(encPwd);
		
		String toUpperDept = emp.getDeptCode().toUpperCase();
		String toUpperJob = emp.getJobCode().toUpperCase();

		emp.setDeptCode(toUpperDept);
		emp.setJobCode(toUpperJob);
		
		if(empService.insertEmp(emp) > 0) {
			
			/*
			MimeMessage msg = sender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, false, "UTF-8");
			
			// 관리자들한테 메일 보내기
			String[] to = {"kwondy1892@gmail.com"};
			helper.setTo(to);
			
			helper.setSubject("입사자 등록 완료건");
			DataSource source = new FileDataSource("/resources/mail.html");
			helper.addAttachment(source.getName(), source);
			
			sender.send(msg);
			*/
			
			session.setAttribute("alertText", "입사자 등록에 성공하였습니다.");
			return "mypage/myPageAttendance";
		} else {
			session.setAttribute("errorText", "입사자 등록에 실패하였습니다.");
			return "redirect:myPageIn";
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
	
		if(loginEmp != null && bcryptPasswordEncoder.matches(emp.getEmpPwd(), loginEmp.getEmpPwd())) {
			// 로그인한 유저 정보 세션에 담기
			session.setAttribute("loginUser", loginEmp);
			
			// 로그인한 유저 근태 리스트 조회
			ArrayList<Attendance> attList = empService.attList(loginEmp.getEmpNo());
			session.setAttribute("attList", attList);
			
			// 최초 로그인 판별
			int flag = empService.firstLogin(emp);
			// 최초 로그인인 유저 -> 비밀번호 변경 유도 
			if(flag > 0) {
				session.setAttribute("alertMsg", "비밀번호를 변경해주세요.");
				mv.setViewName("mypage/myPageUpdateForm");
			} else {
				mv.setViewName("mypage/myPageAttendance");
			}
			
		} else if(loginEmp.getEmpNo() == 0){
			session.setAttribute("loginUser", loginEmp);
			ArrayList<Attendance> attList = empService.attList(loginEmp.getEmpNo());
			session.setAttribute("attList", attList);
			mv.setViewName("mypage/myPageAttendance");
			
		} else {
			mv.addObject("loginFail", "다시 시도해주세요.").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	// 로그아웃
	@RequestMapping("logout.em")
	public String logoutEmp(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 근태기록 조회
	@ResponseBody
	@RequestMapping(value="selectAtt.em", produces="json/application; charset=UTF-8")
	public String checkAtt(Attendance att) {
		Attendance selectAtt = empService.selectAtt(att);
		if(att != null) {
			return new Gson().toJson(selectAtt);
		} else {
			return "redirect:myPageAtt";
		}
	}
	
	// 출근기록 인서트
	@ResponseBody
	@GetMapping(value="insert.at", produces="json/application; charset=UTF-8")
	public String insertAtt(Attendance att) {
		if(empService.insertAtt(att) > 0) {
			return new Gson().toJson(att.getWorkStart());
		} else {
			return "redirect:myPageAtt";
		}
	
	}
	
	// 퇴근기록 업데이트
	@ResponseBody
	@GetMapping(value="update.at", produces="json/application; charset=UTF-8")
	public String updateAtt(Attendance att) {
		if(empService.updateAtt(att) > 0) {
			return new Gson().toJson(att.getWorkEnd());
		} else {
			return "redirect:myPageAtt";
		}
	}
	
	// 조직도 조회
	@GetMapping("jojigdo.em")
	public ModelAndView selectJojigdo(ModelAndView mv, String deptCode) {
		ArrayList<Employee> list = empService.selectJojigdo(deptCode); 
		
		if(!list.isEmpty()) {
			mv.addObject("jojigdoList", list).setViewName("common/jojigdo");
		
		} else {
			mv.addObject("errorText", "해당 부서의 조직도가 존재하지 않습니다.").setViewName("redirect:myPageAtt");
		}
		
		return mv;
	}
	
	// 유저 정보 변경
	@PostMapping("update.em")
	public ModelAndView updateEmp(Employee emp, ModelAndView mv, HttpSession session) {
		String encPwd = bcryptPasswordEncoder.encode(emp.getEmpPwd());
		emp.setEmpPwd(encPwd);
		
		if(empService.updateEmp(emp) > 0) {
			session.setAttribute("loginUser", empService.loginEmp(emp));
			
			mv.addObject("alertText", "내정보가 변경되었습니다.").setViewName("mypage/myPageUpdateForm");
			
		} else {
			
			mv.addObject("errorText", "내정보 변경을 실패했습니다.").setViewName("redirect:myPageUp");
		}
		
		return mv;
	}
}
