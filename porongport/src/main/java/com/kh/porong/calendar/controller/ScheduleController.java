package com.kh.porong.calendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.porong.calendar.model.service.ScheduleService;
import com.kh.porong.calendar.model.vo.ScheduleVO;

@Controller
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
	
	@RequestMapping("calendar")
	public String calendarMain(ScheduleVO schedule, HttpSession session) {
		
		//ArrayList<ScheduleVO> mySchedule = scheduleService.selectIndividual(schedule);
		//ArrayList<ScheduleVO> departmentSchedule = scheduleService.selectDepartment(schedule);
		
		//System.out.println(departmentSchedule);
		//session.setAttribute("mySchedule", mySchedule);
		//session.setAttribute("departmentSchedule", departmentSchedule);
		return "calendar/calendarMain";
	}
	
	@ResponseBody
	@RequestMapping(value="ajax3.do", produces="application/json; charset=UTF-8")
	public String ajaxMethod3(ScheduleVO schedule) {
		// hashmap으로 담아서 json타입으로 보내줘서 다시 결과 뽑아주기
		ArrayList<ScheduleVO> mySchedule = scheduleService.selectIndividual(schedule);
		ArrayList<ScheduleVO> departmentSchedule = scheduleService.selectDepartment(schedule);
		
		return new Gson().toJson(mySchedule);
	}
	
	
	@RequestMapping("myCalendar")
	public String enrollFormMycalendar() {
		return "calendar/myCalendarInsertView";
	}

	@RequestMapping("departmentCalendar")
	public String enrollFormDepartmentcalendar() {
		return "calendar/departmentCalendarInsertView";
	}
	
	@RequestMapping("insertMyCalendar")
	public String insertMySchedule(ScheduleVO schedule, HttpSession session) {
		
		String startDate = schedule.getStartDate();
		String startTime = schedule.getStartTime();
		
		String endDate = schedule.getEndDate();
		String endTime = schedule.getEndTime();
		
		if(startTime != "") {
			schedule.setSchStart(startDate+'T'+startTime);
			schedule.setSchEnd(endDate+'T'+endTime);
		}else {
			schedule.setSchStart(startDate);
			schedule.setSchEnd(endDate);
		}
		//System.out.println(schedule.getSchStart());
		//System.out.println(schedule.getSchEnd());
		
		if(scheduleService.insertIndividual(schedule)>0) {
			session.setAttribute("alertMsg", "개인일정 등록이 완료되었습니다.");
			return "redirect:myCalendar";
		}else {
			session.setAttribute("errorMsg", "개인일정 등록에 실패하였습니다.");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("insertDepartmentCalendar")
	public String insertDepartmentSchedule(ScheduleVO schedule, HttpSession session) {
		
		String startDate = schedule.getStartDate();
		String startTime = schedule.getStartTime();
		
		String endDate = schedule.getEndDate();
		String endTime = schedule.getEndTime();
		
		if(startTime != "") {
			schedule.setSchStart(startDate+'T'+startTime);
			schedule.setSchEnd(endDate+'T'+endTime);
		}else {
			schedule.setSchStart(startDate);
			schedule.setSchEnd(endDate);
		}
		
		if(scheduleService.insertDepartment(schedule)>0) {
			session.setAttribute("alertMsg", "부서일정 등록이 완료되었습니다.");
			return "redirect:myCalendar";
		}else {
			session.setAttribute("errorMsg", "부서일정 등록에 실패하였습니다.");
			return "common/errorPage";
		}
	}
	
	
}
