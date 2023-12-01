package com.kh.porong.employee.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.porong.employee.model.service.EmployeeServiceImpl;
import com.kh.porong.employee.model.vo.Attachment;
import com.kh.porong.employee.model.vo.Attendance;
import com.kh.porong.employee.model.vo.Employee;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EmployeeController {
	
	private final EmployeeServiceImpl empService;
	private final BCryptPasswordEncoder bcrypt;
	private final JavaMailSender sender;
	
	// 입사자 등록
	@PostMapping("insert.em")
	public String insertEmp(Employee emp, HttpSession session) throws MessagingException{
		String encPwd = bcrypt.encode(emp.getEmpPwd());
		emp.setEmpPwd(encPwd);
		
		String toUpperDept = emp.getDeptCode().toUpperCase();
		String toUpperJob = emp.getJobCode().toUpperCase();

		emp.setDeptCode(toUpperDept);
		emp.setJobCode(toUpperJob);
		
		if(toUpperJob.equals("SM") || toUpperJob.equals("MG") || toUpperJob.equals("SA") || toUpperJob.equals("JA") ) {
			
			if(empService.insertEmp(emp) > 0) {

				MimeMessage msg = sender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(msg, false, "UTF-8");
				helper.setTo(emp.getEmpEmail());
				helper.setSubject("[포롱포트]입사자 등록 완료 메일");
				helper.setText("<b style='font-size:20px;'>" + emp.getEmpName() + "</b>님의"
							+ "<br/>입사자 등록건이 완료되었습니다." 
							+ "<br/>로그인 후 비밀번호 및 이메일 변경을 공지해주세요."
							+ " >> <a href='http://localhost:8002/porong'>로그인 페이지</a>", true);
					
				sender.send(msg);
				
				session.setAttribute("successText", "입사자 등록에 성공하였습니다. 메일함을 확인해주세요");
				return "mypage/myPageAttendance";
			} else {
				session.setAttribute("errorText", "입사자 등록에 실패하였습니다.");
				return "redirect:myPageIn";
			}
		} else {
			session.setAttribute("alertText", "존재하지 않는 직급입니다. 다시 입력해주세요.");
			return "redirect:myPageIn";
		}
	}
	
	// 로그인
	@PostMapping("login.em")
	public ModelAndView loginEmp(Employee emp, ModelAndView mv, HttpSession session) {
		Employee loginEmp = empService.loginEmp(emp);
		
		if(loginEmp != null && (bcrypt.matches(emp.getEmpPwd(), loginEmp.getEmpPwd()) || loginEmp.getDeptCode().equals("WEB"))) {
			// 로그인한 유저 정보 세션에 담기
			session.setAttribute("loginUser", loginEmp);

			// 로그인한 유저 근태 리스트 조회
			session.setAttribute("attList", empService.attList(loginEmp.getEmpNo()));
			
			// 로그인한 유저 프로필 조회
			session.setAttribute("profile", empService.selectProfile(emp.getEmpNo()));
			
			// 최초 로그인 판별
			int flag = empService.firstLogin(emp);
			// 최초 로그인인 유저 -> 비밀번호 변경 유도 
			if(flag > 0) {
				session.setAttribute("alertText", "비밀번호를 변경해주세요.");
				mv.setViewName("mypage/myPageUpdateForm");
			} else {
				mv.setViewName("mypage/myPageAttendance");
			}
			
		}  else {
			mv.addObject("alertMsg", "로그인 실패, 다시 시도해주세요.").setViewName("main");
		}
	
		return mv;
	}
	
	// 로그아웃
	@RequestMapping("logout.em")
	public String logoutEmp(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 조직도 조회
	@GetMapping("jojigdo.em")
	public ModelAndView selectJojigdo(ModelAndView mv, String deptCode) {
		ArrayList<Employee> list = empService.selectJojigdo(deptCode); 
		
		if(!list.isEmpty()) {
			mv.addObject("jojigdoList", list).setViewName("common/jojigdo");
		
		} else {
			mv.addObject("alertText", "해당 부서의 조직도가 존재하지 않습니다.").setViewName("redirect:myPageAtt");
		}
		
		return mv;
	}
	
	/**
	 * @param upfile : 처음으로 프로필 사진 변경시(insert)
	 * @param reUpfile : 프로필 사진 재업로드 변경(update)
	 */
	// 유저 정보 변경
	@PostMapping("update.em")
	public ModelAndView updateEmp(Employee emp, ModelAndView mv, Attachment profile,
								  HttpSession session, MultipartFile upfile, MultipartFile reUpfile) {
		// 프로필 업로드(insert)
		if(upfile != null) {
			if(!upfile.getOriginalFilename().equals("")) {

				profile.setOriginFileName(upfile.getOriginalFilename());
				profile.setChangeFileName(saveFile(upfile, session));
				profile.setFilePath(session.getServletContext().getRealPath("/resources/upProfiles/"));
				profile.setRefEmpNo(emp.getEmpNo());
				
				if(empService.insertProfile(profile) > 0){
					session.setAttribute("profile", empService.selectProfile(profile.getRefEmpNo()));
					if(emp != null) {
						updateEmp(emp, mv, session);
					} 
				}
			}
		// 프로필 재업(update)
		} else if(reUpfile != null){
			 if(!reUpfile.getOriginalFilename().equals("")) { 
				 
				new File(session.getServletContext().getRealPath("/resources/upProfiles/" + profile.getChangeFileName())).delete();
				
				profile.setOriginFileName(reUpfile.getOriginalFilename());
				profile.setChangeFileName(saveFile(reUpfile, session));
				profile.setRefEmpNo(emp.getEmpNo());
				
				if(empService.updateProfile(profile) > 0) {
					session.setAttribute("profile", empService.selectProfile(profile.getRefEmpNo()));
					if(emp != null) {
						updateEmp(emp, mv, session);
					}
				}
			}
		} else {
			updateEmp(emp, mv, session);
		}
		return updateEmp(emp, mv, session);

	}
	
	
	// 사용자 정보 수정 메서드
	public ModelAndView updateEmp(Employee emp, ModelAndView mv, HttpSession session) {
		// 비밀번호 변경시 암호화
		if(!emp.getEmpPwd().equals("")) {
			String encPwd = bcrypt.encode(emp.getEmpPwd());
			emp.setEmpPwd(encPwd);
		}
		
		if(empService.updateEmp(emp) > 0) {
			session.setAttribute("loginUser", empService.loginEmp(emp));
			mv.addObject("successText", "내정보가 변경되었습니다.").setViewName("mypage/myPageUpdateForm");
		} else {
			mv.addObject("errorText", "내정보 변경을 실패했습니다.").setViewName("mypage/myPageUpdateForm");
		}
		return mv;
	}
	
	// 프로필 변경 시, 파일변경 메서드
	public String saveFile(MultipartFile upfile, HttpSession session) { 
		String originName = upfile.getOriginalFilename();
		String cTime = new SimpleDateFormat("yyyyMMdd").format(new Date());
		int ranNum = (int)(Math.random() * 90000) + 10000;
		String ext = originName.substring(originName.lastIndexOf("."));
		String changeName = cTime + ranNum + ext;
		String savePath = session.getServletContext().getRealPath("/resources/upProfiles/");
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
	
	// 부서추가
	@GetMapping("insert.de")
	public ModelAndView insertDept(Employee emp, ModelAndView mv) {
		String toUpper = emp.getDeptCode().toUpperCase();
		emp.setDeptCode(toUpper);
		
		if(empService.insertDept(emp) > 0) {
			mv.addObject("successText", "부서추가가 완료됐습니다.").setViewName("common/jojigdo");
		} else {
			mv.addObject("errorText", "부서추가를 실패했습니다.").setViewName("common/jojigdo");
		}
		return mv;
	}
	
	// 비밀번호 찾기
	@PostMapping("findPwd.em")
	public ModelAndView findPwd(Employee emp, ModelAndView mv, HttpServletRequest request) throws MessagingException {
		// 메일로 보낼 임시비번
		int tempPwd = (int)(Math.random() * 90000) + 10000;
		
		emp.setEmpPwd(bcrypt.encode(String.valueOf(tempPwd)));
		
		if(empService.findPwd(emp) > 0) {
			
			MimeMessage msg = sender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, false, "UTF-8");
			helper.setTo(emp.getEmpEmail());
			helper.setSubject("[포롱포트]임시 비밀번호 발급 메일");
			helper.setText("<b style='font-size:25px;>" + emp.getEmpName() + "</b>님의"
							+ "<br/>비밀번호 찾기를 통한 임시 비밀번호입니다."
							+ "<br/>임시비밀번호 : <b style='font-size:20px;>" + tempPwd +"</b>" 
							+ "<br/>로그인 후 비밀번호 변경을 해주세요."
							+ " >> <a href='http://localhost:8002/" + request.getContextPath() + "'>로그인 페이지</a>", true);
			
			sender.send(msg);
			
			mv.addObject("alertMsg", "메일함을 확인해주세요.").setViewName("main");
			
		} else {
			mv.addObject("alertMsg", "이름과 아이디를 다시 확인해주세요.").setViewName("main");
		}
		return mv;
		
	}
	
	// AJAX -----------------------------------------------------------------------------------------------

	// 아이디 중복체크
	@ResponseBody
	@GetMapping("idCheck.em")
	public String idCheck(int checkId) {
		return empService.idCheck(checkId) > 0 ? "N" : "Y"; 
	}
		
	// 근태기록 조회
	@ResponseBody
	@GetMapping(value="selectAtt.em", produces="json/application; charset=UTF-8")
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
	
	// 부서코드 중복체크
	@ResponseBody
	@GetMapping("dcCheck.de")
	public String dcCheck(String checkDc) {
		String toUpper = checkDc.toUpperCase();
		return empService.dcCheck(toUpper) > 0 ? "N" : "Y";
	}
	
}
