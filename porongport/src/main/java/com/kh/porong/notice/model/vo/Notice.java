package com.kh.porong.notice.model.vo;

import java.util.List;

import com.kh.porong.employee.model.vo.Employee;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Notice {
	
	private int noticeNo;
	private int noticeWriter;
	private String noticeTitle;
	private String noticeContent;
	private String createDate;
	private String modifyDate;		// 현재 DB컬럼에 없음 추가해야함
	private String noticeStatus;
	private int noticeCount;
	private String noticeType;
	
	private int replyCount;
	private String originFileName;
	private String changeFileName;
	private int noticeLikeCount;
	private int attCount;
	private String filePath;
	
	private List<Employee> empList;
	
}	// end class
