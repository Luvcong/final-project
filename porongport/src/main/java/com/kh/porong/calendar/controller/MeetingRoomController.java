package com.kh.porong.calendar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.porong.calendar.model.service.MeetingRoomService;

@Controller
public class MeetingRoomController {
	
	@Autowired
	private MeetingRoomService meetingRoomService;
	
	@RequestMapping("reservation")
	public String meeting() {
		return "meeting/meeting";
	}
	
	
}
