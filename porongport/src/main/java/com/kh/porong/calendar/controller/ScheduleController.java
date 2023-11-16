package com.kh.porong.calendar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.porong.calendar.model.service.ScheduleService;

@Controller
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
	
	@RequestMapping("calendar")
	public String calendarMain() {
		return "calendar/calendarMain";
	}
	
	
}
