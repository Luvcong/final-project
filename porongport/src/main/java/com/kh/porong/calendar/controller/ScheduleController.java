package com.kh.porong.calendar.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
		return "calendar/calendarMain";
	}
	
	@ResponseBody
	@GetMapping(value="schedule", produces="application/json; charset=UTF-8")
	public String ajaxMethod3(ScheduleVO schedule) {
		// hashmap으로 담아서 -> json타입으로 보내줘서 -> 다시 결과 뽑아주기
		//System.out.println(schedule);
		
		ArrayList<ScheduleVO> mySchedule = scheduleService.selectIndividual(schedule);
		ArrayList<ScheduleVO> departmentSchedule = scheduleService.selectDepartment(schedule);
		
		//System.out.println(departmentSchedule);
		
		HashMap<String, ArrayList<ScheduleVO>> AllSchdule = new HashMap();
		
		AllSchdule.put("mySchedule", mySchedule);
		AllSchdule.put("departmentSchedule", departmentSchedule);
		
		//System.out.println(AllSchdule);
		return new Gson().toJson(AllSchdule);
	}
	
	
	@RequestMapping("myCalendar")
	public String enrollFormMycalendar() {
		return "calendar/myCalendarInsertView";
	}

	@RequestMapping("departmentCalendar")
	public String enrollFormDepartmentcalendar() {
		return "calendar/departmentCalendarInsertView";
	}
	
	@RequestMapping("insertCalendar")
	public String insertSchedule(ScheduleVO schedule, HttpSession session) {
		String startDate = schedule.getStartDate();
		String startTime = schedule.getStartTime();
		
		String endDate = schedule.getEndDate();
		String endTime = schedule.getEndTime();
		
		if(startTime != "") {
			schedule.setSchStart(startDate+"T"+startTime);
			schedule.setSchEnd(endDate+"T"+endTime);
		}else {
			schedule.setSchStart(startDate);
			schedule.setSchEnd(endDate);
		}
		
		//System.out.println(schedule);
		
		if(scheduleService.insertSchedule(schedule)>0) {
			session.setAttribute("alertMsg", "개인일정 등록이 완료되었습니다.");
			return "redirect:calendar";
		}else {
			session.setAttribute("errorMsg", "개인일정 등록에 실패하였습니다.");
			return "common/errorPage";
		}
		
	}
	
	@RequestMapping("updateSchedule")
	public String updateSchedule(ScheduleVO schedule, HttpSession session) {
		//System.out.println(schedule);
		
		schedule.setSchStart(schedule.getStartDate()+"T"+schedule.getStartTime());
		schedule.setSchEnd(schedule.getEndDate()+"T"+schedule.getEndTime());
		
		//System.out.println(schedule);
		if(scheduleService.updateSchedule(schedule)>0) {
			session.setAttribute("alertMsg", "수정이 완료되었습니다.");
			return "redirect:calendar";
		}else {
			session.setAttribute("errorMsg", "수정에 실패하였습니다.");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("deleteSchedule")
	public String deleteSchedule(ScheduleVO schedule, HttpSession session) {
		//System.out.println(schedule);
		
		schedule.setSchStart(schedule.getStartDate()+"T"+schedule.getStartTime());
		schedule.setSchEnd(schedule.getEndDate()+"T"+schedule.getEndTime());
		
		//System.out.println(schedule);
		if(scheduleService.deleteSchedule(schedule)>0) {
			session.setAttribute("alertMsg", "삭제가 완료되었습니다.");
			return "redirect:calendar";
		}else {
			session.setAttribute("errorMsg", "삭제에 실패하였습니다.");
			return "common/errorPage";
		}
	}
	
	/*
	
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
	*/
	
}
