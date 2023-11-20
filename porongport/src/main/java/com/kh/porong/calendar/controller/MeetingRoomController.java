package com.kh.porong.calendar.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.porong.calendar.model.service.MeetingRoomService;
import com.kh.porong.calendar.model.vo.MeetingRoomVO;

@Controller
public class MeetingRoomController {
	
	@Autowired
	private MeetingRoomService meetingRoomService;
	
	@RequestMapping("reservation")
	public String meeting() {
		return "meeting/meeting";
	}
	
	@RequestMapping("insertMeeting")
	public String insertmeeting(MeetingRoomVO mr, HttpSession session) {
		
		String meetStartDay = mr.getMeetStartDay();
		String meetStartTime = mr.getMeetStartTime();
		
		String meetEndDay = mr.getMeetEndDay();
		String meetEndTime = mr.getMeetEndTime();
		
		if(meetStartDay != "") {
			mr.setMeetStart(meetStartDay+'T'+meetStartTime);
			mr.setMeetEnd(meetEndDay+'T'+meetEndTime);
		}
		
		
		if(meetingRoomService.insertMeetingRoom(mr) > 0) {
			session.setAttribute("alertMsg", "일정추가성공");
			return "redirect:reservation";
		}else {
			session.setAttribute("alertMsg", "일정추가실패");
			return "redirect:reservation";
		}
		
	}
	
}
