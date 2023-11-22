package com.kh.porong.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class NoticeLike {

	private int noticeLikeNo;
	private int noticeNo;
	private int empNo;
	private String noticeLike;
	
}	// end class
