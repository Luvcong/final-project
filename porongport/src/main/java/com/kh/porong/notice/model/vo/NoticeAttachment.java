package com.kh.porong.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class NoticeAttachment {

	private int noticeFileNo;
	private String originFileName;
	private String changeFileName;
	private String filePath;
	private int noticeNo;
}	// end class
