package com.kh.porong.calendar.controller;

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
	
	@RequestMapping("insertCalendar")
	public String insertMySchedule(ScheduleVO schedule) {
		if(scheduleService.insertDepartment(schedule)>0) {
			
		}
		
		return "";
	}
	
}
