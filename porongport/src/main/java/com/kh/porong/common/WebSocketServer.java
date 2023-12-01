package com.kh.porong.common;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.porong.employee.model.service.EmployeeService;

public class WebSocketServer extends TextWebSocketHandler{

	@Autowired
	private EmployeeService empService;  
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		// System.out.println(session.getAttributes());
		// System.out.println(session.getAttributes().get("empNo"));
		
		// System.out.println(empService.pwdAlert(session.getAttributes()));
		
		if(empService.pwdAlert(session.getAttributes()) > 0) {
			session.sendMessage(new TextMessage("Y"));
		} 
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		session.close();
	}

}
