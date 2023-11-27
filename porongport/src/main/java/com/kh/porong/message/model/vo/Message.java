package com.kh.porong.message.model.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Message {
	
	private int messageNo;
	private String messageContent;
	private String createDate;
	private String deleteDate;
	private String messageStatus;
	private int sendUser;
	private int receiveUser;
	private String originFileName;
	private String changeFileName;
	
	private String empName;
	private String jobName;
	private String deptName;
	
	private int messageRank;
	private String effectiveDate;
	private String readYN;
	private String bookmarkYN;
	private String messageType;
	
	
	
}	// end class
