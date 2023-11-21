package com.kh.porong.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExpenseController {

	@RequestMapping("expense")
	public String selectVacationDetail() {
		
		return "approval/expenseForm";
	}
}
