package com.kh.porong.approval.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.porong.approval.model.service.EdmsService;
import com.kh.porong.approval.model.vo.VacationVO;
import com.kh.porong.employee.model.vo.Employee;

@Controller
public class VacationController {
	
	@Autowired
	private EdmsService edmsService;

	@RequestMapping("vacation")
	public String selectVacationDetail() {
		
		return "approval/vacationForm";
	}
	
	@ResponseBody
	@GetMapping(value="organizationChart", produces="json/application; charset=UTF-8")
	public String selectOrganizationChart() {
		
		ArrayList<VacationVO> list = edmsService.selectOrganiztionChart();
		return new Gson().toJson(list);
	}
}
