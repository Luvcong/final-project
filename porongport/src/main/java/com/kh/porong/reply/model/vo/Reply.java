package com.kh.porong.reply.model.vo;

import java.util.List;

import com.kh.porong.employee.model.vo.Employee;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Reply {
	
	private int replyNo;
	private int noticeNo;
	private int boardNo;
	private int replyWriter;
	private String replyContent;
	private String replyDate;
	private String replyStatus;
	
	private List<Employee> empList;

	
	
}	// end class
