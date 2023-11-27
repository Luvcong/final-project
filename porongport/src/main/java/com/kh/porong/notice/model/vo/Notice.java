package com.kh.porong.notice.model.vo;

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
//	private String modifyDate;		// 현재 DB컬럼에 없음 추가해야함
	private String noticeStatus;
	private int noticeCount;
	private String noticeType;
	
	private String deptName;
	private String empName;
	private int empNo;
	private String jobName;
	private int replyCount;
	private String originFileName;
	private String changeFileName;
	
}	// end class
