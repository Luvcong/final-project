package com.kh.porong.calendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	public String adminMeetingRoom(MeetingRoomVO mr, HttpSession session) {
		session.setAttribute("mr", mr);
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
			session.setAttribute("alertMsg", "회의실 예약 신청완료");
			session.setAttribute("mr", mr);
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
		
		model.addAttribute("list", meetingRoomService.selectList(pi));
		
		model.addAttribute("pi", pi);
		return "meeting/reservationStatus";
	}
	

/*	@RequestMapping("detailmeet")
	public ModelAndView selectDetailReservation(int mno, ModelAndView mv) {
		if(MeetingRoomService != null) {
			mv.addObject("m",MeetingRoomService.selectDetailReservation(mno)).setViewName("meeting/reservationDetail");
		} else {
			mv.addObject("errorMsg", "회의실 예약목록 상세조회 실패").setViewName("common/errorPage");
		}
		return mv;
	}
	*/
	@RequestMapping("detailReservation")
	public ModelAndView selectDetailReservation(int mno, ModelAndView mv) {
//		int형으로 작성했더니 알아서파싱
		if(mno > 0) {
			mv.addObject("mr",meetingRoomService.selectDetailReservation(mno)).setViewName("meeting/reservationDetail");
		} else {
			mv.addObject("errorMsg", "예약목록 상세조회 실패").setViewName("common/errorPage");
		}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("dbtimeCheck")
	public String dbtimeCheck(String checkId) {

		 return meetingRoomService.dbtimeCheck(checkId) > 0 ? "N" : "Y";
	}
	
	
	@RequestMapping("updateForm")
	public String updatemeet(int mno, HttpSession session) {
		if(meetingRoomService.updatemeet(mno) > 0) {
			session.setAttribute("alertMsg","예약승인 완료");
			return "redirect:reservationStatus";
		}else {
			session.setAttribute("errorMsg","실패" );
			return "redirect:reservationStatus";
		}
	}
	@RequestMapping("notupdateForm")
	public String notupdatemeet(int mno, HttpSession session) {
		if(meetingRoomService.notupdatemeet(mno) > 0) {
			session.setAttribute("alertMsg","예약반려");
			return "redirect:reservationStatus";
		}else {
			session.setAttribute("errorMsg","예약 반려실패" );
			return "redirect:reservationStatus";
		}
	}
	
	@ResponseBody
	@GetMapping(value = "meetingList", produces = "application/json; charset=UTF-8")
	public String ajaxTopMeet() {
		return new Gson().toJson(meetingRoomService.selectTopMeet());
	}

}
