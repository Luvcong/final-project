package com.kh.porong.calendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.porong.calendar.model.service.MeetingRoomService;
import com.kh.porong.calendar.model.vo.MeetingRoomVO;
import com.kh.porong.common.model.vo.PageInfo;
import com.kh.porong.common.template.Pagination;

@Controller
public class MeetingRoomController {
	
	@Autowired
	private MeetingRoomService meetingRoomService;
	
	@RequestMapping("reservation")
	public String meeting() {
		return "meeting/meetingCalendar";
	}
	@RequestMapping("adminMeetingRoom")
	public String adminMeetingRoom() {
		return "meeting/adminView";
	}
	@RequestMapping("reservationApprove")
	public String reservationApprove() {
		return "meeting/reservationApprove";
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
	@ResponseBody
	@GetMapping(value="meetingRoom", produces="application/json; charset=UTF-8")
	public String ajaxMethod3(MeetingRoomVO room) {
		ArrayList<MeetingRoomVO> meetingRoom = meetingRoomService.selectMeetingRoomList(room);
		return new Gson().toJson(meetingRoom);
	}
	
	@RequestMapping("reservationStatus")
	public String reservationList(@RequestParam(value="cPage", defaultValue="1") int currentPage, Model model) {
		
		PageInfo pi = Pagination.getPageInfo(meetingRoomService.selectListCount(), currentPage, 5, 5);
		System.out.println(meetingRoomService.selectListCount());
		
		model.addAttribute("list", meetingRoomService.selectList(pi));
		System.out.println(meetingRoomService.selectList(pi));
		
		model.addAttribute("pi", pi);
		return "meeting/reservationStatus";
	}
	
}
