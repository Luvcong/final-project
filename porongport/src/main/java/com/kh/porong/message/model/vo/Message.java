package com.kh.porong.message.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Message {
	
	private int messageNo;
	private String messageContent;
	private String createDate;
	private String defaultDate;
	private String messageStatus;
	private String sendUser;
	private String receiveUser;
	private int fileNo;
	
	private String empName;
	private String jobName;
	
	private int messageRank;
	
	
}	// end class
