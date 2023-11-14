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
	private int sendUser;
	private int reciveUser;
	private int fileNo;
	
}	// end class
