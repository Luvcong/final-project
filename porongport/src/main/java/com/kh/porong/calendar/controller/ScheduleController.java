package com.kh.porong.calendar.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.porong.calendar.model.service.ScheduleService;
import com.kh.porong.calendar.model.vo.ScheduleVO;

@Controller
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
	
	@RequestMapping("calendar")
	public String calendarMain() {
		return "calendar/calendarMain";
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
		
		if(scheduleService.insertDepartment(schedule)>0) {
			session.setAttribute("alertMsg", "일정 등록이 완료되었습니다.");
			return "redirect:myCalendar";
		}else {
			session.setAttribute("errorMsg", "일정 등록에 실패하였습니다.");
			return "common/errorPage";
		}
	}
	
}
