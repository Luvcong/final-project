package com.kh.porong.common.interceptor;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import com.kh.porong.employee.model.vo.Employee;

public class WebSocketInterceptor implements HandshakeInterceptor{

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {

		ServletServerHttpRequest requ = (ServletServerHttpRequest)request;
		HttpSession session = requ.getServletRequest().getSession();
		
		Employee emp = (Employee)session.getAttribute("loginUser");
		
		attributes.put("empNo", emp.getEmpNo());
		
		return true;
	}
	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {
	}
}
