package com.kh.porong.calendar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.porong.calendar.model.service.MeetingRoomService;

@Controller
public class MeetingRoomController {
	
	@Autowired
	private MeetingRoomService meetingRoomService;
	
}
