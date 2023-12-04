package com.kh.porong.approval.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.porong.approval.model.service.EdmsService;

@Controller
public class PaymentListController {
	
	@Autowired
	private EdmsService edmsService;
	
	@RequestMapping("payment")
	public String selectPaymentList() {
		
		return "approval/paymentList";
	}

}
